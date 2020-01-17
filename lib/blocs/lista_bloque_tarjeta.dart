import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/tarjeta_modelo.dart';
import 'dart:convert';
import '../helpers/tarjeta_colors.dart';

class TarjetaListaBloque{
  BehaviorSubject<List<TarjetaResultados>> _cardsCollection = BehaviorSubject<List<TarjetaResultados>>();

  List<TarjetaResultados> _cardResults;

  //Retrieve data from Stream --aceder a data de tarjeta
  Stream<List<TarjetaResultados>> get cardList => _cardsCollection.stream;

  //metodo q se encarga de leer arch json e insertar
  void initialData() async {
    var initialData = await rootBundle.loadString('data/inicialData.json');
    var decodedJson = jsonDecode(initialData);
    _cardResults = TarjetaModelo.fromJson(decodedJson).results;
    for (var i = 0; i < _cardResults.length; i++) {
      _cardResults[i].cardColor = TarjetaColor.baseColors[i];
    }
    _cardsCollection.sink.add(_cardResults);
  }

  TarjetaListaBloque(){
    initialData();
  }

  void addCardToList(TarjetaResultados newCard){
    _cardResults.add(newCard);
    _cardsCollection.sink.add(_cardResults);
  }

  void dispose() {
    _cardsCollection.close();
  }
}

final cardListBloc = TarjetaListaBloque();