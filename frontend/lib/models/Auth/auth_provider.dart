
import 'package:flutter/material.dart';
import 'package:heroforge/models/Auth/usuario.dart';

class AuthProvider extends ChangeNotifier {
  
  Usuario? user;
  String? token;

  bool get isLogged => token != null;

  void login(String token, Usuario user) {
    this.token = token;
    this.user = user;
    notifyListeners();
  }

  void logout() {
    token = null;
    user = null;
    notifyListeners();
  }

  void notifcar()
  {
    notifyListeners();
  }


  String? _fotoCacheBuster; // solo se setea al cambiar foto

  void actualizarFoto(String nuevaUrl) {

    user = user?.copyWith(fotoUrl: nuevaUrl);

    _fotoCacheBuster = DateTime.now().millisecondsSinceEpoch.toString();
    
    notifyListeners();
  }

  String? get fotoUrlConCache {

   if (user?.fotoUrl == null) return null;

   if (_fotoCacheBuster != null) {

      return "${user!.fotoUrl}?t=$_fotoCacheBuster";

    }
  return user!.fotoUrl; 
}
}