open OUnit2
open ImageManipulation

let jpg_img =
  [
    [ (100, 100, 100); (100, 100, 100); (100, 100, 80) ];
    [ (100, 100, 100); (200, 100, 150); (100, 100, 100) ];
    [ (80, 100, 100); (100, 100, 100); (100, 100, 100) ];
  ]

let grayscale_result =
  [
    [ (100, 100, 100); (100, 100, 100); (93, 93, 93) ];
    [ (100, 100, 100); (150, 150, 150); (100, 100, 100) ];
    [ (93, 93, 93); (100, 100, 100); (100, 100, 100) ];
  ]

let vertical_flip_result =
  [
    [ (80, 100, 100); (100, 100, 100); (100, 100, 100) ];
    [ (100, 100, 100); (200, 100, 150); (100, 100, 100) ];
    [ (100, 100, 100); (100, 100, 100); (100, 100, 80) ];
  ]

let horizontal_flip_result =
  [
    [ (100, 100, 80); (100, 100, 100); (100, 100, 100) ];
    [ (100, 100, 100); (200, 100, 150); (100, 100, 100) ];
    [ (100, 100, 100); (100, 100, 100); (80, 100, 100) ];
  ]

let brighten_result =
  [
    [ (190, 190, 190); (190, 190, 190); (190, 190, 152) ];
    [ (190, 190, 190); (255, 190, 255); (190, 190, 190) ];
    [ (152, 190, 190); (190, 190, 190); (190, 190, 190) ];
  ]

let dim_result =
  [
    [ (9, 9, 9); (9, 9, 9); (9, 9, 7) ];
    [ (9, 9, 9); (19, 9, 14); (9, 9, 9) ];
    [ (7, 9, 9); (9, 9, 9); (9, 9, 9) ];
  ]

let rotate_90_clockwise_result =
  [
    [ (80, 100, 100); (100, 100, 100); (100, 100, 100) ];
    [ (100, 100, 100); (200, 100, 150); (100, 100, 100) ];
    [ (100, 100, 100); (100, 100, 100); (100, 100, 80) ];
  ]

let rotate_270_clockwise_result =
  [
    [ (100, 100, 100); (100, 100, 100); (80, 100, 100) ];
    [ (100, 100, 100); (200, 100, 150); (100, 100, 100) ];
    [ (100, 100, 80); (100, 100, 100); (100, 100, 100) ];
  ]

let add_3d_effect_result =
  [
    [ (255, 255, 255); (255, 255, 255); (100, 100, 80) ];
    [ (255, 255, 255); (200, 100, 150); (0, 0, 0) ];
    [ (80, 100, 100); (0, 0, 0); (0, 0, 0) ];
  ]

let blur_result =
  [
    [ (55, 44, 49); (77, 66, 68); (55, 44, 46) ];
    [ (74, 66, 71); (107, 99, 101); (77, 66, 68) ];
    [ (52, 44, 49); (74, 66, 71); (55, 44, 49) ];
  ]

let smoother_blur_result =
  [
    [ (61, 55, 58); (86, 73, 77); (61, 55, 53) ];
    [ (84, 73, 79); (121, 97, 108); (86, 73, 77) ];
    [ (56, 55, 58); (84, 73, 79); (61, 55, 58) ];
  ]

let sharpen_result =
  [
    [ (255, 255, 255); (100, 200, 170); (255, 255, 200) ];
    [ (120, 200, 150); (255, 100, 255); (100, 200, 170) ];
    [ (200, 255, 255); (120, 200, 150); (255, 255, 255) ];
  ]

let outline_result =
  [
    [ (255, 255, 255); (200, 255, 255); (255, 255, 255) ];
    [ (220, 255, 250); (255, 0, 255); (200, 255, 255) ];
    [ (240, 255, 255); (220, 255, 250); (255, 255, 255) ];
  ]

let vertical_edge_detection_result =
  [
    [ (255, 200, 250); (0, 0, 0); (0, 0, 0) ];
    [ (255, 255, 255); (20, 0, 0); (0, 0, 0) ];
    [ (255, 200, 250); (20, 0, 0); (0, 0, 0) ];
  ]

