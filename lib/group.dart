// import 'package:flutter/material.dart';
// import 'createhike.dart';
// import 'join.dart';

// class Group extends StatefulWidget {
//   // ignore: use_key_in_widget_constructors
//   const Group({Key? key});

//   @override
//   State<Group> createState() => _GroupState();
// }

// class _GroupState extends State<Group> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Start a Trip'),
//       ),
//       body: Stack(
//         children: [
//           Image.asset(
//             'assets/adventure.jpg', // Replace with your asset image path
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const CreateHike()),
//                         );
//                       },
//                       child: const Text('Create Trip'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const Join()),
//                         );
//                       },
//                       child: const Text('Join Trip'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ])
//           // SizedBox(
//           //   height: 300,
//           //   child: Center(
//           //     child: OpenStreetMapSearchAndPick(
//           //       buttonColor: Colors.yellow,
//           //       buttonText: 'Set Current Location',
//           //       onPicked: (pickedData) {
//           //         // print(pickedData.latLong.latitude);
//           //         // print(pickedData.latLong.longitude);
//           //         // print(pickedData.address);
//           //       },
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'createhike.dart';
// import 'join.dart';

// class Group extends StatefulWidget {
//   const Group({Key? key}) : super(key: key);

//   @override
//   State<Group> createState() => _GroupState();
// }

// class _GroupState extends State<Group> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Start a Trip'),
//         backgroundColor: Colors.deepPurple, // App bar color
//       ),
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(
//             child: Image.asset(
//               'assets/adventure.jpg', // Replace with your asset image path
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Foreground content
//           Center(
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16.0),
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.85),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.3),
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Welcome to Adventure!',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.deepPurple,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Choose an option to get started:',
//                     style: TextStyle(fontSize: 16, color: Colors.black),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       // Create Trip Button
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const CreateHike()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 24),
//                           backgroundColor: Colors.deepPurple,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           'Create Trip',
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                       // Join Trip Button
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const Join()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 24),
//                           backgroundColor: Colors.deepPurple,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           'Join Trip',
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'createhike.dart';
import 'join.dart';
import 'home.dart';

class Group extends StatefulWidget {
  const Group({Key? key}) : super(key: key);

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Top title section
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png', // Replace with your app logo
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Plan Your Adventure",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create or join a trip to get started",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Foreground buttons container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Choose an option to get started",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Create Trip Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateHike()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 28),
                          backgroundColor: const Color(0xFF0083B0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Create Trip',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      // Join Trip Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Join()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 28),
                          backgroundColor: const Color(0xFF0083B0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Join Trip',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Footer (same as in Home page)
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF0083B0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Tooltip(
              message: "Home",
              child: IconButton(
                icon: const Icon(Icons.home),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHome()),
                  );
                },
              ),
            ),
            Tooltip(
              message: "Navigate",
              child: IconButton(
                icon: const Icon(Icons.navigation),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Group()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}