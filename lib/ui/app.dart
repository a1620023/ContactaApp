import 'package:Contacta/ui/widgets/tarjeta_lista.dart';
import 'package:flutter/material.dart';
import '../ui/tarjeta_tipo.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
            'Contacta',
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu,
          color: Colors.black),
          onPressed: (){},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add,
            color: Colors.black),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TarjetaTipo()));
            },
          )
        ]
      ),
      body: TarjetaLista(),
    );
  }
  
}