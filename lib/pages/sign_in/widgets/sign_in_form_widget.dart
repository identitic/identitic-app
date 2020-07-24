import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/utils/constants.dart';
import 'package:identitic/utils/validator.dart';

class SignInFormWidget extends StatefulWidget {
  @override
  _SignInFormWidgetState createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            focusNode: _usernameFocusNode,
            validator: (value) => Validator.validateUsername(value),
            decoration: InputDecoration(
              hintText: 'Usuario',
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            obscureText: true,
            validator: (value) => Validator.validatePassword(value),
            decoration: InputDecoration(
              hintText: 'Contraseña',
            ),
          ),
          SizedBox(height: 32),
          _signInButton(),
          SizedBox(height: 16),
          FlatButton(
            onPressed: () {},
            shape: StadiumBorder(),
            child: Text('¿Olvidaste tu contraseña?'),
          ),
        ],
      ),
    );
  }

  Widget _signInButton() {
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        onPressed: _isSending
            ? null
            : () async {
                if (_formKey.currentState.validate()) {
                  _login(_usernameController.text, _passwordController.text);
                }
              },
        color: Colors.pink,
        child: Text('Iniciar sesión'),
      ),
    );
  }

  void _login(String email, String password) async {
    setState(() {
      _isSending = true;
    });
    final bool didAuthenticate =
        await Provider.of<AuthProvider>(context, listen: false)
            .signInWithEmailAndPassword(email, password);
    if (didAuthenticate) {
      Navigator.pushNamedAndRemoveUntil(context, RouteName.main, (_) => false);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al iniciar sesión'),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() {
      _isSending = false;
    });
  }
}
