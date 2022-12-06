
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto_4/controlador/controladorGeneral.dart';
import 'package:reto_4/proceso/peticiones.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class listar extends StatefulWidget {
  const listar({super.key});

  @override
  State<listar> createState() => _listarState();
}

class _listarState extends State<listar> {
  controladorGeneral control= Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control.CargarTodaBD();

  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Container(
      child: control.ListadePosiciones?.isEmpty==false? ListView.builder(
        itemCount: control.ListadePosiciones!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.location_searching_rounded),
              trailing: IconButton(
                onPressed: (){
                  Alert(
                          type: AlertType.warning,
                          context: context,
                          title: "ATENCION !!!",
                          buttons: [
                            DialogButton(
                              color: Colors.blue,
                              child: Text("SI"),
                               onPressed: (){
                                 PeticionesDB.EliminarUnaPosicion(
                                     control.ListadePosiciones![index]
                                          ["id"]);
                                         control.CargarTodaBD();
                                         Navigator.pop(context);   
                               }),
                               DialogButton(
                              color: Colors.purple,
                              child: Text("NO"),
                               onPressed: (){
                                Navigator.pop(context);
                               })
                               ],
                          desc:
                               "Esta seguro que desea eliminar esta posicion ?")
                      .show();
                   
                },
               icon: Icon(Icons.delete_outlined)),
              title:
                 Text(control.ListadePosiciones![index]["coordenadas"]),
              subtitle: Text(control.ListadePosiciones![index]["fecha"]),
            ),
          );
        },
      )
      :Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}