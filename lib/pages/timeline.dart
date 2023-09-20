import 'package:flutter/material.dart';

class TimelinePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Stack(
            children: [
              GestureDetector(
                onTap: Scaffold.of(context).openDrawer,
                child: Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://pbs.twimg.com/profile_images/1650839170653335552/WgtT2-ut_400x400.jpg'), // Replace with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Logo Here") ,
                ),
              ),
            ],
          ),
        ),


        Expanded (
          child: ListView.separated(
            itemCount: 100,
            padding: const EdgeInsets.all(8),
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemBuilder: (context, index) => Post(),

          ),
        )
      ],    
    );
  }
}

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column (
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0,  0,  100,  0),
                  width: 45.0,
                  height: 45.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://pbs.twimg.com/profile_images/1650839170653335552/WgtT2-ut_400x400.jpg'), // Replace with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text("Robin Monseré")
              ],
            ),
            Text("This is the post bla bla ")
          ],
        ),
    );
  }

}