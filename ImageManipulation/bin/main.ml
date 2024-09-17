(* @author Mohit Soni (ms3734), Saksham Diwan (sd966), Timothy Lin (tql4)*)

open ImageManipulation

let checks_ends_with to_check name =
  let check_len = String.length to_check in
  let name_len = String.length name in
  if check_len > name_len then false
  else
    let end_chars = String.sub name (name_len - check_len) check_len in
    if end_chars = to_check then true else false

let transform_lst file_path transform_jpg transform_png =
  let file_type = if checks_ends_with ".png" file_path then "png" else "jpeg" in
  if file_type = "jpeg" then
    let image_jpg_option = Jpegimg.load_image ("bin/" ^ file_path) in
    let image_jpg =
      match image_jpg_option with
      | Some img -> Jpegimg.image_to_list img
      | None -> failwith "Could not read image"
    in
    let transformed_lst = transform_jpg image_jpg in
    let rgb24_image = Jpegimg.list_to_image transformed_lst in
    Jpegimg.save_image rgb24_image
  else
    let image_png_option = Pngimg.load_image ("bin/" ^ file_path) in
    let image_png =
      match image_png_option with
      | Some img -> Pngimg.image_to_list img
      | None -> failwith "Could not read image"
    in
    let transformed_lst = transform_png image_png in
    let rgba32_image = Pngimg.list_to_image transformed_lst in
    Pngimg.save_image rgba32_image

let args = Sys.argv

let perform_trans file_path jpg_fun png_fun =
  try
    transform_lst file_path jpg_fun png_fun;
    print_endline "Transformed image saved."
  with Failure _ ->
    print_endline
      "The encoding of your image is not compatible with the system. Please \
       try another image."

let perform_trans_param file_path jpg_fun png_fun param =
  try
    transform_lst file_path
      (fun imglst -> jpg_fun imglst param)
      (fun imglst -> png_fun imglst param);
    print_endline "Transformed image saved."
  with Failure _ ->
    print_endline
      "The encoding of your image is not compatible with the system. Please \
       try another image."

let perform_trans_sat file_path jpg_fun png_fun param =
  try
    transform_lst file_path (jpg_fun param) (png_fun param);
    print_endline "Transformed image saved."
  with Failure _ ->
    print_endline
      "The encoding of your image is not compatible with the system. Please \
       try another image."

let _ =
  if Array.length args = 4 then
    let image_file_path = args.(1) in
    let transformation = args.(2) in
    let param = float_of_string args.(3) in
    if transformation = "brighten" then
      perform_trans_param image_file_path Jpegimg.brighten Pngimg.brighten param
    else if transformation = "dim" then
      perform_trans_param image_file_path Jpegimg.dim Pngimg.dim param
    else if transformation = "saturate" then
      perform_trans_sat image_file_path Jpegimg.saturate Pngimg.saturate param
    else if transformation = "saturatev2" then
      perform_trans_sat image_file_path Jpegimg.saturate_v2 Pngimg.saturate_v2
        param
    else
      print_endline
        ("Error: " ^ transformation
       ^ " is not a valid transformation based on the number of parameters \
          given.")
  else if Array.length args = 3 then
    let image_file_path = args.(1) in
    let transformation = args.(2) in
    if transformation = "grayscale" then
      perform_trans image_file_path Jpegimg.grayscale Pngimg.grayscale
    else if transformation = "verticalflip" then
      perform_trans image_file_path Jpegimg.vertical_flip Pngimg.vertical_flip
    else if transformation = "horizontalflip" then
      perform_trans image_file_path Jpegimg.horizontal_flip Pngimg.horizontal_flip
    else if transformation = "rotate90clockwise" then
      perform_trans image_file_path Jpegimg.rotate_90_clockwise
        Pngimg.rotate_90_clockwise
    else if transformation = "rotate270clockwise" then
      perform_trans image_file_path Jpegimg.rotate_270_clockwise
        Pngimg.rotate_270_clockwise
    else if transformation = "add3Deffect" then
      perform_trans image_file_path Jpegimg.add_3d_effect Pngimg.add_3d_effect
    else if transformation = "blur" then
      perform_trans image_file_path Jpegimg.blur Pngimg.blur
    else if transformation = "smootherblur" then
      perform_trans image_file_path Jpegimg.smoother_blur Pngimg.smoother_blur
    else if transformation = "sharpen" then
      perform_trans image_file_path Jpegimg.sharpen Pngimg.sharpen
    else if transformation = "outline" then
      perform_trans image_file_path Jpegimg.outline Pngimg.outline
    else if transformation = "verticaledgedetection" then
      perform_trans image_file_path Jpegimg.vertical_edge_detection
        Pngimg.vertical_edge_detection
    else if transformation = "horizontaledgedetection" then
      perform_trans image_file_path Jpegimg.horizontal_edge_detection
        Pngimg.horizontal_edge_detection
    else if transformation = "unsharp" then
      perform_trans image_file_path Jpegimg.unsharp Pngimg.unsharp
    else if transformation = "dilation" then
      perform_trans image_file_path Jpegimg.dilation Pngimg.dilation
    else if transformation = "erosion" then
      perform_trans image_file_path Jpegimg.erosion Pngimg.erosion
    else if transformation = "motionblur" then
      perform_trans image_file_path Jpegimg.motion_blur Pngimg.motion_blur
    else if transformation = "reversecolor" then
      perform_trans image_file_path Jpegimg.reverse_color Pngimg.reverse_color
    else
      print_endline
        ("Error: " ^ transformation
       ^ " is not a valid transformation based on the number of parameters \
          given.")
  else print_endline "Error: Incorrect number\n   of parameters given."
