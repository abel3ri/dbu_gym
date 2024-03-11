import 'package:fpdart/fpdart.dart';

extension EitherExtension on Either {
  get asLeft => (this as Left).value;
  get asRight => (this as Right).value;
}
