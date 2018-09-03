import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
  home: new HomePage(),
));

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage>{
  final String url = "https://swapi.co/api/people";
  List data;

  //HomePageState(this.data);

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      //encode the url
        Uri.encodeFull(url),
        //only json response
        headers: {"Accept":"application/Json"}
    );
    print(response.body);
    setState((){
      var convertDataToJson = jsonDecode(response.body);//JSON.decode(response.body);
      data = convertDataToJson['results'];

    });
    return "Success";

  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Star Mass")
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length ,
        itemBuilder: (BuildContext context, int index){
          //test
          //return new Container(
            //child: new Center(
              //child: new Column(
               // crossAxisAlignment: CrossAxisAlignment.stretch,
               // children: <Widget>[
                  //new Card(
                   // child: new Container(
                       // child: new Text(data[index]['name']),
                       // padding: const EdgeInsets.all(20.0)
                    //),
                 // )
               // ],
             // ),
           // ),
         // );
          return new Card(
              child: RaisedButton(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Text(data[index]['name']),
                  new Text(data[index]['mass']+"Kg"),
                  new Text(data[index]['edited']),
                ],

              ),
                onPressed: () {
                //Navigate to second screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsPage()),
                  );
                },
              )
          );
          //test

        },
      ),
    );
  }
}

class DetailsPage extends StatefulWidget{

  final List value;
  DetailsPage({Key key, this.value}) : super (key: key);

  @override
  DetailsPageState createState() => new DetailsPageState();
}

class DetailsPageState extends State<DetailsPage>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: new AppBar(
      title: new Text("${widget.value}"),
    ),
    body: Center(
     child: RaisedButton(
          onPressed: (){
            Navigator.pop(context);
          },
        child: Text('go back'),
      ),
    ),
  );
  }
}