let horizontal_edge_detection_result =
  [
    [ (255, 200, 250); (255, 255, 255); (255, 200, 250) ];
    [ (0, 0, 0); (0, 0, 20); (0, 0, 20) ];
    [ (0, 0, 0); (0, 0, 0); (0, 0, 0) ];
  ]

let unsharp_result =
  [
    [ (255, 255, 255); (255, 255, 255); (255, 255, 255) ];
    [ (255, 255, 255); (255, 100, 255); (255, 255, 255) ];
    [ (255, 255, 255); (255, 255, 255); (255, 255, 255) ];
  ]

let dilation_result =
  [
    [ (255, 255, 255); (255, 255, 255); (255, 255, 255) ];
    [ (255, 255, 255); (255, 255, 255); (255, 255, 255) ];
    [ (255, 255, 255); (255, 255, 255); (255, 255, 255) ];
  ]

let erosion_result =
  [
    [ (200, 200, 200); (255, 255, 255); (200, 200, 200) ];
    [ (255, 255, 255); (255, 255, 255); (255, 255, 255) ];
    [ (200, 200, 200); (255, 255, 255); (200, 200, 200) ];
  ]

let motion_blur_result =
  [
    [ (44, 33, 38); (22, 22, 22); (11, 11, 8) ];
    [ (22, 22, 22); (44, 33, 38); (22, 22, 22) ];
    [ (8, 11, 11); (22, 22, 22); (44, 33, 38) ];
  ]

let saturate_result =
  [
    [ (100, 100, 100); (100, 100, 100); (114, 114, 54) ];
    [ (100, 100, 100); (255, 0, 150); (100, 100, 100) ];
    [ (54, 114, 114); (100, 100, 100); (100, 100, 100) ];
  ]

let saturate_v2_result =
  [
    [ (100, 100, 100); (100, 100, 100); (100, 100, 60) ];
    [ (100, 100, 100); (200, 0, 100); (100, 100, 100) ];
    [ (60, 100, 100); (100, 100, 100); (100, 100, 100) ];
  ]

let reverse_color_result =
  [
    [ (155, 155, 155); (155, 155, 155); (155, 155, 175) ];
    [ (155, 155, 155); (55, 155, 105); (155, 155, 155) ];
    [ (175, 155, 155); (155, 155, 155); (155, 155, 155) ];
  ]

let jpg_tests =
  "test suite for Jpegimg"
  >::: [
         ( "grayscale" >:: fun _ ->
           assert_equal (Jpegimg.grayscale jpg_img) grayscale_result );
         ( "vertical flip" >:: fun _ ->
           assert_equal (Jpegimg.vertical_flip jpg_img) vertical_flip_result );
         ( "horizontal flip" >:: fun _ ->
           assert_equal (Jpegimg.horizontal_flip jpg_img) horizontal_flip_result
         );
         ( "brighten 90%" >:: fun _ ->
           assert_equal (Jpegimg.brighten jpg_img 0.9) brighten_result );
         ( "dim 90%" >:: fun _ ->
           assert_equal (Jpegimg.dim jpg_img (-0.9)) dim_result );
         ( "rotate 90 clockwise" >:: fun _ ->
           assert_equal
             (Jpegimg.rotate_90_clockwise jpg_img)
             rotate_90_clockwise_result );
         ( "rotate 270 clockwise" >:: fun _ ->
           assert_equal
             (Jpegimg.rotate_270_clockwise jpg_img)
             rotate_270_clockwise_result );
         ( "add 3d effect" >:: fun _ ->
           assert_equal (Jpegimg.add_3d_effect jpg_img) add_3d_effect_result );
         ("blur" >:: fun _ -> assert_equal (Jpegimg.blur jpg_img) blur_result);
         ( "smoother_blur" >:: fun _ ->
           assert_equal (Jpegimg.smoother_blur jpg_img) smoother_blur_result );
         ( "sharpen" >:: fun _ ->
           assert_equal (Jpegimg.sharpen jpg_img) sharpen_result );
         ( "outline" >:: fun _ ->
           assert_equal (Jpegimg.outline jpg_img) outline_result );
         ( "vertical edge detection" >:: fun _ ->
           assert_equal
             (Jpegimg.vertical_edge_detection jpg_img)
             vertical_edge_detection_result );
         ( "horizontal edge detection" >:: fun _ ->
           assert_equal
             (Jpegimg.horizontal_edge_detection jpg_img)
             horizontal_edge_detection_result );
         ( "unsharp" >:: fun _ ->
           assert_equal (Jpegimg.unsharp jpg_img) unsharp_result );
         ( "dilation" >:: fun _ ->
           assert_equal (Jpegimg.dilation jpg_img) dilation_result );
         ( "erosion" >:: fun _ ->
           assert_equal (Jpegimg.erosion jpg_img) erosion_result );
         ( "motion blur" >:: fun _ ->
           assert_equal (Jpegimg.motion_blur jpg_img) motion_blur_result );
         ( "saturate 2x" >:: fun _ ->
           assert_equal (Jpegimg.saturate 2. jpg_img) saturate_result );
         ( "saturate v2 2x" >:: fun _ ->
           assert_equal (Jpegimg.saturate_v2 2. jpg_img) saturate_v2_result );
         ( "reverse_color" >:: fun _ ->
           assert_equal (Jpegimg.reverse_color jpg_img) reverse_color_result );
       ]

