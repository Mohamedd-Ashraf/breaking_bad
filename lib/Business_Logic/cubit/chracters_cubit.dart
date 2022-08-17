// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/data/Repo/chracter_repo.dart';
import 'package:flutter_application_1/data/models/chracters.dart';
import 'package:meta/meta.dart';

part 'chracters_state.dart';

class ChractersCubit extends Cubit<ChractersState> {
  final CharactersRepository CharRepo;
   List <Character> characters =[];
    String quote="";
  ChractersCubit(
    this.CharRepo,
  ) : super(ChractersInitial());
  List<Character> getAllCharacters() {
    CharRepo.getAllCharacters().then((characters) {
    
       emit(ChractersIsLoaded(characters));
       this.characters = characters;
    });

    return characters ;
   
  }
    String getCharacterQuote(String charName) {
    CharRepo.getCharacterQuote(charName).then((quote) {
    
       emit(charQuoteIsLoaded(quote));
       this.quote = quote;
    });

    return quote ;
   
  }
}
