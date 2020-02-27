import 'package:flutter/material.dart';

void main() => runApp(MyCalculator());

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
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
double size;
class _CalculatorState extends State<Calculator> {
  String output = "0", full = "", op = "", a_str = "", b_str = "";

  @override
  Widget build(BuildContext context) {
    size = (MediaQuery.of(context).size.width / 4)- 2;
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 46, 71),
      body: new Container(
        child: Column(
          children: <Widget>[
            // displaying stuff
            Container(
              margin: EdgeInsets.only( top: 50, bottom:20 ),
                padding: EdgeInsets.only(right: 20, top: 20),
                constraints: BoxConstraints.expand(height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 100.0),
                decoration: new BoxDecoration(color: Colors.black45),
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("$full",
                      style: TextStyle(
                        fontFamily: 'GoogleSansRegular',
                        color: Colors.white70,
                        fontSize: 30
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Text("$output",
                      style: TextStyle(
                        fontFamily: 'GoogleSansRegular',
                        color: Colors.white,
                        fontSize: 50
                      ),
                      textAlign: TextAlign.right,
                    )
                  ],
                )
            ),

            // buttons
            Column(
              children: <Widget>[
                Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _button("7", _setval, 7, false),
                    _button("8", _setval, 8, false),
                    _button("9", _setval, 9, false),
                    _button("+", _arg, 0, true)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _button("4", _setval, 4, false),
                    _button("5", _setval, 5, false),
                    _button("6", _setval, 6, false),
                    _button("-", _arg, 1, true)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _button("1", _setval, 1, false),
                    _button("2", _setval, 2, false),
                    _button("3", _setval, 3, false),
                    _button("×", _arg, 2, true)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _button("C", _clear, 0, true),
                    _button("0", _setval, 0, false),
                    _button("=", _disp, 0, true),
                    _button("÷", _arg, 3, true)
                  ],
                )
              ],
            )
          ],
        )
      )
    );
  }

  void _clear(int val) {
    setState((){
      a_str = b_str = full = "";
      output = "0";
    });
  }

  void _disp(int val) {
    int a = int.parse(a_str);
    int b = int.parse(b_str);
    if( a != -1 && b != -1 ) {
      int ans = 0;
      if( op == "add") ans = a+b;
      else if( op == "sub") ans = a-b;
      else if( op == "mul") ans = a*b;
      else if( op == "div") ans = a~/b;
      setState((){
        output = ans.toString();
        a_str = b_str = full = "";
      });
    }
  }

  void _arg(int val) {
    String arg = "", cmd = "";
    if( val == 0 ) {arg = "add"; cmd = "+";}
    else if( val == 1 ) {arg = "sub"; cmd = "-";}
    else if ( val == 2 ) {arg = "mul"; cmd = "×";}
    else if ( val == 3 ) {arg = "div"; cmd = "÷";}
    setState((){
      op = arg;
      full += " "+cmd+" ";
      output = "";
    });
  }

  void _setval(int val) {
    String val_str = val.toString();
    if( op == "" ) {
      setState((){
        a_str += val_str;
      });
    } else {
      setState((){
        b_str += val_str;
      });
    }
    if( output == "0" ) setState((){output = val_str;});
    else setState((){output += val_str;});
    setState((){full += val_str;});
  }
}

Widget _button (String number, Function(int) f, int val, bool func ) {
  Color clr = Colors.white;
  if( func ) clr = Color.fromARGB(255, 32, 96, 128);
  else clr = Color.fromARGB(255, 96, 96, 96);
  return Container(
    padding: EdgeInsets.all(2),
    width: size,
    height: size,
    child: RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 2,
      child: Text(number,
        style: TextStyle(
          fontFamily: 'GoogleSansRegular',
          fontSize: 40.0
        )
      ),
      textColor: Colors.white,
      color: clr,
      onPressed: () {
        f(val);
      }
    )
  );
}