let png_image =
  [
    [ (100, 100, 100, 100); (100, 100, 100, 100); (100, 100, 100, 80) ];
    [ (100, 100, 100, 100); (200, 100, 150, 100); (100, 100, 100, 100) ];
    [ (80, 100, 100, 100); (100, 100, 100, 100); (100, 100, 100, 100) ];
  ]

let grayscale_result_png =
  [
    [ (100, 100, 100, 100); (100, 100, 100, 100); (100, 100, 100, 80) ];
    [ (100, 100, 100, 100); (150, 150, 150, 100); (100, 100, 100, 100) ];
    [ (93, 93, 93, 100); (100, 100, 100, 100); (100, 100, 100, 100) ];
  ]

let vertical_flip_result_png =
  [
    [ (80, 100, 100, 100); (100, 100, 100, 100); (100, 100, 100, 100) ];
    [ (100, 100, 100, 100); (200, 100, 150, 100); (100, 100, 100, 100) ];
    [ (100, 100, 100, 100); (100, 100, 100, 100); (100, 100, 100, 80) ];
  ]

let horizontal_flip_result_png =
  [
    [ (100, 100, 100, 80); (100, 100, 100, 100); (100, 100, 100, 100) ];
    [ (100, 100, 100, 100); (200, 100, 150, 100); (100, 100, 100, 100) ];
    [ (100, 100, 100, 100); (100, 100, 100, 100); (80, 100, 100, 100) ];
  ]

let brighten_result_png =
  [
    [ (190, 190, 190, 100); (190, 190, 190, 100); (190, 190, 190, 80) ];
    [ (190, 190, 190, 100); (255, 190, 255, 100); (190, 190, 190, 100) ];
    [ (152, 190, 190, 100); (190, 190, 190, 100); (190, 190, 190, 100) ];
  ]

let dim_result_png =
  [
    [ (9, 9, 9, 100); (9, 9, 9, 100); (9, 9, 9, 80) ];
    [ (9, 9, 9, 100); (19, 9, 14, 100); (9, 9, 9, 100) ];
    [ (7, 9, 9, 100); (9, 9, 9, 100); (9, 9, 9, 100) ];
  ]

let rotate_90_clockwise_result_png =
  [
    [ (80, 100, 100, 100); (100, 100, 100, 100); (100, 100, 100, 100) ];
    [ (100, 100, 100, 100); (200, 100, 150, 100); (100, 100, 100, 100) ];
    [ (100, 100, 100, 100); (100, 100, 100, 100); (100, 100, 100, 80) ];
  ]

