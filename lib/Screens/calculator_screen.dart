import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '='
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 9.5,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              alignment: Alignment.centerRight,
              child: Text(
                userInput,
                style: TextStyle(
                    fontSize: 32, color: Colors.white.withOpacity(.8)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: TextStyle(
                    fontSize: 48,
                    color: Colors.white.withOpacity(.8),
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: buttonList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return customButtom(buttonList[index]);
                  }),
            ))
          ],
        ),
      ),
    );
  }

  Widget customButtom(String text) {
    return InkWell(
      splashColor: const Color(0xFF1d2630),
      onTap: () {
        setState(() {
          handleButton(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(.1),
                  blurRadius: 4,
                  spreadRadius: 0.5,
                  offset: const Offset(-3, -3))
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: getColor(text)),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "(" ||
        text == ")") {
      return const Color.fromARGB(255, 252, 100, 100);
    } else {
      return Colors.white;
    }
  }

  getBgColor(String text) {
    if (text == "AC") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    if (text == "=") {
      return const Color.fromARGB(255, 104, 200, 159);
    }
    return const Color(0xFF1d2630);
  }

  handleButton(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(
          0,
          userInput.length - 1,
        );
        return;
      } else {
        return null;
      }
    }

    if (text == '=') {
      result = calculate();
      userInput = result;

      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
    }

    userInput = userInput + text.replaceAll("=", "");
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
