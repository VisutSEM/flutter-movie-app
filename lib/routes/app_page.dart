import 'package:get/get.dart';
import 'package:tos_merl/view/detail_view.dart';
import 'package:tos_merl/view/home_view.dart';

class AppPage {

  static final routs = [
    GetPage(name: '/', page:()=> HomeView()),
    GetPage(name: '/detail', page:()=> DetailView()),
  ];
}