let rotate_270_clockwise_result_png =
  [
    [ (100, 100, 100, 100); (100, 100, 100, 100); (80, 100, 100, 100) ];
    [ (100, 100, 100, 100); (200, 100, 150, 100); (100, 100, 100, 100) ];
    [ (100, 100, 100, 80); (100, 100, 100, 100); (100, 100, 100, 100) ];
  ]

let add_3d_effect_result_png =
  [
    [ (255, 255, 255, 255); (255, 255, 255, 255); (100, 100, 100, 80) ];
    [ (255, 255, 255, 255); (200, 100, 150, 100); (0, 0, 0, 0) ];
    [ (80, 100, 100, 100); (0, 0, 0, 0); (0, 0, 0, 0) ];
  ]

let blur_result_png =
  [
    [ (55, 44, 49, 44); (77, 66, 71, 63); (55, 44, 49, 41) ];
    [ (74, 66, 71, 66); (107, 99, 104, 96); (77, 66, 71, 63) ];
    [ (52, 44, 49, 44); (74, 66, 71, 66); (55, 44, 49, 44) ];
  ]

let smoother_blur_result_png =
  [
    [ (61, 55, 58, 55); (86, 73, 79, 71); (61, 55, 58, 50) ];
    [ (84, 73, 79, 73); (121, 97, 109, 96); (86, 73, 79, 71) ];
    [ (56, 55, 58, 55); (84, 73, 79, 73); (61, 55, 58, 55) ];
  ]

let sharpen_result_png =
  [
    [ (255, 255, 255, 255); (100, 200, 150, 220); (255, 255, 255, 200) ];
    [ (120, 200, 150, 200); (255, 100, 255, 100); (100, 200, 150, 220) ];
    [ (200, 255, 255, 255); (120, 200, 150, 200); (255, 255, 255, 255) ];
  ]

let outline_result_png =
  [
    [ (255, 255, 255, 255); (200, 255, 250, 255); (255, 255, 255, 255) ];
    [ (220, 255, 250, 255); (255, 0, 255, 20); (200, 255, 250, 255) ];
    [ (240, 255, 255, 255); (220, 255, 250, 255); (255, 255, 255, 255) ];
  ]

let vertical_edge_detection_result_png =
  [
    [ (255, 200, 250, 200); (0, 0, 0, 0); (0, 0, 0, 0) ];
    [ (255, 255, 255, 255); (20, 0, 0, 0); (0, 0, 0, 0) ];
    [ (255, 200, 250, 200); (20, 0, 0, 0); (0, 0, 0, 0) ];
  ]

let horizontal_edge_detection_result_png =
  [
    [ (255, 200, 250, 200); (255, 255, 255, 255); (255, 200, 250, 200) ];
    [ (0, 0, 0, 0); (0, 0, 0, 20); (0, 0, 0, 20) ];
    [ (0, 0, 0, 0); (0, 0, 0, 0); (0, 0, 0, 0) ];
  ]

let unsharp_result_png =
  [
    [ (255, 255, 255, 255); (255, 255, 255, 255); (255, 255, 255, 255) ];
    [ (255, 255, 255, 255); (255, 100, 255, 120); (255, 255, 255, 255) ];
    [ (255, 255, 255, 255); (255, 255, 255, 255); (255, 255, 255, 255) ];
  ]

let dilation_result_png =
  [
    [ (255, 255, 255, 255); (255, 255, 255, 255); (255, 255, 255, 255) ];
    [ (255, 255, 255, 255); (255, 255, 255, 255); (255, 255, 255, 255) ];
    [ (255, 255, 255, 255); (255, 255, 255, 255); (255, 255, 255, 255) ];
  ]

let erosion_result_png =
  [
    [ (200, 200, 200, 200); (255, 255, 255, 255); (200, 200, 200, 200) ];
    [ (255, 255, 255, 255); (255, 255, 255, 255); (255, 255, 255, 255) ];
    [ (200, 200, 200, 200); (255, 255, 255, 255); (200, 200, 200, 200) ];
  ]

