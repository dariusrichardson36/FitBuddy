import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 75.0,
                  height: 75.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://pbs.twimg.com/profile_images/1650839170653335552/WgtT2-ut_400x400.jpg'), // Replace with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),

                    Text(
                      'Zachary',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        Icon(
                          Icons.military_tech,
                          color: Colors.amber
                        ),

                        Icon(
                          Icons.military_tech,
                          color: Colors.blueGrey[100]
                        ),

                        Icon(
                          Icons.military_tech,
                          color: Colors.orange[900]
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: Colors.black 
                          )
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.restart_alt,
                            color: Colors.black 
                          )
                        ),
                      ],  
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 25),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    'Posts',
                    style: TextStyle(color: Colors.black, fontSize: 32),
                  )   
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    'Highlights',
                    style: TextStyle(color: Colors.black, fontSize: 32),
                  )   
                ),
              ],
            ),

            Row(
              children: [
                SizedBox(width: 280),

                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.black 
                  )
                ),
              ],
            )
            
          ],
          
        ),
      ),
    );
  }
}
