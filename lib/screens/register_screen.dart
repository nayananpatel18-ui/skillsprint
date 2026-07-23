import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;

  Future<void> register() async {

    if(!_formKey.currentState!.validate()) return;

    setState(() {
      loading=true;
    });

    try{

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(

        email: emailController.text.trim(),

        password: passwordController.text.trim(),

      );

      await userCredential.user!.updateDisplayName(
        nameController.text.trim(),
      );

      if(!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text("Account Created Successfully"),
        ),

      );

      Navigator.pop(context);

    }

    on FirebaseAuthException catch(e){

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(e.message ?? "Registration Failed"),
        ),

      );

    }

    setState(() {
      loading=false;
    });

  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(
        title: const Text("Create Account"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(24),

        child: Form(

          key:_formKey,

          child: Column(

            children:[

              TextFormField(

                controller:nameController,

                decoration:const InputDecoration(

                  labelText:"Full Name",

                  border:OutlineInputBorder(),

                ),

                validator:(v)=>v!.isEmpty?"Enter Name":null,

              ),

              const SizedBox(height:20),

              TextFormField(

                controller:emailController,

                decoration:const InputDecoration(

                  labelText:"Email",

                  border:OutlineInputBorder(),

                ),

                validator:(v)=>v!.isEmpty?"Enter Email":null,

              ),

              const SizedBox(height:20),

              TextFormField(

                controller:passwordController,

                obscureText:obscurePassword,

                decoration:InputDecoration(

                  labelText:"Password",

                  border:const OutlineInputBorder(),

                  suffixIcon:IconButton(

                    icon:Icon(
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

                validator:(v){

                  if(v==null||v.length<6){

                    return "Minimum 6 characters";

                  }

                  return null;

                },

              ),

              const SizedBox(height:20),

              TextFormField(

                controller:confirmPasswordController,

                obscureText:obscureConfirmPassword,

                decoration:InputDecoration(

                  labelText:"Confirm Password",

                  border:const OutlineInputBorder(),

                  suffixIcon:IconButton(

                    icon:Icon(

                      obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,

                    ),

                    onPressed:(){

                      setState(() {

                        obscureConfirmPassword=
                            !obscureConfirmPassword;

                      });

                    },

                  ),

                ),

                validator:(v){

                  if(v!=passwordController.text){

                    return "Passwords don't match";

                  }

                  return null;

                },

              ),

              const SizedBox(height:30),

              SizedBox(

                width:double.infinity,

                height:50,

                child:ElevatedButton(

                  onPressed:loading?null:register,

                  child:loading

                      ?const CircularProgressIndicator(
                          color:Colors.white,
                        )

                      :const Text("CREATE ACCOUNT"),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}