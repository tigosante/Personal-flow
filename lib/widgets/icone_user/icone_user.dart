import 'package:flutter/material.dart';
import 'package:personalflow/widgets/info_user/photo_user.dart';
import 'package:personalflow/widgets/modal/modal_user.dart';

class IconUser extends StatefulWidget {
  @override
  _IconUserState createState() => _IconUserState();
}

class _IconUserState extends State<IconUser> {
  @override
  Widget build(BuildContext context) => IconButton(
      icon: PhotoUser(),
      onPressed: () => modalUser(context, MediaQuery.of(context).size.width));

  void modalUser(BuildContext context, double tamanhoTela) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(tamanhoTela * 0.025),
                topRight: Radius.circular(tamanhoTela * 0.025))),
        context: context,
        builder: (_) => ModalUser());
  }
}
