import 'dart:io';

import 'package:flutter/material.dart';
import 'package:identitic/providers/profilephoto_provider.dart';
import 'package:identitic/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import 'package:identitic/models/user.dart';
import 'package:identitic/providers/auth_provider.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage(this._user);

  final User _user;

  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final picker = ImagePicker();

  File imageFile;
  bool _toggleNotifications;

  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _toggleNotifications = false;
    _nameController.text = widget._user.name + ' ' + widget._user.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _saveChanges(),
          label: Row(
            children: <Widget>[
              Icon(Icons.done),
              SizedBox(width: 8),
              Text('Confirmar'),
            ],
          )),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text('Ajustes'),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 56,
                        backgroundImage: imageFile == null
                            ? Provider.of<AuthProvider>(context, listen: false)
                                        .user
                                        .profilePhoto !=
                                    null
                                ? NetworkImage(apiBaseUrl +
                                    "/" +
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .user
                                        .profilePhoto
                                        .replaceFirst(r'\', "/"))
                                : imageFile != null
                                    ? FileImage(imageFile)
                                    : AssetImage('assets/images/avatar.png')
                            : FileImage(imageFile), //TODO: arreglar
                      ),
                      FlatButton(
                        child: Text(
                          'Editar foto',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        onPressed: () => _selectImageGallery(context),
                      ),
                      TextFormField(
                        readOnly: false,
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Editar nombre',
                          hintText:
                              '${context.watch<AuthProvider>().user.name} ${context.watch<AuthProvider>().user.lastName}',
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Text('Desactivar notificaciones',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        trailing: Switch(
                          activeColor: Colors.blue,
                          value: _toggleNotifications,
                          onChanged: (bool state) {
                            setState(() {
                              _toggleNotifications = state;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _selectImageGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  void _saveChanges() async {
  await Provider.of<ProfilePhotoProvider>(context, listen: false)
        .uploadPhoto(imageFile);
    Navigator.pop(context);
  }
}
