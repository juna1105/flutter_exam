import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;
  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
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
                thumb,
                headers: const {
                  "User-Agent": "Mozilla/5.0",
                },
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withOpacity(0.3),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Sunflower',
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
