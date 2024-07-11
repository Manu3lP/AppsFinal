import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hito3/pages/home.dart';
import 'package:hito3/utils/auth.dart';

class LoginPage extends StatelessWidget {
  static const String routename = 'Login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final AuthService _auth = AuthService();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 50),
          Image.asset('assets/images/mtglogo.png'),
          SizedBox(height: 20),
          Text(
            'Bienvenido de vuelta, te hemos extrañado!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          FormBuilderTextField(
            name: 'email',
            decoration: InputDecoration(
              hintText: "Correo electrónico",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(Icons.email),
            ),
            validator: FormBuilderValidators
                .required(), // Utilizando FormBuilderValidators.required() sin context
            obscureText: false,
          ),
          SizedBox(height: 18),
          FormBuilderTextField(
            name: 'password',
            decoration: InputDecoration(
              hintText: "Contraseña",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(Icons.lock),
            ),
            validator: FormBuilderValidators
                .required(), // Utilizando FormBuilderValidators.required() sin context
            obscureText: true,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState?.save();

                    if (_formKey.currentState?.validate() ?? false) {
                      final formData = _formKey.currentState?.value;
                      String email = formData?['email'];
                      String password = formData?['password'];

                      var result =
                          await _auth.singInEmailAndPassword(email, password);

                      if (result == 1) {
                        showSnackBar(context, 'Usuario no encontrado');
                      } else if (result == 2) {
                        showSnackBar(context, 'Contraseña incorrecta');
                      } else if (result != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        showSnackBar(context, 'Error desconocido');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text('Ingresar'),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    // Navegar a la pantalla de registro
                    // Implementa tu lógica aquí
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text('Registrarse'),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
