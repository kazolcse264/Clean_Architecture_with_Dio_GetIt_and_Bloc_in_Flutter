import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/helper_methods.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../models/sign_in_req_params.dart';
import '../models/sign_up_req_params.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either> signUp(SignUpReqParams signUpReq) async {
    Either result = await remoteDataSource.signUp(signUpReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', response.data['token']);
      return Right(response);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.isLoggedIn();
  }

  @override
  Future<Either> getUser() async {
    /* Either result = await remoteDataSource.getUser();
    return result.fold(
      (error){
        return Left(error);
      },
      (data) {
        Response response = data;
        var userModel = UserModel.fromMap(response.data);
        var userEntity = userModel.toEntity();
        return Right(userEntity);
      }
     );*/

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    if (token == null || token.isEmpty) {
      return const Left('Token not found');
    }

    // Decode the token and extract the user data
    UserModel? userModel = decodeToken(token);

    if (userModel == null) {
      return const Left('Failed to decode token or missing fields');
    }

    // Convert the userModel to userEntity
    var userEntity = userModel.toEntity();

    return Right(userEntity);
  }

  @override
  Future<Either> logout() async {
    return await localDataSource.logout();
  }

  @override
  Future<Either> signIn(SignInReqParams signInReq) async {
    Either result = await remoteDataSource.signIn(signInReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', response.data['token']);
      return Right(response);
    });
  }
}
