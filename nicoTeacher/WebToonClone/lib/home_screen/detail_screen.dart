import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/webtoon_detail_model.dart';
import 'package:flutter_application_1/models/webtoon_episode_model.dart';
import 'package:flutter_application_1/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailMode> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisode(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green[800],
        centerTitle: true,
        title: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Hero(
              tag: widget.id,
              child: Container(
                clipBehavior: Clip.hardEdge,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: Offset(10, 0),
                      color: Colors.black45,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Image.network(
                  widget.thumb,
                  headers: const {
                    "User-Agent": "Mozilla/5.0",
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          FutureBuilder(
            future: webtoon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data!.about,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      snapshot.data!.age,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      snapshot.data!.genre,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                );
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}
