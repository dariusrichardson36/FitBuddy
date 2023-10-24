//import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/components/FitBuddyProfileHeader.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import 'package:fit_buddy/constants/route_constants.dart';
import 'package:fit_buddy/models/user.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<User> test = FireStore.FireStore().getUserData();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<User>(
                        future: test,
                        builder: (context, snapshot) {
                          User? user = snapshot.data;
                          if (user != null) {
                            return FitBuddyProfileHeader(userData: user);
                          }
                          return Text('User not Found');
                        }
                      ),
        )
      )
    );
  }
}
  //         padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 // User profile picture in top left
  //                 Container(
  //                   width: 75.0,
  //                   height: 75.0,
  //                   decoration: BoxDecoration(
  //                     shape: BoxShape.circle,
  //                     image: DecorationImage(
  //                       image: NetworkImage(
  //                           'https://pbs.twimg.com/profile_images/1650839170653335552/WgtT2-ut_400x400.jpg'), // Replace with your image URL
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
    
  //                 SizedBox(width: 10),
    
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     SizedBox(height: 10),

                      

                      
    
  //                     SizedBox(height: 10),
    
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           Icons.military_tech,
  //                           color: Colors.amber
  //                         ),
    
  //                         Icon(
  //                           Icons.military_tech,
  //                           color: Colors.blueGrey[100]
  //                         ),
    
  //                         Icon(
  //                           Icons.military_tech,
  //                           color: Colors.orange[900]
  //                         ),
    
  //                         IconButton(
  //                           onPressed: () {},
  //                           icon: Icon(
  //                             Icons.add,
  //                             color: FitBuddyColorConstants.lOnPrimary 
  //                           )
  //                         ),
    
  //                         IconButton(
  //                           onPressed: () {},
  //                           icon: Icon(
  //                             Icons.restart_alt,
  //                             color: FitBuddyColorConstants.lOnPrimary
  //                           )
  //                         ),
  //                       ],  
  //                     ),
  //                   ],
  //                 ),
  //                 IconButton(
  //                   onPressed: () => context.goNamed(FitBuddyRouterConstants.homePage),
  //                   icon: Icon(
  //                     Icons.arrow_forward,
  //                     color: FitBuddyColorConstants.lOnPrimary
  //                   )
  //                 )
  //               ],
  //             ),
    
  //             SizedBox(height: 25),
    
  //             Row(
  //               children: [
  //                 ElevatedButton(
  //                   onPressed: () {},
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: Colors.transparent,
  //                     shadowColor: Colors.transparent,
  //                   ),
  //                   child: Text(
  //                     'Posts',
  //                     style: TextStyle(color: FitBuddyColorConstants.lOnPrimary, fontSize: 32),
  //                   )   
  //                 ),
    
  //                 ElevatedButton(
  //                   onPressed: () {},
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: Colors.transparent,
  //                     shadowColor: Colors.transparent,
  //                   ),
  //                   child: Text(
  //                     'Highlights',
  //                     style: TextStyle(color: FitBuddyColorConstants.lOnPrimary, fontSize: 32),
  //                   )   
  //                 ),
  //               ],
  //             ),
    
  //             Row(
  //               children: [
  //                 SizedBox(width: 270),
    
  //                 IconButton(
  //                   onPressed: () {},
  //                   icon: Icon(
  //                     Icons.search,
  //                     color: FitBuddyColorConstants.lOnPrimary 
  //                   )
  //                 ),
  //               ],
  //             ),
              
  //             Divider(
  //               color: FitBuddyColorConstants.lOnPrimary,
  //               thickness: 2,
  //             ),
    
  //             Row(
  //               children: [
  //                 Container(
  //                   width: 45.0,
  //                   height: 45.0,
  //                   decoration: BoxDecoration(
  //                     shape: BoxShape.circle,
  //                     image: DecorationImage(
  //                       image: NetworkImage(
  //                           'https://pbs.twimg.com/profile_images/1650839170653335552/WgtT2-ut_400x400.jpg'), // Replace with your image URL
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
    
  //                 SizedBox(width: 10),
    
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Zachary',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnPrimary,
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.bold
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 10),
    
  //                     Text(
  //                       '8h ago',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnPrimary,
  //                         fontSize: 13
  //                       ),
  //                     )
  //                   ],
  //                 ), 
  //               ]
  //             ),
    
  //             SizedBox(height: 20),
    
  //             Row(
  //               children: [
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'Activity',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnSecondary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 5),
    
  //                     Text(
  //                       'Leg Press',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnPrimary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 10),
    
  //                     Text(
  //                       'Bicep Curl',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnPrimary,
  //                         fontSize: 15
  //                       ),
  //                     ),
  //                   ],
  //                 ),
    
  //                 SizedBox(width: 15),
    
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                      '|',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnSecondary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 52)
  //                   ],
  //                 ),
    
  //                 SizedBox(width: 15),
      
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'Sets',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnSecondary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 5),
    
  //                     Text(
  //                       '2',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnPrimary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 10),
    
  //                     Text(
  //                       '2',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnPrimary,
  //                         fontSize: 15
  //                       ),
  //                     ),
  //                   ],
  //                 ),
    
  //                 SizedBox(width: 15),
      
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                      '|',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnSecondary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 52)
  //                   ],
  //                 ),
    
  //                 SizedBox(width: 15),
    
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'Reps',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnSecondary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 5),
    
  //                     Text(
  //                       '12',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnPrimary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 10),
    
  //                     Text(
  //                       '12',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnPrimary,
  //                         fontSize: 15
  //                       ),
  //                     ),
  //                   ],
  //                 ),
    
  //                 SizedBox(width: 15),
    
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                      '|',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnSecondary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 52)
  //                   ],
  //                 ),
    
  //                 SizedBox(width: 15),
    
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'Weight',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnSecondary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 5),
    
  //                     Text(
  //                       '125',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnPrimary,
  //                         fontSize: 15
  //                       ),
  //                     ),
    
  //                     SizedBox(height: 10),
    
  //                     Text(
  //                       '125',
  //                       style: TextStyle(
  //                         color: FitBuddyColorConstants.lOnPrimary,
  //                         fontSize: 15
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
    
  //             Divider(
  //               color: FitBuddyColorConstants.lOnPrimary,
  //               thickness: 2,
  //             ),
    
    
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
//}
