import 'package:flutter/material.dart';

void main() => runApp(MyCalculator());

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  // Constructor
  Calculator({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  int a = -1, b = -1;
  String op = "None";

  @override
  Widget build(BuildContext context) { // creating the widget
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Riana Does Maths")
      ),
      body: new Container( //defines the content of the body
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // displaying stuff
            Container(
              color: Colors.transparent,
              child: new Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                constraints: BoxConstraints.expand(
                  height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 100.0,
                ),
                decoration: new BoxDecoration(
                  color: new Color.fromRGBO(113, 128, 93, 100),
                  borderRadius: new BorderRadius.all(Radius.circular(10))
                ),
                alignment: Alignment.bottomRight,
                child: Text("$output",
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.black54
                  ),
                  textAlign: TextAlign.right,
                ),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("7", _setval, 7),
                _button("8", _setval, 8),
                _button("9", _setval, 9),
                _button("+", _arg, 0)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("4", _setval, 4),
                _button("5", _setval, 5),
                _button("6", _setval, 6),
                _button("-", _arg, 1)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("1", _setval, 1),
                _button("2", _setval, 2),
                _button("3", _setval, 3),
                _button("*", _arg, 2)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("C", _clear, 0),
                _button("0", _setval, 0),
                _button("=", _disp, 0),
                _button("/", _arg, 3)
              ],
            )
          ],
        )
      )
    );
  }

  void _clear(int val) {
    setState((){
      a = b = -1;
      output = "0";
    });
  }

  void _disp(int val) {
    if( a != -1 && b != -1 ) {
      int ans = 0;
      if( op == "add") ans = a+b;
      else if( op == "sub") ans = a-b;
      else if( op == "mul") ans = a*b;
      else if( op == "div") ans = a~/b;
      setState((){
        output = ans.toString();
        a = b = -1;
      });
    }
  }

  void _arg(int val) {
    String arg = "";
    if( val == 0 ) arg = "add";
    else if( val == 1 ) arg = "sub";
    else if ( val == 2 ) arg = "mul";
    else if ( val == 3 ) arg = "div";
    setState((){
      op = arg;
    });
  }

  void _setval(int val) {
    if( a == -1 ) {
      setState((){
        a = val;
        output = a.toString();
      });
    } else if ( a != -1 && op != "None" ) {
      setState((){
        b = val;
        output = b.toString();
      });
    }
  }
}

Widget _button (String number, Function(int) f, int val) {
  return MaterialButton(
    shape: new CircleBorder(),
    height: 100.0,
    minWidth: 100.0,
    child: Text(number,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)
    ),
    textColor: Colors.white,
    color: Colors.black45,
    onPressed: () {
      print(val);
      f(val);
    } // to pay respect
  );
}