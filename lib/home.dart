// import 'package:flutter/material.dart';
// import 'description.dart';
// import 'group.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class MyHome extends StatefulWidget {
//   const MyHome({super.key});

//   @override
//   State<MyHome> createState() => _MyHomeState();
// }

// class _MyHomeState extends State<MyHome> {
//   @override
//   void initState() {
//     super.initState();
//     _requestLocationPermission();
//   }

//   Future<void> _requestLocationPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       permission = await Geolocator.requestPermission();
//     }

//     if (permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always) {
//       // Permission granted
//     } else {
//       // Permission denied
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Location permission is required.")),
//       );
//     }
//   }

//   String imageUrl = '';
//   // final FirebaseStorage _storage = FirebaseStorage.instance;
//   final CollectionReference _atlplacesReference =
//       FirebaseFirestore.instance.collection('atl_places');
//   final CollectionReference _otherplacesReference =
//       FirebaseFirestore.instance.collection('places');
//   final CollectionReference _cultural =
//       FirebaseFirestore.instance.collection('cultural');

//   String capitalizeAndJoin(String input) {
//     return input
//         .split('_')
//         .map((word) =>
//             "${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ")
//         .join('');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ready for Adventure!!!'),
//       ),
//       backgroundColor: const Color.fromARGB(195, 255, 255, 255),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Discover text
//             Stack(
//               children: [
//                 Image.asset(
//                   'assets/background.jpg',
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: 300,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(32.0),
//                   child: Center(
//                     child: Text(
//                       "Discover the Adventurer in YOU!!!",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // "Explore the places of the world" text
//             const Padding(
//               padding: EdgeInsets.fromLTRB(
//                   16, 8, 16, 24), // Adjust padding as needed
//               child: Text(
//                 'Explore the places of the world',
//                 style: TextStyle(fontSize: 18, color: Colors.black),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'Places Near Atlanta',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               height: 300,
//               child: FutureBuilder<QuerySnapshot>(
//                 future: _atlplacesReference.get(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   }
//                   List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
//                   return ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     itemCount: documents.length,
//                     itemBuilder: (context, index) {
//                       String imageUrl = documents[index]['image'];
//                       String description = documents[index]['description'];
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Description(
//                                 imageUrl: imageUrl,
//                                 // imageUrl: "assets/home.jpg"
//                                 placeName: capitalizeAndJoin(
//                                     documents[index]['index']),
//                                 description: description,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           width: 150,
//                           // height: 200,
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 6),
//                           child: SingleChildScrollView(
//                             child: Stack(
//                               children: [
//                                 Image.network(
//                                   imageUrl,
//                                   // "assets/home.jpg",
//                                   fit: BoxFit.cover,
//                                   height: 200,
//                                   width: 500,
//                                 ),
//                                 Center(
//                                   child: Text(
//                                     documents[index]['index'],
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                       backgroundColor: Colors.black54,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Text(
//                 'Other Places & Destinations',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 300,
//               child: FutureBuilder<QuerySnapshot>(
//                   future: _otherplacesReference.get(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     }
//                     List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
//                     return CarouselSlider(
//                       options: CarouselOptions(
//                         height: 400,
//                         autoPlay: true,
//                         enlargeCenterPage: true,
//                       ),
//                       items: documents.map((item) {
//                         return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Description(
//                                     imageUrl: item['image'],
//                                     placeName: capitalizeAndJoin(item['index']),
//                                     description: item['description'],
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Stack(
//                               children: [
//                                 Image.network(
//                                   item['image']!,
//                                   fit: BoxFit.cover,
//                                   width: double.infinity,
//                                 ),
//                                 Center(
//                                   child: Text(
//                                     item['index']!,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                       backgroundColor: Colors.black54,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ));
//                       }).toList(),
//                     );
//                   }),
//             ),
//             const SizedBox(height: 10),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'Cultural Diversity',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 200,
//               child: FutureBuilder<QuerySnapshot>(
//                 future: _cultural.get(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   }
//                   List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
//                   return ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: documents.length,
//                     itemBuilder: (context, index) {
//                       String imageUrl = documents[index]['image'];
//                       String description = documents[index]['description'];
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Description(
//                                 imageUrl: imageUrl,
//                                 placeName: capitalizeAndJoin(
//                                     documents[index]['index']),
//                                 description: description,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           width: 150,
//                           height: 250,
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 6),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 Image.network(
//                                   imageUrl,
//                                   fit: BoxFit.cover,
//                                   height: 200,
//                                   width: 200,
//                                 ),
//                                 Text(
//                                   capitalizeAndJoin(documents[index]['index']),
//                                   style: const TextStyle(
//                                       fontSize: 16, color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             // Groups section
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: const Color.fromARGB(199, 131, 35, 35),
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



// import 'package:flutter/material.dart';
// import 'description.dart';
// import 'group.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class MyHome extends StatefulWidget {
//   const MyHome({super.key});

//   @override
//   State<MyHome> createState() => _MyHomeState();
// }

// class _MyHomeState extends State<MyHome> {
//   @override
//   void initState() {
//     super.initState();
//     _requestLocationPermission();
//   }

//   Future<void> _requestLocationPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       permission = await Geolocator.requestPermission();
//     }

//     if (permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always) {
//       // Permission granted
//     } else {
//       // Permission denied
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Location permission is required.")),
//       );
//     }
//   }

//   String capitalizeAndJoin(String input) {
//     return input
//         .split('_')
//         .map((word) =>
//             "${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ")
//         .join('');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ready for Adventure!!!'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Hero Section with overlay text
//             Stack(
//               children: [
//                 Image.asset(
//                   'assets/background.jpg',
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: 300,
//                 ),
//                 Container(
//                   height: 300,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.black.withOpacity(0.6),
//                         Colors.transparent
//                       ],
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                     ),
//                   ),
//                 ),
//                 const Center(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
//                     child: Text(
//                       "Discover the Adventurer in YOU!!!",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Section Title
//             const Padding(
//               padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
//               child: Text(
//                 'Explore the places of the world',
//                 style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold),
                 
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Atlanta Places Section
//             _buildSection(
//               title: 'Places Near Atlanta',
//               collectionReference: FirebaseFirestore.instance.collection('atl_places'),
//               isHorizontal: false,
//             ),

//             const SizedBox(height: 20),

//             // Other Places Section
//             _buildSection(
//               title: 'Other Places & Destinations',
//               collectionReference: FirebaseFirestore.instance.collection('places'),
//               isCarousel: true,
//             ),

//             const SizedBox(height: 20),

//             // Cultural Diversity Section
//             _buildSection(
//               title: 'Cultural Diversity',
//               collectionReference: FirebaseFirestore.instance.collection('cultural'),
//               isHorizontal: true,
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.deepPurple,
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
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection({
//     required String title,
//     required CollectionReference collectionReference,
//     bool isHorizontal = false,
//     bool isCarousel = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: isCarousel ? 300 : (isHorizontal ? 220 : 400),
//           child: FutureBuilder<QuerySnapshot>(
//             future: collectionReference.get(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text('Error: ${snapshot.error}'),
//                 );
//               }
//               List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
//               if (isCarousel) {
//                 return CarouselSlider(
//                   options: CarouselOptions(
//                     height: 300,
//                     autoPlay: true,
//                     enlargeCenterPage: true,
//                   ),
//                   items: documents.map((doc) {
//                     return _buildPlaceCard(doc, isHorizontal: false);
//                   }).toList(),
//                 );
//               }
//               return ListView.builder(
//                 scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
//                 itemCount: documents.length,
//                 itemBuilder: (context, index) {
//                   return _buildPlaceCard(documents[index], isHorizontal: isHorizontal);
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPlaceCard(QueryDocumentSnapshot document, {bool isHorizontal = false}) {
//     String imageUrl = document['image'];
//     String description = document['description'];
//     String placeName = capitalizeAndJoin(document['index']);

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Description(
//               imageUrl: imageUrl,
//               placeName: placeName,
//               description: description,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         width: isHorizontal ? 160 : double.infinity,
//         margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//         child: Stack(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.cover,
//                 height: isHorizontal ? 160 : 200,
//                 width: double.infinity,
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 color: Colors.black54,
//                 child: Text(
//                   placeName,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'description.dart';
import 'group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Permission granted
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission is required.")),
      );
    }
  }

  String capitalizeAndJoin(String input) {
    return input
        .split('_')
        .map((word) =>
            "${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ")
        .join('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Buddy'),
        backgroundColor: const Color(0xFF0083B0),
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section with overlay text
            Stack(
              children: [
                Image.asset(
                  'assets/background.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.withOpacity(0.6),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    child: Text(
                      // "Discover Your Next Adventure",
                      "What to discover next 🤔?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Section Title
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'Explore the world with us',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Atlanta Places Section
            _buildSection(
              title: 'Explore the places near you!',
              collectionReference: FirebaseFirestore.instance.collection('atl_places'),
              isHorizontal: false,
            ),

            const SizedBox(height: 20),

            // Other Places in USA
            _buildSection(
              title: 'Explore the places in United States!',
              collectionReference: FirebaseFirestore.instance.collection('places'),
              isCarousel: true,
            ),

            const SizedBox(height: 20),

            // International Places
            _buildSection(
              title: 'Explore the places in the World!',
              collectionReference: FirebaseFirestore.instance.collection('cultural'),
              isHorizontal: true,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF0083B0),
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

  Widget _buildSection({
    required String title,
    required CollectionReference collectionReference,
    bool isHorizontal = false,
    bool isCarousel = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: isCarousel ? 300 : (isHorizontal ? 220 : 400),
          child: FutureBuilder<QuerySnapshot>(
            future: collectionReference.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              if (isCarousel) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: documents.map((doc) {
                    return _buildPlaceCard(doc, isHorizontal: false);
                  }).toList(),
                );
              }
              return ListView.builder(
                scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  return _buildPlaceCard(documents[index], isHorizontal: isHorizontal);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceCard(QueryDocumentSnapshot document, {bool isHorizontal = false}) {
    String imageUrl = document['image'];
    String description = document['description'];
    String placeName = capitalizeAndJoin(document['index']);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Description(
              imageUrl: imageUrl,
              placeName: placeName,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        width: isHorizontal ? 160 : double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: isHorizontal ? 160 : 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black54,
                child: Text(
                  placeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}