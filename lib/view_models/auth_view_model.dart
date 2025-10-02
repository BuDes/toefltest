import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toeflapp/models/user.dart';
import 'package:toeflapp/pages/auth/models/new_user.dart';
import 'package:toeflapp/services/api_service.dart';

class AuthViewModel extends ChangeNotifier {
  final _endpoint = "${ApiService.baseUrl}/user";

  User? _currentUser;

  User? get currentUser => _currentUser;
  String? get token => ApiService.token;
  String? get role => ApiService.role;

  Future<String?> register(NewUser user) async {
    try {
      final response = await ApiService.postRequest(
        "$_endpoint/register",
        body: user.toJson(),
      );
      if (response.statusCode < 300) {
        _currentUser = User.fromJson(response.data);
        await _setToken(response.data["token"], response.data["role"]);
        notifyListeners();
        return null;
      }
      return response.message;
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final response = await ApiService.postRequest(
        "$_endpoint/login",
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      if (response.statusCode < 300) {
        await _setToken(response.data["token"], response.data["role"]);
        _currentUser = User.fromJson(response.data);
        notifyListeners();
        return null;
      }
      return response.message;
    } catch (e, stacktrace) {
      log("Failed to login: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  Future<bool> logout() async {
    try {
      final response = await ApiService.deleteRequest("$_endpoint/logout");
      _currentUser = null;
      await _setToken(null, null);
      notifyListeners();
      return response.statusCode < 300;
    } catch (e, stacktrace) {
      log("Failed to logout: $e", stackTrace: stacktrace);
      return false;
    }
  }

  Future<User> getProfile() async {
    try {
      final response = await ApiService.getRequest("$_endpoint/profile");
      if (response.statusCode < 300) {
        final user = User.fromJson(response.data);
        _currentUser = user;
        notifyListeners();
        return user;
      }
      await logout();
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to get profile: $e", stackTrace: stacktrace);
      rethrow;
    }
  }

  Future<bool> loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      ApiService.token = prefs.getString("TOKEN");
      ApiService.role = prefs.getString("ROLE");
      log("TOKEN: $token");
      log("ROLE: $role");
      notifyListeners();

      if (token == null || role == null) return false;
      await getProfile();
      return true;
    } catch (e, stacktrace) {
      log("Failed to load profile: $e", stackTrace: stacktrace);
      return false;
    }
  }

  Future _setToken(String? token, String? role) async {
    ApiService.token = token;
    ApiService.role = role;
    final prefs = await SharedPreferences.getInstance();
    if (token == null) {
      prefs.remove("TOKEN");
    } else {
      prefs.setString("TOKEN", token);
    }
    if (role == null) {
      prefs.remove("ROLE");
    } else {
      prefs.setString("ROLE", role);
    }
  }
}
