import 'dart:async';
import 'package:Contacta/helpers/tarjeta_colors.dart';
import 'package:Contacta/models/tarjeta_color_modelo.dart';
import 'package:rxdart/rxdart.dart';
import '../helpers/tarjeta_colors.dart';
import '../models/tarjeta_modelo.dart';
import './validators.dart';
import '../blocs/bloque_provedor.dart';
import '../blocs/lista_bloque_tarjeta.dart';

class TarjetaBloque with Validators implements BlocBase {
  BehaviorSubject<String> _usuarioNombres = BehaviorSubject<String>();
  BehaviorSubject<String> _usuarioActividad = BehaviorSubject<String>();
  BehaviorSubject<String> _usuarioTelefono = BehaviorSubject<String>();
  BehaviorSubject<String> _usuarioCorreo = BehaviorSubject<String>();
  BehaviorSubject<String> _usuarioDireccion = BehaviorSubject<String>();
  BehaviorSubject<String> _usuarioEmpresa = BehaviorSubject<String>();
  BehaviorSubject<String> _cardType = BehaviorSubject<String>();
  BehaviorSubject<int> _cardColorIndexSelected = BehaviorSubject<int>(seedValue: 0);

  final _cardsColors =  BehaviorSubject<List<TarjetaColorModelo>>();

  //Add data stream
  Function(String) get changeUsuarioNombres => _usuarioNombres.sink.add;
  Function(String) get changeUsuarioActividad => _usuarioActividad.sink.add;
  Function(String) get changeUsuarioTelefono => _usuarioTelefono.sink.add;
  Function(String) get changeUsuarioCorreo => _usuarioCorreo.sink.add;
  Function(String) get changeUsuarioDireccion => _usuarioDireccion.sink.add;
  Function(String) get selectUsuarioEmpresa => _usuarioEmpresa.sink.add;
  Function(String) get selectCardType => _cardType.sink.add;

  //Retrieve data from stream
  Stream<String> get usuarioNombres => _usuarioNombres.stream.transform(validateCardHolderName);
  Stream<String> get usuarioActividad => _usuarioActividad.stream.transform(validateCardHolderName);
  Stream<String> get usuarioTelefono => _usuarioTelefono.stream.transform(validateCardHolderName);
  Stream<String> get usuarioCorreo => _usuarioCorreo.stream.transform(validateCardHolderName);
  Stream<String> get usuarioDireccion => _usuarioDireccion.stream.transform(validateCardHolderName);
  Stream<String> get usuarioEmpresa => _usuarioEmpresa.stream.transform(validateCardHolderName);
  Stream<String> get cardType => _cardType.stream;
  Stream<int> get cardColorIndexSelected => _cardColorIndexSelected.stream;
  Stream<List<TarjetaColorModelo>> get cardColorsList => _cardsColors.stream;
  Stream<bool> get savecardValid => Observable.combineLatest5(usuarioNombres,
      usuarioActividad, usuarioTelefono, usuarioCorreo, usuarioDireccion, (ch, cn, cm, cy, cv) => true);

  void saveCard() {
    final newCard = TarjetaResultados(
        usuarioNombres: _usuarioNombres.value,
        usuarioActividad: _usuarioActividad.value.replaceAll(RegExp(r'\s+\b|\b\s'), ''),
        usuarioTelefono: _usuarioTelefono.value,
        usuarioCorreo: _usuarioCorreo.value,
        usuarioDireccion: _usuarioDireccion.value,
        cardColor: TarjetaColor.baseColors[_cardColorIndexSelected.value],
        usuarioEmpresa: _usuarioEmpresa.value,
        cardType: _cardType.value
        );
    cardListBloc.addCardToList(newCard);
  }

  void selectCardColor(int colorIndex){
    TarjetaColor.tarjetaColors.forEach((element) => element.isSelected = false);
    TarjetaColor.tarjetaColors[colorIndex].isSelected = true;
    _cardsColors.sink.add(TarjetaColor.tarjetaColors);
    _cardColorIndexSelected.sink.add(colorIndex);
  }

  void dispose(){
    _usuarioNombres.close();
    _usuarioActividad.close();
    _usuarioTelefono.close();
    _usuarioCorreo.close();
    _usuarioDireccion.close();
    _cardsColors.close();
    _cardColorIndexSelected.close();
    _usuarioEmpresa.close();
    _cardType.close();
  }

}