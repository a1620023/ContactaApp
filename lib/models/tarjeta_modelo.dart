import 'package:flutter/material.dart';

class TarjetaModelo{
  List<TarjetaResultados> results;

  TarjetaModelo({this.results});

  TarjetaModelo.fromJson(Map<String, dynamic> json) {
    if (json['tarjetaResultados'] != null) {
      results = new List<TarjetaResultados>();
      json['tarjetaResultados'].forEach((v) {
        results.add(new TarjetaResultados.fromJson(v));
      });
    }
  }

}

class TarjetaResultados{
  String usuarioNombres;
  String usuarioActividad;
  String usuarioTelefono;
  String usuarioCorreo;
  String usuarioDireccion;  
  String usuarioEmpresa;
  Color cardColor;
  String cardType;

  TarjetaResultados(
      {this.usuarioNombres,
      this.usuarioActividad,
      this.usuarioTelefono,
      this.usuarioCorreo,
      this.usuarioDireccion,
      this.cardColor,
      this.cardType,
      this.usuarioEmpresa});

  TarjetaResultados.fromJson(Map<String, dynamic> json) {
    usuarioNombres = json['usuarioNombres'];
    usuarioActividad = json['usuarioActividad'];
    usuarioTelefono = json['usuarioTelefono'];
    usuarioCorreo = json['usuarioCorreo'];
    usuarioDireccion = json['usuarioDireccion']; //Card Verification Number
    cardColor = json['cardColor'];
    cardType = json['cardType'];
    usuarioEmpresa = json['usuarioEmpresa'];
  }

  
}