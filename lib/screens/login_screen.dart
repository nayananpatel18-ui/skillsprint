import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool loading = false;

  Future<void> login() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String message = e.message ?? "Login Failed";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

    }

    setState(() {
      loading = false;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Form(

            key: _formKey,

            child: Column(

              children: [

                const SizedBox(height:40),

                const Icon(
                  Icons.school,
                  size:90,
                  color: Colors.blue,
                ),

                const SizedBox(height:20),

                const Text(
                  "SkillSprint",
                  style: TextStyle(
                    fontSize:32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height:40),

                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText:"Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator:(value){

                    if(value==null||value.isEmpty){
                      return "Enter Email";
                    }

                    return null;
                  },
                ),

                const SizedBox(height:20),

                TextFormField(

                  controller: passwordController,

                  obscureText: obscurePassword,

                  decoration: InputDecoration(

                    labelText:"Password",

                    prefixIcon: const Icon(Icons.lock),

                    border: const OutlineInputBorder(),

                    suffixIcon: IconButton(

                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),

                      onPressed:(){

                        setState(() {
                          obscurePassword=!obscurePassword;
                        });

                      },

                    ),

                  ),

                  validator:(value){

                    if(value==null||value.isEmpty){
                      return "Enter Password";
                    }

                    return null;

                  },

                ),

                const SizedBox(height:30),

                SizedBox(

                  width:double.infinity,

                  height:50,

                  child: ElevatedButton(

                    onPressed: loading ? null : login,

                    child: loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("LOGIN"),

                  ),

                ),

                const SizedBox(height:20),

                Row(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    const Text("Don't have an account?"),

                    TextButton(

                      onPressed:(){

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_)=>const RegisterScreen(),
                          ),
                        );

                      },

                      child: const Text("Register"),

                    )

                  ],

                )

              ],

            ),

          ),

        ),

      ),

    );

  }

}