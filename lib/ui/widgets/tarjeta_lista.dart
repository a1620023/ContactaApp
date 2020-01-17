import 'package:Contacta/blocs/lista_bloque_tarjeta.dart';
import 'package:Contacta/models/tarjeta_modelo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
//import '../widgets/card_chip.dart';

class TarjetaLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return StreamBuilder<List<TarjetaResultados>>(
      stream: cardListBloc.cardList,
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            !snapshot.hasData
                ? CircularProgressIndicator()
                : SizedBox(
                    height: _screenSize.height * 0.8, //posicion de las tarjetas
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return TarjetaFromLista(
                          tarjetaModelo: snapshot.data[index],
                        );
                      },
                      itemCount: snapshot.data.length,
                      itemWidth: _screenSize.width * 0.8, //tamaño de las tarjetas
                      itemHeight: _screenSize.height * 0.4,
                      layout: SwiperLayout.STACK,
                      scrollDirection: Axis.horizontal,
                    ))
          ],
        );
      },
    );
  }
}

class TarjetaFromLista extends StatelessWidget {
  final TarjetaResultados tarjetaModelo;
  TarjetaFromLista({this.tarjetaModelo});

  @override
  Widget build(BuildContext context) {
    final _cardLogo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 25.0, right: 52.0),
          child: Image(
            image: AssetImage('assets/LOGO-FT-BRECOMPERU.png'),
            width: 55.0,
            height: 35.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 52.0),
          child: Text(
            tarjetaModelo.usuarioEmpresa,
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.0, //tamaño nombre empresa
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );

    // final _cardNumber = Padding(
    //   padding: const EdgeInsets.only(top: 13.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: <Widget>[
    //       _buildDots(),
    //     ],
    //   ),
    // );

    final _usuarioNombres = Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 50),
      child: Text(
        tarjetaModelo.usuarioNombres.substring(1),
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
    );

    final _usuarioActividad = Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 100.0),
      child: Text(
        tarjetaModelo.usuarioActividad.substring(1),
        style: TextStyle(color: Colors.white, fontSize: 12.0),
      ),
    );

    final _usuarioTelefono = Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 30.0),
      child: Text(
        tarjetaModelo.usuarioTelefono,
        style: TextStyle(color: Colors.white, fontSize: 11.0),
      ),
    );

    final _usuarioCorreo = Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 30.0),
      child: Text(
        tarjetaModelo.usuarioCorreo,
        style: TextStyle(color: Colors.white, fontSize: 11.0),
      ),
    );

   final _usuarioDireccion = Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 40.0),
      child: Text(
        tarjetaModelo.usuarioDireccion,
        style: TextStyle(color: Colors.white, fontSize: 11.0),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: tarjetaModelo.cardColor,
      ),
      child: RotatedBox(
        quarterTurns: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _cardLogo,
            //CardChip(),
            //_cardNumber,
            _usuarioNombres,
            _usuarioActividad,
            _usuarioTelefono,
            _usuarioCorreo,
            _usuarioDireccion,
        ],),
      )
    );
  }

  // Widget _buildDots() {
  //   List<Widget> dotList = new List<Widget>();
  //   var counter = 0;
  //   for (var i = 0; i < 12; i++) {
  //     counter += 1;
  //     dotList.add(
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 1.0),
  //         child: Container(
  //           width: 1.0,
  //           height: 5.0,
  //           decoration: new BoxDecoration(
  //             color: Colors.white,
  //             shape: BoxShape.circle,
  //           ),
  //         ),
  //       ),
  //     );
  //     if (counter == 4) {
  //       counter = 0;
  //       dotList.add(SizedBox(width: 1.0));
  //     }
  //   }
  //   dotList.add(_buildNumbers());
  //   return Row(children: dotList);
  // }

  // Widget _buildNumbers() {
  //   return Text(
  //     tarjetaModelo.usuarioNombres.substring(1),
  //     style: TextStyle(color: Colors.white),
  //   );
  // }
}
