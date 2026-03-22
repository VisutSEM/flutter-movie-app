import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/detail_controller.dart';

class DetailView extends StatelessWidget {
  DetailView({super.key});

  final controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.movie.value == null) {
          return Center(child: CircularProgressIndicator());
        }

        final movie = controller.movie.value!;

        return CustomScrollView(
          slivers: [
            // 🔥 AppBar that hides on scroll
            SliverAppBar(
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none)),
              ],
              leading: IconButton(onPressed: (){
                Get.back();
              }, icon: Icon(Icons.arrow_back_ios)),
              expandedHeight: 600,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl:
                  "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(color: Colors.white,width: 400,height: 500,),
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                ),
              ),
            ),

            // ✅ Replace Column with SliverList
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.title ?? "",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold,color: Colors.red),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8))),onPressed: (){}, child: Icon(Icons.play_arrow,size: 30,color: Colors.white,))),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Overview",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movie.overview ?? ""),
                      ),Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movie.overview ?? ""),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}