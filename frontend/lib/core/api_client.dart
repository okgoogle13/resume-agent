import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:http/http.dart' as http;

class ApiClient {
  static String get baseUrl {
    if (kIsWeb) {
      // When running in Docker, use host.docker.internal to reach host machine
      // In production, you'd typically use an environment variable or different approach
      const bool.fromEnvironment('DOCKER_ENV', defaultValue: false)
          ? 'http://host.docker.internal:8000'
          : 'http://localhost:8000';
      return 'http://host.docker.internal:8000';
    }
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000';
    } else {
      return 'http://localhost:8000';
    }
  }
  
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Health check endpoint
  static Future<Map<String, dynamic>?> healthCheck() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return null;
    } catch (e) {
      debugPrint('Health check error: $e');
      return null;
    }
  }

  // Add more API methods here as needed
}
