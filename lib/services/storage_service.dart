import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const _apiKeyKey = 'groq_api_key';

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> saveApiKey(String apiKey) async {
    await _storage.write(key: _apiKeyKey, value: apiKey);
  }

  Future<String?> getApiKey() async {
    return await _storage.read(key: _apiKeyKey);
  }

  Future<bool> hasApiKey() async {
    final key = await _storage.read(key: _apiKeyKey);
    return key != null && key.isNotEmpty;
  }

  Future<void> deleteApiKey() async {
    await _storage.delete(key: _apiKeyKey);
  }
}
