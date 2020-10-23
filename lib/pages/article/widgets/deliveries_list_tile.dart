import 'package:flutter/material.dart';
import 'package:identitic/models/articles/delivery.dart';
import 'package:identitic/utils/constants.dart';

class DeliveryListTile extends StatelessWidget {
  const DeliveryListTile([this._userReturn]);

  final dynamic _userReturn;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(
        context,
        RouteName.view_delivery,
         arguments: _userReturn,
      ),
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.png'),
      ),
      title: Text(_userReturn.userLastName),
      subtitle: Text(
        _userReturn.userName,
        maxLines: 1,
      ),
      trailing: Text(
         _userReturn.deliveries.isNotEmpty ? _userReturn.deliveries[0]['mark'] != null ? 'Corregido' : 'Corregir' : 'No entregado',
        style: TextStyle(color: _userReturn.deliveries.isNotEmpty ? _userReturn.deliveries[0]['mark'] != null ? Colors.green : Colors.blue : Colors.grey, fontWeight: FontWeight.w600),
      ),
    );

  }
}
