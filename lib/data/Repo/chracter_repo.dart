

// import 'package:flutter_application_1/data/models/chracters.dart';

// import '../API/web_services_page.dart';

// class ChractersRepo {

//  final WebServices webServices;

//   ChractersRepo(this.webServices);

// Future<List<Character>> getAllCracters() async {
//   final chracters = await webServices.getAllCracters();
//    print(chracters);
//     return chracters.map((character) => Character.fromJson(character)).toList();
// }
  
// }


import 'package:flutter_application_1/data/API/web_services_page.dart';
import 'package:flutter_application_1/data/models/char_Quotes.dart';
import 'package:flutter_application_1/data/models/chracters.dart';

import '../models/char_Quotes.dart';
import '../models/char_Quotes.dart';

// import '';

class CharactersRepository {
  final WebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCracters();
    return characters.map((character) => Character.fromJson(character)).toList();
  }

Future<String> getCharacterQuote(String charName) async {
    final charQuote = await charactersWebServices.getCharacterQuote(charName) ;
    // print(charQuote.map((e) => CharQuote.fromJson(e).Quote));
    return charQuote.map((e) => CharQuote.fromJson(e).Quote).toString();
  }

}