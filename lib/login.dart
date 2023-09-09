import 'package:flutter/material.dart';
import 'package:gasolinera/Principal.dart';
import 'package:gasolinera/register.dart';
import 'package:sqflite/sqflite.dart';

BuildContext? Contexto;

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Contexto = context;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: drawers(),
      appBar: AppBar(
        title: Text(
          'Gasolinera Puma',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: background(),
    );
  }
}

Widget background() {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/fondo.jpg'),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
      ),
    ),
    child: Center(
      child: Formulario(),
    ),
  );
}

Widget Formulario() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'INICIO DE SESION',
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
      Image.asset(
        'assets/logo.png',
        width: 250,
      ),
      Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.00),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Correo electronico',
                  hintText: 'Carlosgeek503@gmail.com',
                  hintStyle: TextStyle(color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 6.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Contraseña',
                      hintText: '*************',
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(Contexto!,
                          MaterialPageRoute(builder: (context) => Principal()));
                    },
                    child: const Text('Iniciar sesion'),
                  ),
                ],
              )
            ],
          )
        ],
      )
    ],
  );
}

Widget drawers() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'Menu de seleccion',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              'assets/fondo.jpg',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.darken),
          )),
        ),
        ListTile(
          leading: Icon(Icons.login),
          title: Text('Inicio de sesion'),
          onTap: () {
            Navigator.push(
                Contexto!, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
        ListTile(
          leading: Icon(Icons.output),
          title: Text('Registrarse'),
          onTap: () {
            Navigator.push(
                Contexto!, MaterialPageRoute(builder: (context) => Register()));
          },
        ),
      ],
    ),
  );
}




 Future<void> crearBaseDeDatos() async {
  final database = await openDatabase(
    'gasolinera.db',
    version: 1,
    onCreate: (db, version) {
      db.execute(
          'CREATE TABLE USUARIO('+
          'ID INTEGER AUTO INCREMENT PRIMARY KEY,'+
          'NOMBRE TEXT NOT NULL,'+
          'PASSWORD TEXT NOT NULL,'+
          'CORREO TEXT NOT NULL,'+
          'TELEFONO TEXT NOT NULL,'+
          'ID_ESTADOS INTEGER NOT NULL,'+
          'ID_ROL INTEGER NOT NULL,'+');');
    },
  );
}
