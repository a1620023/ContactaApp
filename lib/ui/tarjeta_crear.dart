import 'dart:async';

import 'package:Contacta/helpers/tarjeta_colors.dart';
import 'package:flutter/material.dart';
import '../ui/widgets/my_appbar.dart';
import '../ui/widgets/flip_card.dart';
import '../ui/widgets/card_front.dart';
import '../ui/widgets/card_back.dart';
import '../helpers/card_colors.dart';
import '../helpers/formatters.dart';
import '../blocs/tarjeta_bloque.dart';
import '../blocs/bloque_provedor.dart';
import '../models/tarjeta_color_modelo.dart';
import '../ui/card_wallet.dart';

class TarjetaCrear extends StatefulWidget{
  @override
  _TarjetaCrear createState() => _TarjetaCrear();
}

class _TarjetaCrear extends State<TarjetaCrear>{
  final GlobalKey<FlipCardState> animatedStateKey = GlobalKey<FlipCardState>();

  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    animatedStateKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    final TarjetaBloque bloc = BloqueProvedor.of<TarjetaBloque>(context);

    final _creditCard = Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Card(
        color: Colors.grey[100],
        elevation: 0.0,
        margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child: FlipCard(
          key: animatedStateKey,
          front: CardFront(rotatedTurnsValue: 0),
          back: CardBack(),
        ),
      ),
    );

    final _usuarioNombres = StreamBuilder(
        stream: bloc.usuarioNombres,
        builder: (context, snapshot) {
          return Container(
          width: 300.0,
          height: 30.0,
          child: TextField(
            textCapitalization: TextCapitalization.characters,
            onChanged: bloc.changeUsuarioNombres,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Nombre de usuario',
              errorText: snapshot.error,
            ),
          ),
        );
      });

    final _usuarioActividad = StreamBuilder(
      stream: bloc.usuarioActividad,
        builder: (context, snapshot) {
          return Container(
          width: 300.0,
          height: 30.0,
          child: TextField(
            onChanged: bloc.changeUsuarioActividad,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Actividad del usuario',
              errorText: snapshot.error,
            ),
          ),
        );
      });

    final _usuarioTelefono = StreamBuilder(
      stream: bloc.usuarioTelefono,
        builder: (context, snapshot) {
          return Container(
          width: 300.0,
          height: 30.0,
          child: TextField(
            onChanged: bloc.changeUsuarioTelefono,
            keyboardType: TextInputType.number,
            maxLength: 9,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Nombre de usuario',
              counterText: '',
              errorText: snapshot.error,
            ),
          ),
        );
      });

    final _usuarioCorreo = StreamBuilder(
        stream: bloc.usuarioCorreo,
        builder: (context, snapshot) {
          return Container(
          width: 300.0,
          height: 30.0,
          child: TextField(
            onChanged: bloc.changeUsuarioCorreo,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Correo del usuario',
              errorText: snapshot.error,
            ),
          ),
        );
      });

    final _usuarioDireccion = StreamBuilder(
        stream: bloc.usuarioDireccion,
        builder: (context, snapshot) {
          return Container(
          width: 300.0,
          height: 30.0,
          child: TextField(
            onChanged: bloc.changeUsuarioDireccion,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Direccion del usuario',
              errorText: snapshot.error,
            ),
          ),
        );
      });

    final _saveCard = StreamBuilder(
      stream: bloc.savecardValid,
      builder: (context, snapshot) {
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          child: RaisedButton(
            child: Text(
              'Save Card',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            onPressed: snapshot.hasData
                ? () {
                    var blocProviderCardWallet = BloqueProvedor(
                      bloc: bloc,
                      child: CardWallet(),
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => blocProviderCardWallet));
                  }
                : null,
          ),
        );
      },
    );

    return new Scaffold(
        appBar: MyAppBar(
          appBarTitle: 'Crear tarjeta',
          leadingIcon: Icons.arrow_back,
          context: context,
        ),
        backgroundColor: Colors.grey[100],
        body: ListView(
          itemExtent: 750.0,
          padding: EdgeInsets.only(top:10.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: _creditCard,
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        _usuarioNombres,
                        _usuarioActividad,
                        _usuarioTelefono,
                        _usuarioCorreo,
                        _usuarioDireccion,
                        
                        SizedBox(height: 20.0),
                        cardColors(bloc),
                        SizedBox(height: 50.0),
                        _saveCard,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget cardColors(TarjetaBloque bloc) {
    final dotSize =
        (MediaQuery.of(context).size.width - 220) / TarjetaColor.baseColors.length;

    List<Widget> dotList = new List<Widget>();

    for (var i = 0; i < TarjetaColor.baseColors.length; i++) {
      dotList.add(
        StreamBuilder<List<TarjetaColorModelo>>(
          stream: bloc.cardColorsList,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () => bloc.selectCardColor(i),
                child: Container(
                  child: snapshot.hasData
                      ? snapshot.data[i].isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 11.0,
                            )
                          : Container()
                      : Container(),
                  width: dotSize,
                  height: dotSize,
                  decoration: new BoxDecoration(
                    color: CardColor.baseColors[i],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dotList,
    );
}

}
