
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:reto_4/controlador/controladorGeneral.dart';
import 'package:reto_4/interfaz/listar.dart';
import 'package:reto_4/proceso/peticiones.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sprint 4',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GEO TEAM 5'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  controladorGeneral control = Get.find();

  void ObtenerPosicion () async {
    Position posicion = await PeticionesDB.determinePosition();
    print(posicion.toString());
    control.cargaUnaPosicion(posicion.toString());

  }
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){
            Alert(
              type: AlertType.warning,
              context: context,
              title: "ATENCION !!!",
              buttons: [
                DialogButton(
                  color: Colors.brown,
                  child: Text("SI"),
                   onPressed: (){
                      PeticionesDB.EliminarTodas();
                         control.CargarTodaBD();
                    Navigator.pop(context);
                   }),
                   DialogButton(
                  color: Colors.orange,
                  child: Text("NO"),
                   onPressed: (){
                    Navigator.pop(context);
                   })
                   ],
              desc:
              "Esta seguro que desea eliminar todas las ubicaciones ? ")
              .show();
             
          },
           icon: Icon(Icons.delete_forever))],
      ),
      body: listar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ObtenerPosicion();
          Alert(
                 title: "ATENCION !!!",
                 desc: "Esta seguro que  desea compartir su ubicacion. "+
                     control.unaPosicion+
                           "?",
                 type: AlertType.info,
                 buttons: [
                   DialogButton(
                      color: Colors.green, 
                      child: Text("SI"),
                      onPressed: (){
                        PeticionesDB.GuardarPosicion(
                            control.unaPosicion, DateTime.now().toString());
                        control.CargarTodaBD();    
                         Navigator.pop(context);
                        }),
                  DialogButton(
                      color: Colors.red, 
                      child: Text("NO"),
                      onPressed: (){
                         Navigator.pop(context);
                        })
                 ],
                 context: context)
                 .show();
        
           },
       child: Icon(Icons.location_on_outlined),
      ),
     );
  }
}
