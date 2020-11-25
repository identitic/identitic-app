import 'package:flutter/material.dart';

import 'package:identitic/providers/auth_provider.dart';
import 'package:identitic/utils/constants.dart';
import 'package:identitic/utils/validator.dart';
import 'package:provider/provider.dart';

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
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              children: <Widget>[
                Spacer(),
                Image.asset(
                  'assets/images/identitic_pink.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                Spacer(),
                // BUILD LOGIN FORM
                Padding(padding: EdgeInsets.all(16), child: _buildForm()),

                // BUILD LOGIN BUTTON
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        color: Colors.pink,
                        child: Text('Iniciar sesión',
                            style: TextStyle(color: Colors.white)),
                        onPressed: _isSending
                            ? null
                            : () async {
                                if (_formKey.currentState.validate()) {
                                  _signIn(context);
                                }
                              },
                      ),
                    )),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            focusNode: _usernameFocusNode,
            validator: Validator.validateUsername,
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
              hintText: 'juanperez',
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            obscureText: true,
            validator: Validator.validatePassword,
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
        backgroundColor: Colors.red,
      ),
    );
    setState(() {
      _isSending = false;
    });
  }
}
