// ignore_for_file: public_member_api_docs, sort_constructors_first
class CharQuote {

 late String Quote;
 

  CharQuote.fromJson(Map <String , dynamic>json){
    Quote = json['quote'];
  }

}
