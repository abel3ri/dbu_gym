import 'package:dbu_gym/models/error.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

Future<Either<CustomError, Map<String, dynamic>>> getPricingContent() async {
  try {
    Dio dio = Dio();
    final res = await dio.get("https://thereal3ri.github.io/pricing.json");

    return Either.right(res.data);
  } on DioException catch (_) {
    return Either.left(
      CustomError(
        errorTitle: "Connection Error",
        errorBody: "Unable to load pricing content.",
      ),
    );
  } catch (err) {
    return Either.left(
      CustomError(errorTitle: "Error", errorBody: err.toString()),
    );
  }
}
