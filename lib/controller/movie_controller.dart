import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

class MovieController extends GetxController {
  final apiKey = "f0928c41d2e66395dbcbc2a9e08f85b6";

  RxBool isLoading = true.obs;
  RxList<MovieModel> lstMovie = <MovieModel>[].obs;
  RxList<MovieModel> lstMoviePopular = <MovieModel>[].obs;

  late final upComingApiUrl =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  late final popularApiUrl =
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";

  Future<void> getUpcomingMovie() async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(upComingApiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];

        lstMovie.value =
            results.map((m) => MovieModel.fromJson(m)).toList();
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPopularMovie() async {
    try {
      isLoading.value = true;

      final response = await http.get(Uri.parse(popularApiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];

        lstMoviePopular.value =
            results.map((m) => MovieModel.fromJson(m)).toList();
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getPopularMovie();
    getUpcomingMovie();
    super.onInit();
  }
}