import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:distanciapp/constants/colors.dart';


class Registerview extends StatefulWidget {
  const Registerview({Key? key}) : super(key: key);
  @override
  _Registerview createState() => _Registerview();
}

class _Registerview extends State<Registerview> {
  int _currentStep = 0;
  bool _hiddenPassword = true;
  IconData _currentVisibility = Icons.visibility_off;
  @override
  void initState() {
    super.initState();
  }
  void _onTapVisibility() {
    setState(() {
      _hiddenPassword = !_hiddenPassword;
      _currentVisibility =
      (_hiddenPassword) ? Icons.visibility_off :
      Icons.visibility;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black87,),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed("/login"),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          "Register",
          style: TextStyle(color: AppColors.text_light),
        ),
      ),
      body: _body(),
    );
  }
  Widget _body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: const Text(
              "Complete la siguiente información",
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              type: StepperType.vertical,
              steps: _form(),
              onStepTapped: (step) => setState(() =>
              _currentStep = step),
              onStepContinue: _currentStep == _form().length - 1
                  ? ()
              {Navigator.of(context).pushReplacementNamed("/home");
              }
                  : () {
                final isLastStep = _currentStep ==
                    _form().length - 1;
                if (isLastStep) {
                  print("complete");
                } else {
                  setState(() => _currentStep += 1);
                }
              },
              onStepCancel: _currentStep == 0
                  ? () {}
                  : () {
                setState(() => _currentStep -= 1);
              },
            ),
          ),
        ],
      ),
    );
  }
  List<Step> _form() => [
    Step(
      title: const Text("Nombre y Apellido"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("Nombre"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_rounded),
                  labelText: "Nombre",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese su nombre completo",
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    ),
    Step(
      title: const Text("Correo"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("Correo"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Correo",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese su correo",
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    ),
    Step(

      title: const Text("Contraseña"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            //obscureText: _hiddenPassword,
            child: TextField(
              key: ValueKey("Contraseña"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    (_hiddenPassword) ? Icons.lock_rounded :
                    Icons.lock_open_rounded,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_currentVisibility),
                    onPressed: _onTapVisibility,
                  ),
                  labelText: "Contraseña",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Contraseña",
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    )
  ];

}
