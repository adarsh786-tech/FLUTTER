import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calci',
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calci'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String output = "0";
  String _output = "0";
  double n1= 0;
  double n2= 0;
  String operand = "";





  buttonPressed(String buttonTxt)
  {
    if(buttonTxt == "C")
      {
        output = "0";
        _output = "0";
        n1= 0;
        n2= 0;
        operand = "";
      }
    else if(buttonTxt == "+" || buttonTxt == "-" || buttonTxt == "*" || buttonTxt == "/" || buttonTxt == "%")
      {
        n1= double.parse(output);
        operand = buttonTxt;
        _output = "0";
      }
    else if(buttonTxt == ".")
      {
        if(_output.contains("."))
          {
            print("Already contains a decimal");
            return;
          }
        else
          {
            _output+=buttonTxt;
          }
      }
      else if(buttonTxt == "1/x")
      {
        n1 = 1/n1;
        n2 = 1/n2;
      }
    else if(buttonTxt == "=")
      {
        n2= double.parse(output);
        if(operand == "+")
          {
            _output = (n1+n2).toString();
          }
        else if(operand == "-")
        {
          _output = (n1-n2).toString();
        }
        else if(operand == "*")
        {
          _output = (n1*n2).toString();
        }
        else if(operand == "/")
        {
          
          _output = (n1/n2).toString();
        }
        else if(operand == "%")
        {
          _output = (n1%n2).toString();
        }
         operand="";
      }
    else
      {
        _output+= buttonTxt;
      }
    print(_output);
    setState(() {
      output= double.parse(_output).toString();
    });

  }


  Widget createNewButton(String txt) {
    return new Expanded(

      child: new OutlineButton(
        padding: new EdgeInsets.all(24.0),

        child: new Text(txt,
        style: TextStyle(
          fontSize: 18.0,
        ),
        ),
        onPressed: () {
          buttonPressed(txt);
        },



        textColor: Colors.black,

      ),

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: new Column(
          children: <Widget>[

            new Container(
              alignment: Alignment.centerRight,
                padding: new EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 12.0,
                ),
              child: new Text(output,

                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
                )
            ),
            new Expanded(child: new Divider()),
            Column(
              children: [

                new Row
                  (
                    children:
                    [
                      createNewButton('%'),
                      createNewButton('1/x'),
                      createNewButton('C'),
                      createNewButton('/'),
                    ]
                ),

                new Row
                (
                    children:
                    [
                      createNewButton('7'),
                      createNewButton('8'),
                      createNewButton('9'),
                      createNewButton('*'),
                    ]
                ),

                new Row
                  (
                    children:
                    [
                      createNewButton('4'),
                      createNewButton('5'),
                      createNewButton('6'),
                      createNewButton('-'),

                    ]
                ),

                new Row
                  (
                    children:
                    [
                      createNewButton('1'),
                      createNewButton('2'),
                      createNewButton('3'),
                      createNewButton('+'),
                    ]
                ),

                new Row
                  (
                    children:
                    [
                      createNewButton('.'),
                      createNewButton('0'),
                      // createNewButton('00'),
                      createNewButton('='),

                    ]
                ),



              ],
            ),
          ],
        ),


      ),
    );
  }


}
