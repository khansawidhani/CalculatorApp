// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<String> buttonText = [
    "7",
    "8",
    "9",
    "/",
    "4",
    "5",
    "6",
    "*",
    "1",
    "2",
    "3",
    "-",
    ".",
    "0",
    "=",
    "+"
  ];
  String operation = "=";
  // String num1 = "0";
  // String num2 = "";
  String exp = "0";
  String result = "";
  String char = "";
  final TextStyle textStyle = const TextStyle(
      fontFamily: "Varela Round", fontSize: 35.0, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text("Simple Calculator"),
          actions: [
            SizedBox(
              width: 30,
              child: IconButton(
                alignment: Alignment.centerRight,
                iconSize: 28,
                padding: const EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                    exp = exp.substring(0, exp.length - 1);
                    });
                  },
                  icon: const Icon(Icons.keyboard_backspace_rounded)),
            ),
            SizedBox(
              width: 90.0,
              child: ElevatedButton(
                
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0.0),
                ),
                child: const Text("Clear",
                    style: TextStyle(
                        fontFamily: "Varela Round",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  setState(() {
                    exp = "0";
                    result = "";
                    operation = "=";
                  });
                },
              ),
            ),
          ],
        ),



        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigoAccent, width: 2.0),
                ),
                child: Column(
                  
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          exp,
                          style: textStyle,
                          textAlign: TextAlign.right,
                        )),
                      ],
                    ),
                    const SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                            width: 50.0,
                            child: Text(
                              operation,
                              style: textStyle,
                            )),
                        Expanded(
                            child: Text(
                          result,
                          style: textStyle,
                          textAlign: TextAlign.right,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                      ),
                      child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),

                        child: Text("Clear",
                            style: TextStyle(
                                fontFamily: "Varela Round",
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700)),
                      ),
                      onPressed: () {
                        setState(() {
                          exp = "0";
                          result = "";
                          operation = "=";
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: Container(child: buttonsGrid),
              ),
              
              Container(
                alignment: Alignment.center,
                height: 30,
                child: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "Developed by ",
                      style: TextStyle(color: Colors.black87, fontSize: 14.0)),
                  TextSpan(
                      text: "Khansa Widhani",
                      style: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold))
                ])),
              )
            ],
          ),
        ));
  }

  GridView get buttonsGrid {
    return GridView.builder(
      // physics: const NeverScrollableScrollPhysics(),
                  itemCount: buttonText.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            var char = buttonText[index];
                            if (char == "=") {
                              Parser p = Parser();
                              Expression expression = p.parse(exp);
                              ContextModel cm = ContextModel();
                              double eval = expression.evaluate(
                                  EvaluationType.REAL, cm);
                              RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
                              result =
                                  eval.toString().replaceAll((regex), "");
                            } else {
                              if (exp == "0") {
                                exp = char;
                              } else if (exp != "0" && exp.length < 16) {
                                exp += char;
                              }
                              // exp = exp == "0" ? exp = char : exp += char;
                              print("Expression : $exp");
                            }
                          });
                        },
                        child: Text(
                          buttonText[index],
                          style: textStyle,
                        ));
                  });
  }
}
