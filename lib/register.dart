// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class MyRegister extends StatefulWidget {
//   const MyRegister({super.key});

//   @override
//   State<MyRegister> createState() => _MyRegisterState();
// }

// class _MyRegisterState extends State<MyRegister> {
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/register.png'), fit: BoxFit.cover)),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(left: 35, top: 130),
//               child: const Text(
//                 "SIGN UP",
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
//                     decoration: InputDecoration(
//                       fillColor: Colors.grey,
//                       filled: true,
//                       hintText: "Name",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   TextField(
//                     controller: email,
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
//                     controller: password,
//                     obscureText: true,
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
//                         // ignore: unused_local_variable
//                         UserCredential userCredential = await FirebaseAuth
//                             .instance
//                             .createUserWithEmailAndPassword(
//                                 email: email.text, password: password.text);
//                         // ignore: use_build_context_synchronously
//                         // debugPrint('userCredentials: $userCredential');
//                         // ignore: use_build_context_synchronously
//                         Navigator.pushNamed(context, 'login');
//                       } on FirebaseAuthException catch (e) {
//                         if (e.code == 'weak-password') {
//                           //display a snackbar
//                           SnackBar snackBar = const SnackBar(
//                             content: Text('The password provided is too weak.'),
//                           );
//                           // Find the ScaffoldMessenger in the widget tree
//                           // and use it to show a SnackBar.
//                           // ignore: use_build_context_synchronously
//                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                           //print('The password provided is too weak.');
//                         } else if (e.code == 'email-already-in-use') {
//                           SnackBar snackBar = const SnackBar(
//                             content: Text(
//                                 'The account already exists for that email.'),
//                           );
//                           // ignore: use_build_context_synchronously
//                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                           // print('The account already exists for that email.');
//                         } else {
//                           debugPrint('another error: $e');
//                         }
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 50, vertical: 10),
//                         textStyle: const TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                     child: const Text('SIGN UP'),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Text("Already have an account?"),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, 'login');
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 50, vertical: 10),
//                         textStyle: const TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                     child: const Text('SIGN IN'),
//                   ),
//                 ]),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  // Function to display SnackBar for error messages
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  // Function to handle sign-up
  Future<void> _registerUser() async {
    final emailText = email.text.trim();
    final passwordText = password.text.trim();
    final nameText = nameController.text.trim();

    if (emailText.isEmpty || passwordText.isEmpty || nameText.isEmpty) {
      _showSnackBar(context, "Please fill in all fields.");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailText, password: passwordText);
      // Navigate to login page after successful registration
      Navigator.pushNamed(context, 'login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        _showSnackBar(context, "The account already exists for this email.");
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
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Top section with title
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png', // Replace with your app's logo
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Create Your Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Join us and start your journey!",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Registration form card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
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
                  // Name input field
                  _buildTextField(
                    controller: nameController,
                    hintText: "Name",
                    icon: Icons.person,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  // Email input field
                  _buildTextField(
                    controller: email,
                    hintText: "Email Address",
                    icon: Icons.email,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  // Password input field
                  _buildTextField(
                    controller: password,
                    hintText: "Password",
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // Sign-Up button
                  ElevatedButton(
                    onPressed: _registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0083B0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Navigate to login button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF0083B0),
                            fontWeight: FontWeight.bold,
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