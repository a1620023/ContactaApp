import 'package:flutter/material.dart';
import '../../helpers/tarjeta_colors.dart';
//import '../widgets/card_chip.dart';
import '../../blocs/tarjeta_bloque.dart';
import '../../blocs/bloque_provedor.dart';

class TarjetaFrente extends StatelessWidget{
  final int rotatedTurnsValue;
  TarjetaFrente({this.rotatedTurnsValue});

  @override
  Widget build(BuildContext context) {
    final TarjetaBloque bloc = BloqueProvedor.of<TarjetaBloque>(context);

    final _usuarioNombres = Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder<String>(
            stream: bloc.usuarioNombres,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? _formatCardNumber(snapshot.data)
                  : _formatCardNumber('0000000000000000');
            },
          ),
        ],
      ),
    );

    final _usuarioActividad = Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder<String>(
            stream: bloc.usuarioActividad,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? _formatCardNumber(snapshot.data)
                  : _formatCardNumber('0000000000000000');
            },
          ),
        ],
      ),
    );

    final _usuarioTelefono = Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder<String>(
            stream: bloc.usuarioTelefono,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? _formatCardNumber(snapshot.data)
                  : _formatCardNumber('0000000000000000');
            },
          ),
        ],
      ),
    );

    final _usuarioCorreo = Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder<String>(
            stream: bloc.usuarioCorreo,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? _formatCardNumber(snapshot.data)
                  : _formatCardNumber('0000000000000000');
            },
          ),
        ],
      ),
    );

    final _usuarioDireccion = Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder<String>(
            stream: bloc.usuarioDireccion,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? _formatCardNumber(snapshot.data)
                  : _formatCardNumber('0000000000000000');
            },
          ),
        ],
      ),
    );
        
    final _cardOwner = Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 44.0),
      child: StreamBuilder(
        stream: bloc.usuarioEmpresa,
        builder: (context, snapshot) => Text(
              snapshot?.data ?? 'NOMBRES',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
      ),
    );

    final _cardLogo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25.0, right: 45.0),
          child: Image(
            image: AssetImage('assets/visa_logo.png'),
            width: 45.0,
            height: 22.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 45.0),
          child: StreamBuilder(
              stream: bloc.cardType,
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData ? snapshot.data : '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                );
              }),
        ),
      ],
    );

    return StreamBuilder<int>(
        stream: bloc.cardColorIndexSelected,
        initialData: 0,
        builder: (context, snapshopt) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: TarjetaColor.baseColors[snapshopt.data]),
            child: RotatedBox(
              quarterTurns: rotatedTurnsValue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _cardLogo,
                  //CardChip(),
                  _usuarioNombres,
                  _usuarioActividad,
                  _usuarioTelefono,
                  _usuarioCorreo,
                  _usuarioDireccion,
                  _cardOwner,
                ],
              ),
            ),
          );
        });
  }

  Widget _formatCardNumber(String cardNumber) {
    cardNumber = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    List<Widget> numberList = new List<Widget>();
    var counter = 0;
    for (var i = 0; i < cardNumber.length; i++) {
      counter += 1;
      numberList.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: Text(
            cardNumber[i],
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
      if (counter == 4) {
        counter = 0;
        numberList.add(SizedBox(width: 26.0));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numberList,
    );
  }

}
