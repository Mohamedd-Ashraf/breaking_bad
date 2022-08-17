// ignore_for_file: sort_child_properties_last, prefer_const_constructors, implementation_imports, unnecessary_import, unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/Constants/MyColors.dart';
import 'package:flutter_application_1/data/models/chracters.dart';

import '../../Constants/Strings.dart';

class CharacterItem extends StatelessWidget {
  final Character chracter;
  const CharacterItem({Key? key, required this.chracter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
          color: MyColors.MyWhite, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        child: GridTile(
          child: Hero(

            tag: chracter.charId,
            child: Container(
              color: MyColors.Mygrey,
              child: chracter.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: 'assets/images/loading.gif',
                      image: chracter.image)
                  : Image.asset('assets/images/placeholder.png'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              "${chracter.name}",
              style:
                  TextStyle(height: 1.3, fontSize: 16, color: MyColors.MyWhite, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
            ),
          ),
        ),
        onTap: ()=>Navigator.pushNamed(context,detialsScreen, arguments: chracter),
        // onHover: ,
      ),
    );
  }
}
