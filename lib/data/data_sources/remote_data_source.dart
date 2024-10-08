import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/api_urls.dart';
import '../../core/network/dio_client.dart';
import '../models/sign_in_req_params.dart';
import '../models/sign_up_req_params.dart';

abstract class RemoteDataSource {
  Future<Either> signUp(SignUpReqParams signupReq);

  Future<Either> getUser();

  Future<Either> signIn(SignInReqParams signInReq);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final DioClient dioClient;

  RemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either> signUp(SignUpReqParams signupReq) async {
    try {
      var response = await dioClient.post(ApiUrls.register, data: signupReq.toMap());

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      var response = await dioClient.get(ApiUrls.userProfile,
          options: Options(headers: {'Authorization': 'Bearer $token '}));

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signIn(SignInReqParams signInReq) async {
    try {
      var response = await dioClient.post(ApiUrls.login, data: signInReq.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
