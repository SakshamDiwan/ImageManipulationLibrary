open Images
open Rgb24

(* source: https://ocaml.org/p/camlimages/5.0.4-1/doc/Ppm/index.html (used to
   read and save images) *)

type t = Rgb24.t

let load_image filename =
  try
    match Jpeg.load filename [] with
    | Rgb24 img -> Some img
    | _ -> None
  with error ->
    let error_message = Printexc.to_string error in
    Printf.eprintf "Failed to load image: %s\n" error_message;
    None (* Source: https://ocaml.org/docs/error-handling section on Printing *)

let image_to_list image =
  let num_columns = image.width in
  let num_rows = image.height in
  let list_rep = ref [] in
  for row = 0 to num_rows - 1 do
    let one_row_lst = ref [] in
    for col = 0 to num_columns - 1 do
      let { r = red_val; g = green_val; b = blue_val } =
        Rgb24.get image col row
        (* row col, more intutive, throws Image.Out_of_image exception *)
      in
      one_row_lst := (red_val, green_val, blue_val) :: !one_row_lst
    done;
    list_rep :=
      List.rev !one_row_lst :: !list_rep (* List.rev to tackle nature of cons *)
  done;
  List.rev !list_rep

let list_to_image image_lst =
  let num_rows = List.length image_lst in
  let num_cols =
    match image_lst with
    | [] -> failwith "Cannnot work with empty images"
    | head :: _ -> List.length head
  in
  (* Create a new Rgb24 image *)
  let image = Rgb24.create num_cols num_rows in
  List.iteri
    (fun row_index one_row ->
      List.iteri
        (fun col_index (red_val, green_val, blue_val) ->
          Rgb24.set image col_index row_index
            { r = red_val; g = green_val; b = blue_val })
        one_row)
    image_lst;
  (* Source: https://v2.ocaml.org/api/List.html List.iteri documentation *)
  image

let save_image image = Jpeg.save "transformed.jpeg" [] (Rgb24 image)

(** [grayscale_tuple r g b] grayscales one triple at a time. *)
let grayscale_tuple r g b = ((r + g + b) / 3, (r + g + b) / 3, (r + g + b) / 3)

(** [grayscale_row row] is the list of int triples representing a single row of
    an Rgb24 image with the grayscale transformation applied *)
let rec grayscale_row row =
  match row with
  | [] -> row
  | (r, g, b) :: tail ->
      let transformed_tup = grayscale_tuple r g b in
      transformed_tup :: grayscale_row tail

let rec grayscale imglst =
  match imglst with
  | [] -> imglst
  | head :: tail -> grayscale_row head :: grayscale tail

(** [flip_row row] is the reversed row of int triples representing a row of
    pixels in an Rgb24 image. *)
let flip_row row = List.rev row

let rec horizontal_flip imglst =
  match imglst with
  | [] -> imglst
  | head :: tail -> flip_row head :: horizontal_flip tail

let vertical_flip imglst = List.rev imglst

(** [transform_brightness_value value factor] changes the brightness of one
    color at a time as determined by [factor]. *)
let transform_brightness_value value factor =
  let transformed_val = int_of_float (float_of_int value *. (1.0 +. factor)) in
  if factor < 0.0 then if transformed_val < 0 then 0 else transformed_val
  else if transformed_val > 255 then 255
  else transformed_val

(** [change_brightness_tuple r g b factor] changes the brightness of one triple
    at a time as determined by [factor]. *)
let change_brightness_tuple r g b factor =
  ( transform_brightness_value r factor,
    transform_brightness_value g factor,
    transform_brightness_value b factor )

(** [change_brightness_row row factor] is the list of int triples representing a
    single row of an Rgb24 image with the brightness changing transformation
    applied *)
let rec change_brightness_row row factor =
  match row with
  | [] -> row
  | (r, g, b) :: tail ->
      let transformed_tup = change_brightness_tuple r g b factor in
      transformed_tup :: change_brightness_row tail factor

let rec brighten imglst factor =
  match imglst with
  | [] -> imglst
  | head :: tail -> change_brightness_row head factor :: brighten tail factor

let rec dim imglst factor =
  match imglst with
  | [] -> imglst
  | head :: tail -> change_brightness_row head factor :: dim tail factor

let rotate_90_clockwise imglst =
  let transpose_lst =
    let rec transpose' acc = function
      | [] | [] :: _ -> List.rev acc
      | ls -> transpose' (List.map List.hd ls :: acc) (List.map List.tl ls)
    in
    transpose' [] imglst
  in
  horizontal_flip transpose_lst

let rotate_270_clockwise imglst = horizontal_flip (rotate_90_clockwise imglst)

(** [get_pixel_value imglst x y] is the triple representing the Rgb value of
    [imglst] at row index [x] and column index [y]. *)
let get_pixel_value imglst x y =
  if
    x >= 0 && y >= 0
    && y < List.length imglst
    && x < List.length (List.hd imglst)
  then List.nth (List.nth imglst y) x
  else (0, 0, 0)

(** [convolve_pixel kernel imglst x y] is the triple of Rgb values after the
    kernel matrix [kernel] has been applied to the image [imglst] at the row
    index [x] and column index [y]. *)
let convolve_pixel kernel imglst x y =
  let kernel_height = List.length kernel in
  let kernel_width = List.length (List.hd kernel) in

  (* Function to convolve each channel (R, G, B) *)
  let convolve_channel channel =
    let sum = ref 0 in
    for i = 0 to kernel_height - 1 do
      for j = 0 to kernel_width - 1 do
        let kernel_value = List.nth (List.nth kernel i) j in
        let pixel_value =
          get_pixel_value imglst
            (x + j - (kernel_width / 2))
            (y + i - (kernel_height / 2))
          |> channel
        in
        sum :=
          !sum + int_of_float (floor (kernel_value *. float_of_int pixel_value))
      done
    done;
    (* Clamping the result between 0 and 255 *) max 0 (min 255 !sum)
  in
  let r = convolve_channel (fun (r, _, _) -> r) in
  let g = convolve_channel (fun (_, g, _) -> g) in
  let b = convolve_channel (fun (_, _, b) -> b) in
  (r, g, b)

(** [apply_kernel imglst kernel] is the list of lists of int triples after the
    kernel matrix [kernel] has been applied to the image [imglst] (Rgb24 image). *)
let apply_kernel imglst kernel =
  let convolve_row y =
    List.init (List.length imglst) (fun x -> convolve_pixel kernel imglst x y)
  in
  List.init (List.length (List.hd imglst)) convolve_row

(** [multiply_triple (r, g, b) multiply_val] is the triple after multiplying
    each element of the triple [(r, g, b)] with [multiply_val]. *)
let multiply_triple (r, g, b) multiply_val =
  (r * multiply_val, g * multiply_val, b * multiply_val)

(** [add_triples (r1, g1, b1) (r2, g2, b2)] is the triple after adding each
    element of the triples [(r1, g1, b1)] and [(r2, g2, b2)]. *)
let add_triples (r1, g1, b1) (r2, g2, b2) = (r1 + r2, g1 + g2, b1 + b2)

(** [refactor_task previous_img q1_x q1_y q2_x q2_y q1_multiply q2_multiply]
    helps refactor the code in resize_img to make it shorter and avoid
    duplication of code. *)
let refactor_task previous_img q1_x q1_y q2_x q2_y q1_multiply q2_multiply =
  let q1 = List.nth (List.nth previous_img q1_x) q1_y in
  let q2 = List.nth (List.nth previous_img q2_x) q2_y in
  let changed_q1 = multiply_triple q1 q1_multiply in
  let changed_q2 = multiply_triple q2 q2_multiply in
  add_triples changed_q1 changed_q2

(** [resize_img imglst resize_row resize_col] is the list of lists of int
    triples after resizing the image to be of dimensions [resize_row] *
    [resize_col]. *)
let resize_img imglst resize_row resize_col =
  let resize_helper previous_img new_row new_col =
    let prev_row = List.length previous_img in
    let prev_col = List.length (List.hd previous_img) in
    let resize_img = Array.make_matrix new_row new_col (0, 0, 0) in
    let row_scale_factor = float_of_int prev_row /. float_of_int new_row in
    let col_scale_factor = float_of_int prev_col /. float_of_int new_col in
    for i = 0 to new_row - 1 do
      for j = 0 to new_col - 1 do
        let x = float_of_int i *. row_scale_factor in
        let y = float_of_int j *. col_scale_factor in
        let x_floor = int_of_float (floor x) in
        let x_ceil = min (prev_row - 1) (int_of_float (ceil x)) in
        let y_floor = int_of_float (floor y) in
        let y_ceil = min (prev_col - 1) (int_of_float (ceil y)) in
        if x_ceil = x_floor && y_ceil = y_floor then
          resize_img.(i).(j) <- List.nth (List.nth previous_img x_floor) y_floor
        else if x_ceil = x_floor then
          resize_img.(i).(j) <-
            refactor_task previous_img x_floor y_floor x_floor y_ceil
              (y_ceil - int_of_float y)
              (int_of_float y - y_floor)
        else if y_ceil = y_floor then
          resize_img.(i).(j) <-
            refactor_task previous_img x_floor y_floor x_ceil y_floor
              (x_ceil - int_of_float x)
              (int_of_float x - x_floor)
        else
          let q1 =
            refactor_task previous_img x_floor y_floor x_ceil y_floor
              (x_ceil - int_of_float x)
              (int_of_float x - x_floor)
          in
          let q2 =
            refactor_task previous_img x_floor y_ceil x_ceil y_ceil
              (x_ceil - int_of_float x)
              (int_of_float x - x_floor)
          in
          let changed_q1 = multiply_triple q1 (y_ceil - int_of_float y) in
          let changed_q2 = multiply_triple q2 (int_of_float y - y_floor) in
          resize_img.(i).(j) <- add_triples changed_q1 changed_q2
      done
    done;
    Array.to_list (Array.map Array.to_list resize_img)
  in
  resize_helper imglst resize_row resize_col

(* Credits / Source:
   https://meghal-darji.medium.com/implementing-bilinear-interpolation-for-image-resizing-357cbb2c2722 *)

(** [check_low_dimensions imglst kernel] is the list of lists of int triples
    after applying the [kernel] on [imglst] according to the dimensions of
    [imglst]. *)
let check_low_dimensions imglst kernel =
  let dim1 = List.length imglst in
  let dim2 = List.length (List.nth imglst 0) in
  if dim1 <= 400 && dim2 <= 400 then apply_kernel imglst kernel
  else apply_kernel (resize_img imglst 400 400) kernel

let add_3d_effect imglst =
  let kernel = [ [ -2.0; -1.0; 0.0 ]; [ -1.0; 1.0; 1.0 ]; [ 0.0; 1.0; 2.0 ] ] in
  check_low_dimensions imglst kernel

let blur imglst =
  let kernel =
    [
      [ 1. /. 9.; 1. /. 9.; 1. /. 9. ];
      [ 1. /. 9.; 1. /. 9.; 1. /. 9. ];
      [ 1. /. 9.; 1. /. 9.; 1. /. 9. ];
    ]
  in
  check_low_dimensions imglst kernel

let smoother_blur imglst =
  let kernel =
    [
      [ 1. /. 16.; 1. /. 8.; 1. /. 16. ];
      [ 1. /. 8.; 1. /. 4.; 1. /. 8. ];
      [ 1. /. 16.; 1. /. 8.; 1. /. 16. ];
    ]
  in
  check_low_dimensions imglst kernel

let sharpen imglst =
  let kernel =
    [ [ 0.0; -1.0; 0.0 ]; [ -1.0; 5.0; -1.0 ]; [ 0.0; -1.0; 0.0 ] ]
  in
  check_low_dimensions imglst kernel

let outline imglst =
  let kernel =
    [ [ -1.0; -1.0; -1.0 ]; [ -1.0; 8.0; -1.0 ]; [ -1.0; -1.0; -1.0 ] ]
  in
  check_low_dimensions imglst kernel

let vertical_edge_detection imglst =
  let kernel = [ [ -1.0; 0.0; 1.0 ]; [ -1.0; 0.0; 1.0 ]; [ -1.0; 0.0; 1.0 ] ] in
  check_low_dimensions imglst kernel

let horizontal_edge_detection imglst =
  let kernel = [ [ -1.0; -1.0; -1.0 ]; [ 0.0; 0.0; 0.0 ]; [ 1.0; 1.0; 1.0 ] ] in
  check_low_dimensions imglst kernel

let unsharp imglst =
  let kernel =
    [ [ -1.0; -1.0; -1.0 ]; [ -1.0; 9.0; -1.0 ]; [ -1.0; -1.0; -1.0 ] ]
  in
  check_low_dimensions imglst kernel

let dilation imglst =
  let kernel = [ [ 0.0; 1.0; 0.0 ]; [ 1.0; 1.0; 1.0 ]; [ 0.0; 1.0; 0.0 ] ] in
  check_low_dimensions imglst kernel

let erosion imglst =
  let kernel = [ [ 0.0; 1.0; 0.0 ]; [ 1.0; 0.0; 1.0 ]; [ 0.0; 1.0; 0.0 ] ] in
  check_low_dimensions imglst kernel

let motion_blur imglst =
  let kernel =
    [
      [ 1. /. 9.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0. ];
      [ 0.; 1. /. 9.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0. ];
      [ 0.; 0.; 1. /. 9.; 0.; 0.; 0.; 0.; 0.; 0.; 0. ];
      [ 0.; 0.; 0.; 1. /. 9.; 0.; 0.; 0.; 0.; 0.; 0. ];
      [ 0.; 0.; 0.; 0.; 1. /. 9.; 0.; 0.; 0.; 0.; 0. ];
      [ 0.; 0.; 0.; 0.; 0.; 1. /. 9.; 0.; 0.; 0.; 0. ];
      [ 0.; 0.; 0.; 0.; 0.; 0.; 1. /. 9.; 0.; 0.; 0. ];
      [ 0.; 0.; 0.; 0.; 0.; 0.; 0.; 1. /. 9.; 0.; 0. ];
      [ 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 1. /. 9.; 0. ];
      [ 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 1. /. 9. ];
    ]
  in
  check_low_dimensions imglst kernel

(** [max_color (r, g, b)] is the greatest value between [r], [g], and [b]. *)
let max_color (r, g, b) =
  if r >= g && r >= b then r else if g >= r && g >= b then g else b

(** [min_color (r, g, b)] is the smallest value between [r], [g], and [b]. *)
let min_color (r, g, b) =
  if r <= g && r <= b then r else if g <= r && g <= b then g else b

(** [scale255 c] is the float representing [c] divided by 255. *)
let scale255 c = float_of_int c /. 255.0

(** [calc_hue cmax delta r1 g1 b1] is the hue calculated from the max color
    [cmax], [delta], and the rgb values [r1], [g1], and [b1]. If [delta] is 0,
    then the calculated hue is 0. *)
let calc_hue cmax delta r1 g1 b1 =
  if delta = 0.0 then 0.0
  else if cmax = r1 then
    mod_float ((60.0 *. (g1 -. b1) /. delta) +. 360.0) 360.0
  else if cmax = g1 then
    mod_float ((60.0 *. (b1 -. r1) /. delta) +. 120.0) 360.0
  else mod_float ((60.0 *. (r1 -. g1) /. delta) +. 240.0) 360.0

(** [calc_sat max delta] is the saturation calculated from the max color [cmax]
    and [delta]. If [cmax] is 0, then the calculated saturation is 0. *)
let calc_sat cmax delta = if cmax = 0.0 then 0.0 else delta /. cmax

(** [rgb_to_hsv (r, g, b)] is the hsv representation of the given [r], [g], [b]
    values as a triple of floats. *)
let rgb_to_hsv (r, g, b) =
  let r1 = scale255 r in
  let g1 = scale255 g in
  let b1 = scale255 b in
  let cmax = max_color (r1, g1, b1) in
  let cmin = min_color (r1, g1, b1) in
  let delta = cmax -. cmin in
  let hue = calc_hue cmax delta r1 g1 b1 in
  let sat = calc_sat cmax delta in
  let value = cmax in
  (hue, sat, value)

(** [rescale_rgb m (r, g, b)] is the rescaled version of the given [r], [g], [b]
    values based on the addition factor [m]. *)
let rescale_rgb m (r, g, b) =
  ( int_of_float ((r +. m) *. 255.0),
    int_of_float ((g +. m) *. 255.0),
    int_of_float ((b +. m) *. 255.0) )

(** [calc_cx h c x m] is the value calculated for the third value of the hsv
    color spectrum from the parameters [h], [c], [x], and [m]. *)
let calc_cx h c x m =
  let tup =
    if h >= 0.0 && h < 60.0 then (c, x, 0.0)
    else if h >= 60.0 && h < 120.0 then (x, c, 0.0)
    else if h >= 120.0 && h < 180.0 then (0.0, c, x)
    else if h >= 180.0 && h < 240.0 then (0.0, x, c)
    else if h >= 240.0 && h < 300.0 then (x, 0.0, c)
    else (c, 0.0, x)
  in
  rescale_rgb m tup

(** [hsv_to_rgb (hue, sat, value)] is the rgb representation of the given [hue],
    [sat], [value] values as a triple of integers. *)
let hsv_to_rgb (hue, sat, value) =
  let c = value *. sat in
  let x = c *. (1.0 -. abs_float (mod_float (hue /. 60.0) 2.0 -. 1.0)) in
  let m = value -. c in
  calc_cx hue c x m

(** [saturate_tuple_helper c gray factor] is the saturation calculated from the
    parameters [c], [gray], and the given factor [factor]. *)
let saturate_tuple_helper c gray factor =
  max
    (min
       (int_of_float
          ((float_of_int (-1 * gray) *. factor)
          +. (float_of_int c *. (1.0 +. factor))))
       255)
    0

(** [saturate_tuple factor px] is the int triple representation of a pixel with
    saturation increased by factor [factor]. *)
let saturate_tuple factor (r, g, b) =
  let gray = (r + g + b) / 3 in
  let r2 = saturate_tuple_helper r gray factor in
  let g2 = saturate_tuple_helper g gray factor in
  let b2 = saturate_tuple_helper b gray factor in
  (r2, g2, b2)

(** [saturate_row row factor] is the list of int tuples representing a single
    row of an Rgba24 image with saturation increased by the given factor.*)
let saturate_row factor row = List.map (saturate_tuple factor) row

let saturate factor imglst = List.map (saturate_row factor) imglst

(** [saturate_tuple_v2 factor px] is the saturated rgb values of the original
    rgb values [px] by the factor [factor]. *)
let saturate_tuple_v2 factor px =
  match rgb_to_hsv px with
  | h, s, v -> hsv_to_rgb (h, min (s *. factor) 1.0, v)

let saturate_v2 factor imglst =
  List.map (List.map (saturate_tuple_v2 factor)) imglst

(** [reverse_color_tuple r g b] color reverses one tuple at a time. *)
let reverse_color_tuple r g b = (255 - r, 255 - g, 255 - b)

(** [reverse_color_row row] is the list of int tuples representing a single row
    of an Rgb24 image with the colors reversed. *)
let rec reverse_color_row row =
  match row with
  | [] -> row
  | (r, g, b) :: tail ->
      let transformed_tup = reverse_color_tuple r g b in
      transformed_tup :: reverse_color_row tail

let rec reverse_color imglst =
  match imglst with
  | [] -> imglst
  | head :: tail -> reverse_color_row head :: reverse_color tail
