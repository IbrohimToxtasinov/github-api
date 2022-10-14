import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:git_hub/models/User_models.dart';
import 'package:git_hub/utils/images.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  Future<UserModel?> getData() async {
    String url = "https://api.github.com/users/Dilmurod0930";

    Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          width: 50,
          height: 50,
          child: Image.asset(MyImages.image_github)),
        actions: const [Icon(Icons.notification_add), SizedBox(width: 10,)],
        backgroundColor: Colors.black.withOpacity(0.9),
      ),
      body: FutureBuilder<UserModel?>(
          future: getData(),
          builder: (BuildContext contet, AsyncSnapshot<UserModel?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              UserModel? userModel = snapshot.data;
              return Container(
                width: double.infinity,
                margin: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage(userModel?.avatar_url??MyImages.image_github)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userModel?.name ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            Text(
                              userModel?.login ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Color(0xFF7F7F7F)),
                            left: BorderSide(color: Color(0xFF7F7F7F)),
                            right: BorderSide(color: Color(0xFF7F7F7F)),
                            bottom: BorderSide(color: Color(0xFF7F7F7F)),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Focusing"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF6F8FA),
                          border: Border(
                            top: BorderSide(color: Color(0xFF7F7F7F)),
                            left: BorderSide(color: Color(0xFF7F7F7F)),
                            right: BorderSide(color: Color(0xFF7F7F7F)),
                            bottom: BorderSide(color: Color(0xFF7F7F7F)),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Center(
                          child: Text(
                        "Edit profile",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        SvgPicture.asset(MyImages.link_svg, width: 10,),
                        SizedBox(width: 4,),
                        Container(
                          child: Text(userModel?.blog ?? ""),
                        ),
                      ],
                    ),
                    SizedBox(height: 4,),
                    Row(
                      children: [
                        const Icon(Icons.person),                       
                        Text(userModel?.followers.toString()??"", style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),

                        const Text("followers• "),
                        Text(userModel?.following.toString()??"", style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),

                        const Text("following"),
                      ],
                    ),
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          TabBar(
                            tabs: [
                              Tab(
                                child: Row(
                                  children: [
                                    Container(
                                      child: const Icon(Icons.menu_book,color: Colors.grey,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Overview", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),)
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  children: [
                                    Container(
                                      child: const Icon(Icons.book_outlined,color: Colors.grey,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Repositories", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),),
                                    const SizedBox(width: 5,),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      child: const Center(
                                        child: Text("29", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Tab(
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         child: const Icon(Icons.menu_book,color: Colors.grey,),
                              //       ),
                              //       const SizedBox(width: 10,),
                              //       const Text("Overview", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),)
                              //     ],
                              //   ),
                              // ),
                            ] 
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}