import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/components/MyButton.dart';
import 'package:flutter_login/components/MyTextField.dart';
import 'package:flutter_login/components/square.dart';

class register extends StatefulWidget
{
  final Function()? onTap;
  const register({super.key, required this.onTap});

  @override
  State<register> createState() => _LoginState();
}

class _LoginState extends State<register> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmpasswordController = TextEditingController();

  // sign users in
  void signUserUp() async{

    //show dialogue box
    showDialog(context: context, builder: (context)
    {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    try {
      if(passwordController.text == confirmpasswordController.text)
        {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
        }
      else
        {
          showErrorMessage("Password doesn't match");
        }

      Navigator.pop(context);
    } on FirebaseAuthException catch(e)
    {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }


  }

  void showErrorMessage(String message)
  {
    showDialog(context: context, builder: (context)
    {
      return const AlertDialog(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text('Incorrect Email',
            style: TextStyle(color: Colors.white
            ),
          ),
        ),
      );
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body:  SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25,),
                const Icon(Icons.lock,
                  size: 50,),
                const SizedBox(height: 25,),
                Text('Let\'s Create An Account For You!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20,),
                MyTextField(
                  controller: emailController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 20,),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20,),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text('Or Continue With',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Button
                    SquareTile(imagePath: 'assets/google.png',),
                    SizedBox(width: 15,),
                    // Apple Button
                    SquareTile(imagePath: 'assets/apple.png',),
                  ],
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have An Account',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Login Now',
                        style: TextStyle(
                          color: Colors.blue,
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
      ),
    );
  }
}
