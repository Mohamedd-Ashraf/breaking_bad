import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../Business_Logic/cubit/chracters_cubit.dart';
import '../../Constants/MyColors.dart';
import '../../data/models/chracters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChracterDetailsScreen extends StatelessWidget {
  final Character character;
  const ChracterDetailsScreen({Key? key, required this.character})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    

   
    // BlocProvider.of<ChractersCubit>(context).getAllCharacters();
     BlocProvider.of<ChractersCubit>(context).getCharacterQuote(character.name);
  
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 58, 58, 58),
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo(
                    'Job : ',
                    character.jobs.join(' / '),
                  ),
                  buildDivider(333),
                  characterInfo(
                    'Appeard In : ',
                    character.catogryForSeries,
                  ),
                  buildDivider(282),
                  characterInfo(
                    'Seasons : ',
                    character.appreanceOfSeasons.join(" / "),
                  ),
                  buildDivider(300),
                  characterInfo(
                    'Status : ',
                    character.statusIfDeadOrAlive,
                  ),
                  buildDivider(315),
                  character.appreanceOfBetterCallSau.isEmpty
                      ? Container()
                      : characterInfo(
                          'Better Call Saul Seasons : ',
                          character.appreanceOfBetterCallSau.join(' / '),
                        ),
                  character.appreanceOfBetterCallSau.isEmpty
                      ? Container()
                      : buildDivider(200),
                  characterInfo(
                    'Actor : ',
                    character.actorName,
                  ),
                  buildDivider(323),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<ChractersCubit, ChractersState>(
                    builder: (context, state) {
                      
                      return checkIfQuoteIsLoaded(state);
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 500,
            )
          ]))
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: Color.fromARGB(255, 58, 58, 58),
      // elevation: 0.5,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "${character.nickName}",
          style: TextStyle(color: MyColors.MyWhite),
          // textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.MyWhite,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.MyWhite,
              // fontWeight: FontWeight.,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: Color.fromARGB(255, 213, 231, 15),
      endIndent: endIndent,
      height: 25,
      thickness: 3,
    );
  }

  Widget checkIfQuoteIsLoaded(ChractersState state) {
    if (state is charQuoteIsLoaded) {
      return displayRandomQuote(state);
    } else {
      return showProgressIndcator();
    }
  }

  Widget displayRandomQuote(state) {
    if (state.quote.toString().length>3) {
      return Center(
      child: DefaultTextStyle(
          style: TextStyle(
             fontFamily: 'Horizon',

            fontSize: 25,
            color: Color.fromARGB(255, 207, 179, 23),
            shadows: [
              Shadow(
                  blurRadius: 7,
                  color: Color.fromARGB(255, 0, 0, 0),
                  offset: Offset(2, 5)),
            ],
          ),
          child: AnimatedTextKit(

            // pause: Duration(milliseconds: 10),
            // repeatForever: true,
            totalRepeatCount: 1,
            animatedTexts: [
               TyperAnimatedText(state.quote.toString().substring(1,state.quote.length-2))
            ],
          )),
    );
      
    } else {
      return Container();
    }
  }

  Widget showProgressIndcator() {
    return Center(child: CircularProgressIndicator(color: MyColors.MyYellow,),);
  }
}
