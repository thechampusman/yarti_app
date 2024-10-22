import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final pickupSuggestionsProvider =
    StateNotifierProvider<GooglePlacesNotifier, List<String>>((ref) {
  return GooglePlacesNotifier();
});

final dropSuggestionsProvider =
    StateNotifierProvider<GooglePlacesNotifier, List<String>>((ref) {
  return GooglePlacesNotifier();
});

class GooglePlacesNotifier extends StateNotifier<List<String>> {
  GooglePlacesNotifier() : super([]);
  final apiKey = 'AIzaSyADxQ9ZSp7t_A6DqG6TKNt9rsv6eOlLadQ';
  Future<void> fetchSuggestions(
    String input,
  ) async {
    if (input.isEmpty) {
      state = [];
      return;
    }

    final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    try {
      Dio dio = Dio();
      final response = await dio.get(url, queryParameters: {
        'input': input,
        'key': apiKey,
        'types': 'geocode',
        'components': 'country:in', // Optional: restrict to India
      });

      if (response.statusCode == 200) {
        final predictions = response.data['predictions'] as List;
        state = predictions.map((p) => p['description'] as String).toList();
      } else {
        state = [];
      }
    } catch (e) {
      state = [];
    }
  }
}
