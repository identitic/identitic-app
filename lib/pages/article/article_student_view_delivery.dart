import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:identitic/models/articles/article.dart';
import 'package:identitic/models/articles/delivery.dart';
import 'package:identitic/providers/articles_provider.dart';
import 'package:identitic/providers/auth_provider.dart';

class StudentViewDeliveryPage extends StatefulWidget {
  const StudentViewDeliveryPage(this._article);

  final Article _article;

  @override
  _StudentViewDeliveryPageState createState() =>
      _StudentViewDeliveryPageState();
}

class _StudentViewDeliveryPageState extends State<StudentViewDeliveryPage> {
  FloatingActionButton _actionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mi entrega',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
        ),
        floatingActionButton: _actionButton,
        body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate(
                [_buildLoading()],
              )),
            ]));
  }

  _buildLoading() {
    return Column(children: <Widget>[
      FutureBuilder(
          future: Provider.of<ArticlesProvider>(context, listen: false)
              .fetchDeliveryByIdPost(widget._article.idArticle,
                  Provider.of<AuthProvider>(context, listen: false).user.id),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(children: <Widget>[
                    _buildDelivery(snapshot),
                    SizedBox(height: 16),
                    Divider(height: 16),
                    _buildCorrection(snapshot),
                  ]));
            }
            return Padding(
                padding: EdgeInsets.only(top: 128),
                child: Column(children: <Widget>[
                  Center(child: CircularProgressIndicator())
                ]));
          })
    ]);
  }

  _buildDelivery(AsyncSnapshot snapshot) {
    final Delivery delivery = snapshot.data;
    return Column(children: <Widget>[
      ListTile(
        title: Text('Entrega'),
      ),

      // VIEW DELIVERY BODY
      TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: delivery.body ?? 'Entrega sin cuerpo',
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          focusedErrorBorder: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          hintStyle: TextStyle(color: Colors.black),
        ),
      ),

      // DOWNLOAD THE UPLOADED FILE IN CASE THE DELIVERY HAVE
      delivery.file == null ? SizedBox(height: 8) : SizedBox(height: 0),
      delivery.file == null
          ? ListTile(
              leading: Text(
                'Archivo seleccionado',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              trailing: FlatButton(
                onPressed: () => _launchFileOnWeb(delivery.file.toString()),
                child: Text(
                  'Abrir archivo',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            )
          : SizedBox(),
        
      //  NEW DELIVERY OPTION 
      delivery.finished != null ? SizedBox(height: 0) : SizedBox(height: 8),
      delivery.finished == null
          ? FlatButton(
            onPressed: () => null,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Editar entrega',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          : SizedBox(),
    ]);
  }

  _buildCorrection(AsyncSnapshot snapshot) {
    final Delivery correction = snapshot.data;
    if (correction.returnMark != null) {
      return Column(children: <Widget>[
        ListTile(
          title: Text('Devolución del docente'),
        ),
        // VIEW DELIVERY BODY
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: correction.returnMark ?? 'Devolución sin cuerpo',
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(),
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            hintStyle: TextStyle(color: Colors.black),
          ),
        ),
      correction.returnedFile == null ? SizedBox(height: 8) : SizedBox(height: 0),
      correction.returnedFile == null
          ? ListTile(
              leading: Text(
                'Archivo adjunto por docente',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              trailing: FlatButton(
                onPressed: () => _launchFileOnWeb(correction.file.toString()),
                child: Text(
                  'Abrir archivo',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            )
          : SizedBox(),
      ]);
    }
    return Column(children: <Widget>[
      ListTile(
        title: Text('Devolución del docente'),
      ),
      Text(
        'El profesor/a todavía no corrigió el trabajo',
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).accentColor),
      )
    ]);
  }

  Future<void> _launchFileOnWeb(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