let motion_blur_result_png =
  [
    [ (44, 33, 38, 33); (22, 22, 22, 22); (11, 11, 11, 8) ];
    [ (22, 22, 22, 22); (44, 33, 38, 33); (22, 22, 22, 22) ];
    [ (8, 11, 11, 11); (22, 22, 22, 22); (44, 33, 38, 33) ];
  ]

let saturate_result_png =
  [
    [ (100, 100, 100, 100); (100, 100, 100, 100); (100, 100, 100, 80) ];
    [ (100, 100, 100, 100); (255, 0, 150, 100); (100, 100, 100, 100) ];
    [ (54, 114, 114, 100); (100, 100, 100, 100); (100, 100, 100, 100) ];
  ]

let saturate_v2_result_png =
  [
    [ (100, 100, 100, 100); (100, 100, 100, 100); (100, 100, 100, 80) ];
    [ (100, 100, 100, 100); (200, 0, 100, 100); (100, 100, 100, 100) ];
    [ (60, 100, 100, 100); (100, 100, 100, 100); (100, 100, 100, 100) ];
  ]

let reverse_color_result_png =
  [
    [ (155, 155, 155, 100); (155, 155, 155, 100); (155, 155, 155, 80) ];
    [ (155, 155, 155, 100); (55, 155, 105, 100); (155, 155, 155, 100) ];
    [ (175, 155, 155, 100); (155, 155, 155, 100); (155, 155, 155, 100) ];
  ]

let png_tests =
  "test suite for Pngimg"
  >::: [
         ( "grayscale" >:: fun _ ->
           assert_equal (Pngimg.grayscale png_image) grayscale_result_png );
         ( "vertical flip" >:: fun _ ->
           assert_equal
             (Pngimg.vertical_flip png_image)
             vertical_flip_result_png );
         ( "horizontal flip" >:: fun _ ->
           assert_equal
             (Pngimg.horizontal_flip png_image)
             horizontal_flip_result_png );
         ( "brighten 90%" >:: fun _ ->
           assert_equal (Pngimg.brighten png_image 0.9) brighten_result_png );
         ( "dim 90%" >:: fun _ ->
           assert_equal (Pngimg.dim png_image (-0.9)) dim_result_png );
         ( "rotate 90 clockwise" >:: fun _ ->
           assert_equal
             (Pngimg.rotate_90_clockwise png_image)
             rotate_90_clockwise_result_png );
         ( "rotate 270 clockwise" >:: fun _ ->
           assert_equal
             (Pngimg.rotate_270_clockwise png_image)
             rotate_270_clockwise_result_png );
         ( "add 3d effect" >:: fun _ ->
           assert_equal
             (Pngimg.add_3d_effect png_image)
             add_3d_effect_result_png );
         ( "blur" >:: fun _ ->
           assert_equal (Pngimg.blur png_image) blur_result_png );
         ( "smoother_blur" >:: fun _ ->
           assert_equal
             (Pngimg.smoother_blur png_image)
             smoother_blur_result_png );
         ( "sharpen" >:: fun _ ->
           assert_equal (Pngimg.sharpen png_image) sharpen_result_png );
         ( "outline" >:: fun _ ->
           assert_equal (Pngimg.outline png_image) outline_result_png );
         ( "vertical edge detection" >:: fun _ ->
           assert_equal
             (Pngimg.vertical_edge_detection png_image)
             vertical_edge_detection_result_png );
         ( "horizontal edge detection" >:: fun _ ->
           assert_equal
             (Pngimg.horizontal_edge_detection png_image)
             horizontal_edge_detection_result_png );
         ( "unsharp" >:: fun _ ->
           assert_equal (Pngimg.unsharp png_image) unsharp_result_png );
         ( "dilation" >:: fun _ ->
           assert_equal (Pngimg.dilation png_image) dilation_result_png );
         ( "erosion" >:: fun _ ->
           assert_equal (Pngimg.erosion png_image) erosion_result_png );
         ( "motion blur" >:: fun _ ->
           assert_equal (Pngimg.motion_blur png_image) motion_blur_result_png );
         ( "saturate 2x" >:: fun _ ->
           assert_equal (Pngimg.saturate 2. png_image) saturate_result_png );
         ( "saturate v2 2x" >:: fun _ ->
           assert_equal (Pngimg.saturate_v2 2. png_image) saturate_v2_result_png
         );
         ( "reverse_color" >:: fun _ ->
           assert_equal
             (Pngimg.reverse_color png_image)
             reverse_color_result_png );
       ]

