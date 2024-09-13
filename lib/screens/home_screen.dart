import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";
  String _operation = "";
  double _num1 = 0;

  static const EdgeInsets _padding = EdgeInsets.symmetric(vertical: 50, horizontal: 20);
  static const TextStyle _outputTextStyle = TextStyle(fontSize: 50, fontWeight: FontWeight.bold);
  static const TextStyle _buttonTextStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _buttonPressed(String buttonText) {
    if (buttonText == "AC") {
      _resetCalculator();
    } else if ("+-*/".contains(buttonText)) {
      _setOperation(buttonText);
    } else if (buttonText == "=") {
      _calculateResult();
    } else {
      _updateInput(buttonText);
    }
    
    setState(() {
      _output = _input.isEmpty ? _num1.toString() : _input;
      if (_output == "0.0") {
        _output = "0";
      }
    });
  }
    void _resetCalculator() {
    _output = "0";
    _input = "";
    _operation = "";
    _num1 = 0;
  }

  void _setOperation(String operation) {
    if (_input.isNotEmpty) {
      _num1 = double.tryParse(_input) ?? 0;
      _operation = operation;
      _input += operation;
    }
  }

  void _updateInput(String buttonText) {
    _input += buttonText;
  }

  void _calculateResult() {
    final double num2 = double.tryParse(_input.split(_operation).last) ?? 0;
    double result;
    switch (_operation) {
      case "+":
        result = _num1 + num2;
        break;
      case "-":
        result = _num1 - num2;
        break;
      case "*":
        result = _num1 * num2;
        break;
      case "/":
        result = _num1 / num2;
        break;
      default:
        result = _num1;
    }
    _input = _formatResult(result);
    _operation = "";
  }

  String _formatResult(double result) {
    if (result == result.toInt()) {
      return result.toInt().toString();
    } else {
      return result.toStringAsFixed(9).replaceFirst(RegExp(r'\.?0*$'), '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculadora")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: _padding,
            child: Text(_output, style: _outputTextStyle),
          ),
          const Expanded(child: Divider()),
          Column(
            children: [
              Row(children: [_buildButton("7"), _buildButton("8"), _buildButton("9"), _buildButton("/")]),
              Row(children: [_buildButton("4"), _buildButton("5"), _buildButton("6"), _buildButton("*")]),
              Row(children: [_buildButton("1"), _buildButton("2"), _buildButton("3"), _buildButton("-")]),
              Row(children: [_buildButton("."), _buildButton("0"), _buildButton("AC"), _buildButton("+")]),
              Row(children: [_buildButton("=")]),
            ],
          ),
        ],
      ),
    );
  }
    Widget _buildButton(String buttonText) {
    Color textColor;
    if (buttonText == "AC") {
      textColor = Colors.redAccent;
    } else if ("+-*/".contains(buttonText)) {
      textColor = Colors.white;
    } else if (buttonText == "=") {
      textColor = Colors.lightGreen;
    } else {
      textColor = Colors.grey;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
            textStyle: _buttonTextStyle,
          ),
          child: Text(buttonText, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }
}