import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: MypagesHome());
  }
}

class MypagesHome extends StatefulWidget {
  const MypagesHome({super.key});

  @override
  State<MypagesHome> createState() => _MypagesHomeState();
}

class _MypagesHomeState extends State<MypagesHome> {
  String? validar;
  late bool _colorSecundario = false;
  final formkey = GlobalKey<FormState>();
  String _selectedGender = 'Hombre'; // Valor inicial

  void _handleGenderChange(String? value) {
    setState(() {
      _selectedGender = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (_colorSecundario) ? Colors.white : Color(0xFF191B31),
      appBar: AppBar(
        title: const Text(
          'Productos',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: (_colorSecundario) ? Colors.purple : Color(0xFF191B31),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Form(
              key: formkey,
              child: Column(
                children: [
                  SwitchListTile(
                    value: _colorSecundario,
                    onChanged: (value) {
                      setState(() {
                        _colorSecundario = value;
                      });
                    },
                    title:
                        Text(_colorSecundario ? "Color Oscuro" : "Color Claro",
                            style: TextStyle(
                              color: (_colorSecundario)
                                  ? Color.fromARGB(255, 0, 0, 0)
                                  : Color.fromARGB(255, 255, 255, 255),
                            )),
                    tileColor:
                        (_colorSecundario) ? Colors.white : Color(0xFF191B31),
                  ),
                  Center(
                    child: Text("Registrarse",
                        style: TextStyle(
                            fontSize: 33,
                            color: (_colorSecundario)
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : Color.fromARGB(255, 255, 255, 255))),
                  ),
                  inputField(
                    "Nombre",
                    TextInputType.name,
                    (value) {
                      if (value!.length < 3) {
                        return 'Ingresar el nombre del producto';
                      } else {
                        return null;
                      }
                    },
                  ),
                  inputField(
                    "Apellido",
                    TextInputType.name,
                    (value) {
                      if (value!.length < 3) {
                        return 'Ingresar el Apellido';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Text("Sexo:", style: TextStyle(fontSize: 23)),
                  radioboton(context),
                  inputField("Email", TextInputType.emailAddress, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa un email';
                    }

                    String pattern = r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Ingresa un email válido';
                    }
                    return null;
                  }),
                  _inputPassword(
                    "Contraseña",
                    TextInputType.name,
                    (value) {
                      if (value!.length < 10 && value.length > 20) {
                        return 'Ingresar el contrseña que entre 10 y 20 ';
                      } else {
                        validar = value;
                        return null;
                      }
                    },
                  ),
                  _inputPassword(
                    "confirmar Contraseña",
                    TextInputType.name,
                    (value2) {
                      if (value2 != validar) {
                        return 'Las contrseña no coinsiden';
                      } else {
                        return null;
                      }
                    },
                  ),
                  _crearBotton(),
                  
                ],
              )),
        ),
      ),
    );
  }

  Widget inputField(String label, TextInputType keyboardType,
      String? Function(String?) validator) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 23, vertical: 23),
      child: TextFormField(
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: (_colorSecundario)
              ? Color.fromARGB(255, 0, 0, 0)
              : Color.fromARGB(255, 255, 255, 255),
        ),
        decoration: InputDecoration(labelText: label),
        validator: validator,
      ),
    );
  }

  Widget _crearBotton() {
    return ElevatedButton(
        onPressed: () {
          _submit();
          print("hola");
        },
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
          (_colorSecundario)
              ? Colors.purple
              : Color.fromARGB(255, 69, 255, 165),
        )),
        child: Container(
          width: 100,
          height: 65,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const Row(
            children: <Widget>[
              Icon(Icons.app_registration),
              SizedBox(width: 8),
              Text(
                "Registrar",
                style: TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
              )
            ],
          ),
        ));
  }

  Widget _inputPassword(String label, TextInputType textInputType,
      String? Function(String?) validator) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 23, vertical: 23),
      child: TextFormField(
        keyboardType: textInputType,
        style: TextStyle(
          color: (_colorSecundario)
              ? Color.fromARGB(255, 0, 0, 0)
              : Color.fromARGB(255, 255, 255, 255),
        ),
        textCapitalization: TextCapitalization.none,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
        ),
        validator: validator,
      ),
    );
  }

  Widget radioboton(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Hombre',
              style: TextStyle(
                  fontSize: 23,
                  color: (_colorSecundario)
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : Color.fromARGB(255, 255, 255, 255))),
          leading: Radio<String>(
            value: 'Hombre',
            groupValue: _selectedGender,
            onChanged: _handleGenderChange,
          ),
        ),
        ListTile(
          title: Text('Mujer',
              style: TextStyle(
                  fontSize: 23,
                  color: (_colorSecundario)
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : Color.fromARGB(255, 255, 255, 255))),
          leading: Radio<String>(
            value: 'Mujer',
            groupValue: _selectedGender,
            onChanged: _handleGenderChange,
          ),
        ),
      ],
    );
  }

  void _submit() {
    if (!formkey.currentState!.validate()) return;

    formkey.currentState?.save();
    _mostrarMensaje();
    print("todo okey");
  }

void _mostrarMensaje() {
  final snackBar = SnackBar(
    content: Text(
      "Registrado correctamente",
      style: TextStyle(fontSize: 16.0, color: Colors.white), // Personaliza el estilo del texto aquí
    ),
    backgroundColor: Colors.green, 
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(23),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Deshacer', 
      textColor: Colors.white,
      onPressed: () {
        
      },
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0), 
    ),
    elevation: 6.0, 
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

}

/*

return Column(
      children: [
        Center(
          child: Text("Registrarse", style: TextStyle(fontSize: 33)),
        ),
        inputField(
          "Nombre",
          TextInputType.name,
          (value) {
            if (value!.length < 3) {
              return 'Ingresar el nombre del producto';
            } else {
              return null;
            }
          },
        ),
        inputField(
          "Apellido",
          TextInputType.name,
          (value) {
            if (value!.length < 3) {
              return 'Ingresar el Apellido';
            } else {
              return null;
            }
          },
        ),
        inputField("Email", TextInputType.emailAddress, (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa un email';
          }

          String pattern = r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Ingresa un email válido';
          }
          return null;
        }),
        inputField(
          "Contraseña",
          TextInputType.name,
          (value) {
            if (value!.length < 3) {
              return 'Ingresar el contrseña';
            } else {
              validar = value;
              return null;
            }
          },
        ),
        inputField(
          "confirmar Contraseña",
          TextInputType.name,
          (value) {
            if (value!.length < 3) {
              return 'Ingresar el contrseña';
            } else if (value == validar) {
              return 'Las contrseña no coinsiden';
            } else {
              return null;
            }
          },
        ),
        _crearBotton()
      ],
    );

 */