let _ = run_test_tt_main jpg_tests
let _ = run_test_tt_main png_tests

open QCheck2

(* Jpeg property testing *)
let generate_random_pixel_jpg =
  let r_value = Gen.int_bound 255 in
  (* Source:
     https://c-cube.github.io/qcheck/0.17/qcheck-core/QCheck/Gen/index.html -
     Used to figure out how to generate random integers between 0 and another
     positive number *)
  let g_value = Gen.int_bound 255 in
  let b_value = Gen.int_bound 255 in
  Gen.triple r_value g_value b_value

let generate_jpg_matrix =
  let row = Gen.int_range 1 1000 in
  let col = Gen.int_range 1 1000 in
  Gen.list_size row (Gen.list_size col generate_random_pixel_jpg)

let check_dimension_preservation f imglst =
  let row = List.length imglst in
  let col = List.length (List.nth imglst 0) in
  let transformed_lst = f imglst in
  let transformed_row = List.length transformed_lst in
  let transformed_col = List.length (List.nth transformed_lst 0) in
  col = transformed_col && row = transformed_row

let dimension_preservation_check_jpg f =
  Test.make ~count:10 generate_jpg_matrix (check_dimension_preservation f)

let check_dimension_preservation_2 f imglst =
  let row = List.length imglst in
  let col = List.length (List.nth imglst 0) in
  let transformed_lst = f imglst 0.5 in
  let transformed_row = List.length transformed_lst in
  let transformed_col = List.length (List.nth transformed_lst 0) in
  col = transformed_col && row = transformed_row

let dimension_preservation_check_2_jpg f =
  Test.make ~count:10 generate_jpg_matrix (check_dimension_preservation_2 f)

let qcheck_test_suite_jpg =
  "qcheck test suite jpg"
  >::: [
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_jpg Jpegimg.grayscale);
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_jpg Jpegimg.horizontal_flip);
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_jpg (Jpegimg.saturate 0.8));
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_jpg (Jpegimg.saturate_v2 0.6));
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_jpg Jpegimg.reverse_color);
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_2_jpg Jpegimg.brighten);
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_2_jpg Jpegimg.dim);
       ]

(* Png property testing *)
let generate_random_pixel_png =
  let r_value = Gen.int_bound 255 in
  let g_value = Gen.int_bound 255 in
  let b_value = Gen.int_bound 255 in
  let a_value = Gen.int_bound 255 in
  Gen.quad r_value g_value b_value a_value

let generate_png_matrix =
  let row = Gen.int_range 1 1000 in
  let col = Gen.int_range 1 1000 in
  Gen.list_size row (Gen.list_size col generate_random_pixel_png)

let dimension_preservation_check_png f =
  Test.make ~count:10 generate_png_matrix (check_dimension_preservation f)

let dimension_preservation_check_2_png f =
  Test.make ~count:10 generate_png_matrix (check_dimension_preservation_2 f)

let qcheck_test_suite_png =
  "qcheck test suite png"
  >::: [
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_png Pngimg.grayscale);
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_png Pngimg.horizontal_flip);
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_png (Pngimg.saturate 0.8));
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_png (Pngimg.saturate_v2 0.6));
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_png Pngimg.reverse_color);
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_2_png Pngimg.brighten);
         QCheck_runner.to_ounit2_test
           (dimension_preservation_check_2_png Pngimg.dim);
       ]

let _ = run_test_tt_main qcheck_test_suite_jpg
let _ = run_test_tt_main qcheck_test_suite_png
