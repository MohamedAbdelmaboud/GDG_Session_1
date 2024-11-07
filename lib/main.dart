import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(
        title: 'Validation Form',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final key = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Form(
          key: key,
          autovalidateMode: autovalidateMode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
                  border: OutlineInputBorder(),
                ),
                validator: FormValidator.validateEmail,
              ),
              TextFormField(
                onChanged: (value) {
                  debugPrint("Value is Changed: $value");
                },
                onFieldSubmitted: (value) {
                  debugPrint("Enter Done !");
                },
                onSaved: (value) {
                  password = value ?? '';
                },
                decoration: const InputDecoration(
                  hintText: 'Enter pass',
                  border: OutlineInputBorder(),
                ),
                validator: FormValidator.validatePass,
              ),
              MaterialButton(
                  child: const Text('send data'),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      key.currentState!.save();
                      debugPrint(password);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                    }
                  }),
            ],
          ),
        ));
  }
}

class FormValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "You must enter your email";
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return "You must enter vaild email";
    }
    return null;
  }

  static String? validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return "You must enter your pass";
    } else if (value.length < 8) {
      return "u must enter at least 8 char";
    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$')
        .hasMatch(value)) {
      return "a password that must contain both letters and numbers";
    }
    return null;
  }
}
