import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Calculadora'),
    );
  }
}

String strInput = "";
final txtEntrada = TextEditingController();
final txtResultado = TextEditingController();

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState() {
    super.initState();
    txtEntrada.addListener(() {});
    txtResultado.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: new TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "0",
                    hintStyle: TextStyle(
                      fontSize: 40,
                      fontFamily: 'RobotoMono',
                    )),
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'RobotoMono',
                ),
                textAlign: TextAlign.right,
                controller: txtEntrada,
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
              )),
            new Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: new InputDecoration.collapsed(
                    hintText: "Resultado",
                    fillColor: Colors.deepPurpleAccent,
                    hintStyle: TextStyle(fontFamily: 'RobotoMono')),
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: 42,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold
                    // color: Colors.deepPurpleAccent
                ),
                textAlign: TextAlign.right,
                controller: txtResultado,
                )),
          SizedBox( height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              btnAC('AC', const Color(0xFFF5F7F9)),
              btnBorrar(),
              boton('%',const Color(0xFFF5F7F9),),
              boton('/',const Color(0xFFF5F7F9),),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              boton('7', Colors.white),
              boton('8', Colors.white),
              boton('9', Colors.white),
              boton('*',const Color(0xFFF5F7F9),)
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              boton('4', Colors.white),
              boton('5', Colors.white),
              boton('6', Colors.white),
              boton('-',const Color(0xFFF5F7F9),),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              boton('1', Colors.white),
              boton('2', Colors.white),
              boton('3', Colors.white),
              boton('+', const Color(0xFFF5F7F9)),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              boton('0', Colors.white),
              boton('.', Colors.white),
              btnIgual(),
            ],),
            SizedBox(height: 10.0,)
          ],
        ),
    );
  }

  Widget boton(btntxt, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btntxt,
          style: TextStyle(
              fontSize: 28.0, color: Colors.black, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            txtEntrada.text = txtEntrada.text + btntxt;
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnAC(btntext, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 28.0, color: Colors.black, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            txtEntrada.text = "";
            txtResultado.text = "";
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnBorrar() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Icon(Icons.backspace, size: 35, color: Colors.blueGrey),
        onPressed: () {
          txtEntrada.text = (txtEntrada.text.length > 0)
              ? (txtEntrada.text
                  .substring(0, txtEntrada.text.length - 1))
              : "";
        },
        color: const Color(0xFFF5F7F9),
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnIgual() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          '=',
          style: TextStyle(
              fontSize: 28.0, color: Colors.black, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          Parser p = new Parser();
          ContextModel cm = new ContextModel();
          Expression exp = p.parse(txtEntrada.text);
          setState(() {
            txtResultado.text = exp.evaluate(EvaluationType.REAL, cm).toString();
          });
        },
        color: Colors.cyan,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

}