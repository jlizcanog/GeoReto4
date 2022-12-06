import 'package:get/get.dart';
import 'package:reto_4/proceso/peticiones.dart';


class controladorGeneral extends GetxController{
  final Rxn <List<Map<String, dynamic>>> _listadePosiciones =
      Rxn <List<Map<String, dynamic>>>();
  final _unaPosicion = "".obs;    

///////////////////////////////////

  void cargaUnaPosicion(String X) {
    _unaPosicion.value = X;
  }
  
  String get unaPosicion => _unaPosicion.value;
///////////////////////////////////

  void cargaListaPosiciones(List<Map<String, dynamic>> X) {
    _listadePosiciones.value = X;
  }

  List<Map<String, dynamic>>? get ListadePosiciones => _listadePosiciones.value;

/////////////////////////////////// 

  Future <void> CargarTodaBD() async{
    final datos = await PeticionesDB.MostrarTodasUbicaciones();
    cargaListaPosiciones(datos);
  }


}