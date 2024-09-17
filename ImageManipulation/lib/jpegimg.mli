type t

val load_image : string -> t option
(** [load_image] loads the jpeg image that corresponds to the path passed in.
    Requires: path is a valid path and the image is a .jpeg or .jpg extension.
    Raises: [Failure Wrong_file_type] if the image at path represents an
    unsupported file format. *)

val image_to_list : t -> (int * int * int) list list
(** [image_to_list] is the list of lists representation of an Rgb24 image. *)

val list_to_image : (int * int * int) list list -> t
(** [list_to_image] is the Rgb24 representation of Jpeg image representation of
    the transformed list of lists of the image. *)

val save_image : t -> unit
(** [save_image] saves the transformed jpg image to the user's system. *)

val grayscale : (int * int * int) list list -> (int * int * int) list list
(** [grayscale] is the list of list of int triples representation of an Rgb24
    image converted to grayscale. *)

val vertical_flip : (int * int * int) list list -> (int * int * int) list list
(** [vertical_flip] is the list of lists of int triples representation of an
    Rgb24 image flipped vertically. In other words, the first row of pixels
    becomes the last row of pixels while the last row of pixels becomes the
    first row (and the rows in the middle reverse as well). *)

val horizontal_flip : (int * int * int) list list -> (int * int * int) list list
(** [horizontal_flip] is the list of lists of int triples representation of an
    Rgb24 image flipped horizontally. In other words, the first column of pixels
    becomes the last and the last column of pixels becomes the first (and the
    columns in the middle reverse as well). *)

val brighten :
  (int * int * int) list list -> float -> (int * int * int) list list
(** [brighten] is the list of lists of int triples representation of an Rgb24
    image brightened to the degree defined by the factor entered by the user.
    Requires: the factor is non-negative and less than equal to 1. *)

val dim : (int * int * int) list list -> float -> (int * int * int) list list
(** [dim] is the list of lists of int triples representation of an Rgb24 image
    dimmed to the degree defined by the factor entered by the user. Requires:
    the factor is non-positive and greater than or equal to -1. *)

val rotate_90_clockwise :
  (int * int * int) list list -> (int * int * int) list list
(** [rotate_90_clockwise] is the list of lists of int triples representation of
    an Rgb24 image rotated 90 degrees clockwise. *)

val rotate_270_clockwise :
  (int * int * int) list list -> (int * int * int) list list
(** [rotate_270_clockwise] is the list of lists of int triples representation of
    an Rgb24 image rotated 270 degrees clockwise. *)

val add_3d_effect : (int * int * int) list list -> (int * int * int) list list
(** [add_3d_effect] is the list of lists of int triples representation of an
    Rgb24 image with an added 3D effect. *)

val blur : (int * int * int) list list -> (int * int * int) list list
(** [blur] is the list of lists of int triples representation of an Rgb24 image
    that has been blurred. *)

val smoother_blur : (int * int * int) list list -> (int * int * int) list list
(** [smoother_blur] is the list of lists of int triples representation of an
    Rgb24 image that has been blurred. This blur transformation is smoother than
    the one applied in [blur]. *)

val sharpen : (int * int * int) list list -> (int * int * int) list list
(** [sharpen] is the list of lists of int triples representation of an Rgb24
    image that has been sharpened. *)

val outline : (int * int * int) list list -> (int * int * int) list list
(** [outline] is the list of lists of int triples representation of an Rgb24
    image where the outlines of objects in the image are emphasized. *)

val vertical_edge_detection :
  (int * int * int) list list -> (int * int * int) list list
(** [vertical_edge_detection] is the list of lists of int triples representation
    of an Rgb24 image where the vertical edges are highlighted. *)

val horizontal_edge_detection :
  (int * int * int) list list -> (int * int * int) list list
(** [horizontal_edge_detection] is the list of lists of int triples
    representation of an Rgb24 image where the horizontal edges are highlighted. *)

val unsharp : (int * int * int) list list -> (int * int * int) list list
(** [unsharp] is the list of lists of int triples representation of an Rgb24
    image where the edges are enhanced while keeping the overall image smooth. *)

val dilation : (int * int * int) list list -> (int * int * int) list list
(** [dilation] is the list of lists of int triples representation of an Rgb24
    image where the white region is the image is increased. *)

val erosion : (int * int * int) list list -> (int * int * int) list list
(** [erosion] is the list of lists of int triples representation of an Rgb24
    image where the white region is the image is decreased. *)

val motion_blur : (int * int * int) list list -> (int * int * int) list list
(** [motion_blur] is the list of lists of int triples representation of an Rgb24
    image that simulates the effect of a camera moving while capturing an image. *)

val saturate :
  float -> (int * int * int) list list -> (int * int * int) list list
(** [saturate] is the list of lists of int triples representation of an Rgb24
    image with saturation increased by the given factor. Requires: the factor is
    non-negative and less than equal to 1. *)

val saturate_v2 :
  float -> (int * int * int) list list -> (int * int * int) list list
(** [saturate_v2] is the list of lists of int triples representation of an Rgb24
    image with saturation increased by the given factor, using an alternative,
    more formal definition of saturation. Requires: the factor is non-negative
    and less than equal to 1. *)

val reverse_color : (int * int * int) list list -> (int * int * int) list list
(** [reverse_color] is the list of lists of int triples representation of an
    Rgb24 image with colors reversed. *)
