import 'package:flutter/material.dart';
import '../../helpers/tarjeta_colors.dart';
import '../../blocs/tarjeta_bloque.dart';
import '../../blocs/bloque_provedor.dart';

class TarjetaBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TarjetaBloque bloc = BloqueProvedor.of<TarjetaBloque>(context);

    return StreamBuilder<int>(
        stream: bloc.cardColorIndexSelected,
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
              color: snapshot.hasData
                  ? TarjetaColor.baseColors[snapshot.data]
                  : TarjetaColor.baseColors[0],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Image(
                          image: AssetImage('assets/card_band.jpg'),
                          width: 200.0,
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        width: 65.0,
                        height: 42.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.red, width: 3.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: StreamBuilder(
                              stream: bloc.usuarioTelefono,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.hasData ? snapshot.data : '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 12.0),
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(10.0),
                      child: Image(
                          image: AssetImage('assets/card_back.jpg'),
                          width: 65.0,
                          height: 40.0,
                          fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
