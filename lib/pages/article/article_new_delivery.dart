import 'package:flutter/material.dart';
import 'package:identitic/models/article.dart';
import 'package:identitic/utils/constants.dart';

class NewDeliveryPage extends StatefulWidget {
  const NewDeliveryPage([this.article]);

  final Article article;

  @override
  _NewDeliveryPageState createState() => _NewDeliveryPageState();
}

class _NewDeliveryPageState extends State<NewDeliveryPage> {
  TextEditingController _bodyController;
  bool enableGroup;

  @override
  void initState() {
    enableGroup = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //TODO: Cambiar a SliverAppBar ?
        appBar: AppBar(
          title: Text(
            'Articulo',
            style: TextStyle(fontSize: 16),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: null,
          label: Row(
            children: <Widget>[
              Icon(Icons.done),
              SizedBox(width: 8),
              Text('Confirmar'),
            ],
          ),
        ),
        body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate(
                [
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('Nueva entrega'),
                          ),
                          TextField(
                            maxLines: null,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 40.0, horizontal: 10),
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
                            controller: _bodyController,
                          ),
                          SizedBox(height: 32),
                          FlatButton(
                            color: Colors.blue,
                            onPressed: () => Navigator.pushNamed(
                                context, RouteName.add_event),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Adjuntar archivo',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: Text(
                              'Entrega en grupo',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            trailing: Switch(
                              activeColor: Colors.blue,
                              value: enableGroup,
                              onChanged: (bool state) {
                                setState(() {
                                  enableGroup = state;
                                });
                              },
                            ),
                          ),
                          enableGroup == true
                              ? ListTile(
                                  title: Text('Integrantes'),
                                )
                              : SizedBox(),
                          enableGroup == true
                              ? TextField(
                                  //TODO: Seguir esto
                                  maxLines: null,
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
                                  ),
                                  controller: _bodyController,
                                )
                              : SizedBox()
                        ],
                      ))
                ],
              )),
            ]));
  }
}
