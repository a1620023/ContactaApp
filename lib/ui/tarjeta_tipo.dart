
import 'package:Contacta/blocs/bloque_provedor.dart';
import 'package:flutter/material.dart';
import '../ui/widgets/my_appbar.dart';
import '../blocs/bloque_provedor.dart';
import '../blocs/tarjeta_bloque.dart';
import '../ui/tarjeta_crear.dart';

class TarjetaTipo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _buildTextInfo = Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      child: Text.rich(
        TextSpan( /*Texto posterior */
            text:
                'Crea, comparte, y contacta a \$0.00  por lanzamiento ',
            style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
            children: <TextSpan>[
              TextSpan(
                  text: 'Descubrir +',
                  style: TextStyle(
                      color: Colors.lightBlue, fontWeight: FontWeight.bold))
            ]),
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );

    return Scaffold(
        appBar: MyAppBar(
            appBarTitle: 'Tipo de tarjeta',
            leadingIcon: Icons.clear,
            context: context),
        body: Container(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildRaisedButton(
                    buttonColor: Colors.lightBlue,
                    buttonText: 'INDEPENDIENTE',
                    textColor: Colors.white,
                    context: context),
                _buildRaisedButton(
                    buttonColor: Colors.grey[100],
                    buttonText: 'CORPORATIVO',
                    textColor: Colors.grey[600],
                    context: context),
                _buildRaisedButton(
                    buttonColor: Colors.grey[100],
                    buttonText: 'Prueba',
                    textColor: Colors.grey[600],
                    context: context),
                _buildTextInfo,
              ],
            )));
  }

  Widget _buildRaisedButton(
      {Color buttonColor,
      String buttonText,
      Color textColor,
      BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: RaisedButton(
        elevation: 1.0,
        onPressed: () {
          var blocProviderCardCreate = BloqueProvedor(
            bloc: TarjetaBloque(),
            child: TarjetaCrear(),
          );
          blocProviderCardCreate.bloc.selectCardType(buttonText);
          Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => blocProviderCardCreate));
        },
        color: buttonColor,
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
