import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  BMICalculatorState createState() => BMICalculatorState();
}

class BMICalculatorState extends State<BMICalculator> {
  double _weight = 0; // in kilograms
  double _height = 0; // in meters

  double _bmi = 0;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void calculateBMI() {
    setState(() {
      _bmi = _weight / (_height * _height);
    });
  }

  String getBMIResult() {
    if (_bmi < 18.5) {
      return 'Underweight';
    } else if (_bmi >= 18.5 && _bmi < 25) {
      return 'Normal';
    } else if (_bmi >= 25 && _bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Enter your weight (kg):',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _weight = double.parse(value);
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Enter your height (m):',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _heightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _height = double.parse(value);
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                calculateBMI();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Calculate BMI',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            _bmi > 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Your BMI: ${_bmi.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Result: ${getBMIResult()}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}