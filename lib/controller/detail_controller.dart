import 'package:get/get.dart';
import 'package:tos_merl/controller/movie_controller.dart';
import 'package:tos_merl/models/movie_model.dart';

class DetailController extends GetxController{

   Rxn<MovieModel> movie = Rxn<MovieModel>();

  void getMovie(){
    movie.value = Get.arguments as MovieModel;
  }
  @override
  void onInit() {
    getMovie();
    // TODO: implement onInit
    super.onInit();
  }
}