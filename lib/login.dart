import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  var f = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.help),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.question_answer),
          )
        ],
        elevation: 20,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: f,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'images/pngfind.com-galaga-png-2648894.png',
                      color: Colors.blue,
                    )),
              ),
              TextFormField(
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
                // autofocus: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return " Enter your valid email address";
                  } else if (value.length < 10) {
                    return "Email must at least 10 characters";
                  } else if (value.contains('@') == false) {
                    return "Invalid email address";
                  } else if (EmailValidator.validate(value) == false) {
                    return "Invalid email address!!";
                  } else {
                    return null;
                  }
                },
                maxLength: 30,
                cursorColor: Colors.black,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    counterText: '',
                    helperText: 'Enter your valid email address',
                    helperStyle: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    labelText: 'Email Adress',
                    labelStyle: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                    prefixIcon: Icon(Icons.email, color: Colors.blue.shade400),
                    suffixIcon: const Icon(
                      Icons.check,
                      color: Colors.pink,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.black, width: 2),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                    maxLength: 30,
                    obscureText: true,
                    obscuringCharacter: '*',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 5) {
                        return "Must at least 5 characters";
                      } else {
                        return null;
                      }
                    },
                    inputFormatters: const [],
                    cursorColor: Colors.cyan,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        counterText: '',
                        helperText: 'Enter your Password',
                        helperStyle: const TextStyle(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                        labelText: 'Your Password',
                        labelStyle: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                        prefixIcon:
                            const Icon(Icons.lock, color: Colors.orangeAccent),
                        suffixIcon: const Icon(
                          Icons.check,
                          color: Colors.pink,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ))),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (f.currentState!.validate() == true) {
                        Navigator.pushReplacementNamed(context, 'page_home');
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'page_register');
                },

                child: const Text(
                  'Register Here',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
