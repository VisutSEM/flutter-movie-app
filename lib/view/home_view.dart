import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tos_merl/controller/movie_controller.dart';
import 'package:tos_merl/view/detail_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flex App",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),centerTitle: true,
        actions: [IconButton(onPressed: (){
          if(Get.isDarkMode)
            Get.changeTheme(ThemeData.light());
          else{
            Get.changeTheme(ThemeData.dark());
          }
        }, icon: Icon(Icons.light_mode))],
      ),
      body: Obx((){
        if(controller.isLoading.value){
          return Center(child: CircularProgressIndicator());
        }
       return SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Upcoming',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              ),
              CarouselSlider.builder(itemCount: controller.lstMovie.length, itemBuilder:(context, index, movieIndex){
                final movie = controller.lstMovie[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.transparent,
                        borderRadius: BorderRadiusGeometry.circular(30)),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>DetailView(),arguments: movie,transition: Transition.downToUp);
                          },
                          child: CachedNetworkImage(
                            imageUrl: "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                            imageBuilder: (context, imageProvider) => ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      colorFilter:
                                      ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(child:Container(), baseColor: Colors.white38, highlightColor:Colors.white38),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ],
                    )
                  ),
                );
              }, options: CarouselOptions(autoPlay: true)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Popular',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GridView.builder(
                  itemCount: controller.lstMoviePopular.length,
                  shrinkWrap: true, // IMPORTANT
                  physics: NeverScrollableScrollPhysics(), // IMPORTANT
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 2 columns
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7, // adjust height
                  ),
                  itemBuilder: (context, index) {
                    final movie = controller.lstMoviePopular[index];

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>DetailView(),arguments: movie,transition: Transition.downToUp);
                            },
                            child: CachedNetworkImage(
                              imageUrl:
                              "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(color: Colors.white),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ],
                      )
                    );
                  },
                ),
              ),

            ],
          ),
       );
      })
    );
  }
}
