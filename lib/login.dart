import 'package:flutter/material.dart';
import 'package:gasolinera/Principal.dart';
import 'package:gasolinera/register.dart';

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
    // Agrega un ListView al drawer. Esto asegura que el usuario pueda desplazarse
    // a través de las opciones en el Drawer si no hay suficiente espacio vertical
    // para adaptarse a todo.
    child: ListView(
      // Importante: elimina cualquier padding del ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            'Menu',
            style: TextStyle(color: Colors.white),
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
          title: Text('Inicio de sesion'),
          onTap: () {
            Navigator.push(
                Contexto!, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
        ListTile(
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
