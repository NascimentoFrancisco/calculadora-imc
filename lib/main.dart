// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _intoText = "Informe seus dados";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _intoText = "Informe seus dados";
       _formKey = GlobalKey<FormState>();
    });
  }

  void _Calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      
      if(imc < 18.6){
        _intoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _intoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _intoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _intoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _intoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40){
        _intoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 189, 54, 13),
        actions: <Widget>[
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
        // ignore: prefer_const_literals_to_create_immutables
          children: <Widget> [
            Icon(Icons.person_outline, size: 120, color: Color.fromARGB(255, 189, 54, 13),),
            TextFormField(keyboardType: TextInputType.number,
              decoration: InputDecoration(
              labelText: "Peso em kg",
              labelStyle: TextStyle(color: Color.fromARGB(255, 189, 54, 13))
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Color.fromARGB(255, 189, 54, 13),fontSize: 25.0,),
              controller: weightController,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Insira seu peso";
                }
              },
            ),
            TextFormField(keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura em cm",
                labelStyle: TextStyle(color: Color.fromARGB(255, 189, 54, 13))
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Color.fromARGB(255, 189, 54, 13),fontSize: 25.0,),
              controller: heightController,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Insira sua altura";
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate()){
                      _Calculate();
                    }
                  },
                  child: Text('Calcular', style: TextStyle(color: Colors.white,fontSize: 25.0),),
                  color: Color.fromARGB(255, 189, 54, 13),
                ),
              ),
            ),
            Text(_intoText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color.fromARGB(255, 189, 54, 13), fontSize: 25.0),
            )
          ]
          ) 
        ),
      )
    );
  }
}
