import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Dropdown Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,

      home: Scaffold(
        appBar: AppBar(title: const Text(_title),
        backgroundColor: Colors.orange,),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue;
   String _value = '';

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2030)
    );
    if(picked != null) setState(() => _value = "${picked.day.toString()}-${picked.month.toString()}-${picked.year.toString()}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children:<Widget> [ 
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[ Text(_value),
          RaisedButton(onPressed: _selectDate, child: new Text('Choose date'),)]
           )
          ,DropdownButton<String>(
          value: dropdownValue,
        isExpanded: true,
          hint: Text("Choose a city"),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              Scaffold.of(context).showSnackBar(new SnackBar(
                content:new Text("Place: "+dropdownValue+"     Date:"+_value),
                duration: new Duration(seconds: 2),
                backgroundColor: Colors.orange,
                action: SnackBarAction(onPressed: (){
                  setState(() {
                   dropdownValue=null; 
                   _value="";
                  });
                },
                label: "Clear",
                textColor: Colors.black,),));
            });
          },
          items: <String>['Mumbai', 'Pune', 'Delhi', 'Chennai']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        
         ]
      ),
      )
    );
  }
}