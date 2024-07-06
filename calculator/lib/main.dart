import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  String _intermediateOutput = "0"; 
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      _output = "0";
      _intermediateOutput = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(_output);
      operand = buttonText;
      _intermediateOutput = _output; 
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(_output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "×") {
        _output = (num1 * num2).toString();
      } else if (operand == "÷") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      if (_output == "0" || _output == _intermediateOutput) {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String buttonText, Color color, {Color textColor = Colors.white, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 80.0,
          child: ElevatedButton(
            onPressed: () => buttonPressed(buttonText),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 24.0,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48.0, color: Colors.white),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("AC", Colors.grey, textColor: Colors.black),
                  buildButton("+/-", Colors.grey, textColor: Colors.black),
                  buildButton("%", Colors.grey, textColor: Colors.black),
                  buildButton("÷", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("7", const Color.fromARGB(255, 51, 51, 51)),
                  buildButton("8", const Color.fromARGB(255, 51, 51, 51)),
                  buildButton("9", const Color.fromARGB(255, 51, 51, 51)),
                  buildButton("×", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", const Color.fromARGB(255, 51, 51, 51)),
                  buildButton("5", const Color.fromARGB(255, 51, 51, 51)),
                  buildButton("6", const Color.fromARGB(255, 51, 51, 51)),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", const Color.fromARGB(255, 51, 51, 51)),
                  buildButton("2", const Color.fromARGB(255, 51, 51, 51)),
                  buildButton("3", const Color.fromARGB(255, 51, 51, 51)),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("0", const Color.fromARGB(255, 51, 51, 51), flex: 2 ),
                  buildButton(".", const Color.fromARGB(255, 51, 51, 51)),
                  buildButton("=", Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
