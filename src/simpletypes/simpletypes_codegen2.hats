(* ****** ****** *)
//
implement
{}(*tmp*)
datcon_s3type
  (arg0) =
(
case+ arg0 of
| S3TYPEref _ => "S3TYPEref"
| S3TYPEelement _ => "S3TYPEelement"
| S3TYPErecord _ => "S3TYPErecord"
| S3TYPEprop _ => "S3TYPEprop"
| S3TYPEcon _ => "S3TYPEcon"
| S3TYPEfun _ => "S3TYPEfun"
| S3TYPEvar _ => "S3TYPEvar"
| S3TYPEpoly _ => "S3TYPEpoly"
)
//
(* ****** ****** *)
