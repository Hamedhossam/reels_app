import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:reels/modules/home/data/models/video_model.dart';

class ApiService {
  static const String baseUrl = 'http://api.sawalef.app/api/v1/reels';

  static Future<List<VideoModel>> fetchVideos(int page) async {
    final Dio dio = Dio();

    try {
      final response = await dio.get('$baseUrl?page=$page');
      final jsonData = response.data as Map<String, dynamic>;
      final List<dynamic> videoData = jsonData['data'];
      return videoData.map((e) => VideoModel.fromJson(e)).toList();
    } on DioException catch (e) {
      // Handle Dio errors more specifically
      if (e.response != null) {
        log('DioError: ${e.response?.statusCode} - ${e.response?.data}');
        throw Exception(
            'API request failed with status code: ${e.response?.statusCode}');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timeout');
      } else {
        throw Exception('DioError: ${e.message}');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to load videos');
    }
  }
}
