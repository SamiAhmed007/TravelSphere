// // ignore_for_file: unused_local_variable

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class MyLogin extends StatefulWidget {
//   const MyLogin({super.key});

//   @override
//   State<MyLogin> createState() => _MyLoginState();
// }

// class _MyLoginState extends State<MyLogin> {
//   TextEditingController userTextController = TextEditingController();
//   TextEditingController passwordTextController = TextEditingController();

//   // ignore: unused_element
//   Future<FirebaseApp> _initializeFirebase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }

//   // Function to handle sign in
//   // ignore: unused_element
//   static Future<User?> _signInWithEmailAndPassword(
//       {required String email,
//       required String password,
//       required BuildContext context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;
//     try {
//       UserCredential userCredential = await auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       // Handle successful sign in here
//       user = userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "user-not-found") {
//         // print("No User found for that email");
//       } else if (e.code == "wrong-password") {
//         //print("Wrong password provided for that user");
//       } else if (e.code == "invalid-email") {
//         //print("Invalid email address");
//       } else {
//         //print(e.code);
//       }
//       // Handle sign in error here
//     }
//     return user;
//   }

//   @override
//   Widget build(BuildContext context) {
//     String email = '';
//     String pass = '';

//     return Container(
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(left: 35, top: 130),
//               child: const Text(
//                 "Welcome",
//                 style: TextStyle(color: Colors.white, fontSize: 30),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.5,
//                     left: 35,
//                     right: 35),
//                 child: Column(children: [
//                   TextField(
//                     controller: userTextController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.grey,
//                       filled: true,
//                       hintText: "email id",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   TextField(
//                     obscureText: true,
//                     controller: passwordTextController,
//                     decoration: InputDecoration(
//                       fillColor: Colors.grey,
//                       filled: true,
//                       hintText: "password",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       try {
//                         UserCredential userCredential = await FirebaseAuth
//                             .instance
//                             .signInWithEmailAndPassword(
//                                 email: userTextController.text,
//                                 password: passwordTextController.text);
//                         // ignore: use_build_context_synchronously
//                         Navigator.pushNamed(context, 'home');
//                       } on FirebaseAuthException catch (e) {
//                         if (e.code == 'user-not-found') {
//                           SnackBar snackBar = const SnackBar(
//                             content: Text('No User found for that email.'),
//                           );
//                           // ignore: use_build_context_synchronously
//                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                         } else if (e.code == 'wrong-password') {
//                           SnackBar snackBar = const SnackBar(
//                             content:
//                                 Text('Wrong Password provided for that user.'),
//                           );
//                           // ignore: use_build_context_synchronously
//                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                         } else {
//                           debugPrint('Error: $e');
//                         }
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 50, vertical: 10),
//                         textStyle: const TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                     child: const Text('SIGN IN'),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, 'register');
//                         },
//                         child: const Text('SIGN UP',
//                             style: TextStyle(
//                                 decoration: TextDecoration.underline,
//                                 fontSize: 18,
//                                 color: Color(0xff4c505b))),
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Text('FORGOT PASSWORD?',
//                             style: TextStyle(
//                                 decoration: TextDecoration.underline,
//                                 fontSize: 18,
//                                 color: Color(0xff4c505b))),
//                       )
//                     ],
//                   )
//                 ]),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class MyLogin extends StatefulWidget {
//   const MyLogin({super.key});

//   @override
//   State<MyLogin> createState() => _MyLoginState();
// }

// class _MyLoginState extends State<MyLogin> {
//   TextEditingController userTextController = TextEditingController();
//   TextEditingController passwordTextController = TextEditingController();

//   // Function to show a SnackBar for errors
//   void _showSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.redAccent,
//       ),
//     );
//   }

//   // Function to handle user sign-in
//   Future<void> _signIn() async {
//     final email = userTextController.text.trim();
//     final password = passwordTextController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       _showSnackBar(context, "Please enter email and password.");
//       return;
//     }

//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       Navigator.pushNamed(context, 'home');
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         _showSnackBar(context, "No user found for this email.");
//       } else if (e.code == 'wrong-password') {
//         _showSnackBar(context, "Incorrect password.");
//       } else {
//         _showSnackBar(context, "Error: ${e.message}");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           // Animated top section with title
//           Align(
//             alignment: Alignment.topCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 60),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     'assets/logo.png', // Replace with your logo image
//                     height: 100,
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Welcome Back!",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "Login to continue your adventure",
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Login Card
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.55,
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 30),
//                   _buildTextField(
//                     controller: userTextController,
//                     hintText: "Email Address",
//                     icon: Icons.email,
//                     obscureText: false,
//                   ),
//                   const SizedBox(height: 20),
//                   _buildTextField(
//                     controller: passwordTextController,
//                     hintText: "Password",
//                     icon: Icons.lock,
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _signIn,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF0083B0),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 80, vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text(
//                       "SIGN IN",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, 'register');
//                         },
//                         child: const Text(
//                           "Sign Up",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFF0083B0),
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           // Implement Forgot Password Functionality
//                         },
//                         child: const Text(
//                           "Forgot Password?",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Color(0xFF0083B0),
//                           ),
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

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//     required bool obscureText,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: const Color(0xFF0083B0)),
//         hintText: hintText,
//         filled: true,
//         fillColor: Colors.grey[100],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController userTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<void> _signIn() async {
    final email = userTextController.text.trim();
    final password = passwordTextController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(context, "Please enter email and password.");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, 'home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showSnackBar(context, "No user found for this email.");
      } else if (e.code == 'wrong-password') {
        _showSnackBar(context, "Incorrect password.");
      } else {
        _showSnackBar(context, "Error: ${e.message}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Login to continue your adventure",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                children: [
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: userTextController,
                    hintText: "Email Address",
                    icon: Icons.email,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: passwordTextController,
                    hintText: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0083B0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0083B0),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0083B0),
                          ),
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
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool obscureText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black), // Set text color to black
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF0083B0)),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}