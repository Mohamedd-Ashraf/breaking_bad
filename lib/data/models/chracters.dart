class Character {

 late int charId;
 late String name;
 late String nickName;
 late String image;
 late String actorName;
 late String catogryForSeries;
 late String statusIfDeadOrAlive;
 late List <dynamic> jobs;
 late List <dynamic> appreanceOfBetterCallSau;
 late List <dynamic> appreanceOfSeasons;


 Character.fromJson (Map<String , dynamic> json){
  charId = json["char_id"];
  name = json["name"];
  nickName = json["nickname"];
  image = json["img"];
  actorName = json["portrayed"];
  catogryForSeries = json["category"];
  statusIfDeadOrAlive = json["status"];
  jobs = json["occupation"];
  appreanceOfBetterCallSau = json["better_call_saul_appearance"];
  appreanceOfSeasons = json["appearance"];
}

}