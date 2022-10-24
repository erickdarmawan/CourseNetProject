import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  var isChecked = false;
  var eyeChecked = false;

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextFormField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: GestureDetector(
                    onTap: () {
                      if (eyeChecked == true) {
                        eyeChecked = true;
                      } else {
                        eyeChecked == false;
                      }
                    },
                    child: const Icon(Icons.remove_red_eye)),
              ),
            ),
            TextButton(
                onPressed: _toggle,
                child: Text(_obscureText ? "Show" : "Hide")),
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                if (isChecked == true) {
                  isChecked = false;
                } else {
                  (isChecked = false);
                  isChecked = true;
                }
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}
