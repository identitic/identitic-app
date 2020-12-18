import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/utils/constants.dart';
import 'package:identitic/utils/validator.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  FocusNode _usernameFocusNode;
  FocusNode _passwordFocusNode;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              leading: Navigator.of(context).canPop()
                  ? IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.of(context).pop())
                  : null),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  // CHECK IF KEYBOARD IS OPEN OR NOT
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? Image.asset(
                          'assets/images/fingerprint.png',
                          height: 72,
                        )
                      : SizedBox(),
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? Spacer()
                      : SizedBox(),
                  Text('Iniciar sesión',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      )),
                  SizedBox(height: 32),
                  _buildForm(),
                  _buildRegisterButton(),
                  Spacer(),
                  // BUILD LOGIN BUTTON

                  _buildSignInButton()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            focusNode: _usernameFocusNode,
/*             validator: Validator.validateUsername, */
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              hintStyle: TextStyle(color: Colors.grey),
              labelText: 'Usuario',
              hintText: 'juan.perez',
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            obscureText: true,
/*             validator: Validator.validatePassword, */
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(),
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              hintStyle: TextStyle(color: Colors.grey),
              labelText: 'Contraseña',
              hintText: '••••••••••',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
        width: double.infinity,
        child: FlatButton(
          color: Colors.pink,
          child: Text('Iniciar sesión', style: TextStyle(color: Colors.white)),
          onPressed: _isSending
              ? () => null
              : () async {
                  if (_formKey.currentState.validate()) {
                    _signIn(context);
                  }
                },
        ));
  }

  Widget _buildRegisterButton() {
    return FlatButton(
      child: Text(
        'No tengo cuenta',
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () => Navigator.pushNamed(context, RouteName.sign_up),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    setState(() {
      _isSending = true;
    });
    final bool didAuthenticate = await context
        .read<AuthProvider>()
        .signInWithEmailAndPassword(
            _usernameController.text, _passwordController.text);
    if (didAuthenticate) {
      return Navigator.pushNamedAndRemoveUntil(
          context, RouteName.main, (_) => false);
    }
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Credenciales inválidas'),
        backgroundColor: Colors.blue,
      ),
    );
    setState(() {
      _isSending = false;
    });
  }
}
