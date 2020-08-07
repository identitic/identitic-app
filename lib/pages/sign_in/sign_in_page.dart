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
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                const Spacer(),
                Image.asset(
                  'assets/images/identitic_pink.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                const SizedBox(height: 32),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _usernameController,
                          focusNode: _usernameFocusNode,
                          validator: Validator.validateUsername,
                          decoration: InputDecoration(
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
                            labelText: 'Contraseña',
                            hintText: '••••••••••',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Spacer(),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      color: Theme.of(context).buttonColor,
                      child: Text('Iniciar sesión', style: TextStyle(color: Colors.white)),
                      onPressed: _isSending
                          ? null
                          : () async {
                              if (_formKey.currentState.validate()) {
                                _signIn(context);
                              }
                            },
                    ),
                  ),
                ),
              ],
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
