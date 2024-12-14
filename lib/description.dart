// import 'package:flutter/material.dart';
// import 'group.dart';
// import 'home.dart';

// class Description extends StatelessWidget {
//   final String imageUrl;
//   final String placeName;
//   final String description;

//   const Description({
//     super.key,
//     required this.imageUrl,
//     required this.placeName,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Description"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 600,
//               width: double.infinity,
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 '\n\n$description',
//                 style: const TextStyle(
//                   color: Colors.green,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.transparent,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.home),
//               color: Colors.white,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const MyHome()),
//                 );
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.navigation),
//               color: Colors.white,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Group()),
//                 );
//               },
//             ),
//             // IconButton(
//             //   icon: const Icon(
//             //     Icons.camera_alt,
//             //     color: Colors.white,
//             //   ),
//             //   onPressed: () {
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(builder: (context) => const Capture()),
//             //     );
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'group.dart';
import 'home.dart';

class Description extends StatelessWidget {
  final String imageUrl;
  final String placeName;
  final String description;

  const Description({
    super.key,
    required this.imageUrl,
    required this.placeName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Description"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying the Image
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                // Gradient Overlay
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                // Place Name Text
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    placeName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.5, // Line height for better readability
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHome()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.navigation),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Group()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}