import 'package:flutter/material.dart';
import '../../Business_Logic/cubit/chracters_cubit.dart';
import '../../Constants/MyColors.dart';
import '../../data/models/chracters.dart';
import '../widgets/character_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

List<Character> allChracter = [];
List<Character> tempChracter = [];
late List<Character> searchForChracter;
bool isSearching = false;
final searchTextControler = TextEditingController();
List femaleIds = [3, 6, 14, 16, 23, 25, 26, 30, 36, 46, 47, 52, 53, 55, 112];

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  Widget buildSearchScren() {
    return TextField(
      controller: searchTextControler,
      cursorColor: Color.fromARGB(255, 0, 0, 0),
      decoration: InputDecoration(
          hintText: "Find a Character",
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 18,
          )),
      style: TextStyle(color: MyColors.MyLightGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItmesToSearchedList(searchedCharacter);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChractersCubit>(context).getAllCharacters();
    //  BlocProvider.of<ChractersCubit>(context).getCharacterQuote(characte);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: isSearching ? buildSearchScren() : buildAppBarTitle(),
        actions: buildappbarAction(),
        leading: isSearching
            ? BackButton(
                color: Color.fromARGB(255, 0, 0, 0),
              )
            : Container(),
        backgroundColor: MyColors.MyYellow,
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlockWidget();
          } else {
            return noInternetdWidget();
          }
        },
        child: screenIdacator(),
      ),
    );
  }

  void addSearchedForItmesToSearchedList(String searchedCharacter) {
    searchForChracter = allChracter
        .where((charcter) => charcter.name
            .toLowerCase()
            .contains(searchedCharacter.toLowerCase()))
        .toList();
    setState(() {});
  }

  List<Widget> buildappbarAction() {
    if (isSearching) {
      return [
        IconButton(
            onPressed: () {
              searchTextControler.text.isEmpty
                  ? Navigator.pop(context)
                  : clearSearch();
              ;
            },
            icon: Icon(
              Icons.clear,
              color: Color.fromARGB(255, 0, 0, 0),
            ))
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearching,
          icon: Icon(Icons.search),
          color: Color.fromARGB(255, 0, 0, 0),
        )
      ];
    }
  }

  Widget buildBlockWidget() {
    return BlocBuilder<ChractersCubit, ChractersState>(
        builder: ((context, state) {
      if (state is ChractersIsLoaded) {
        state.chractersList.toList().forEach((element) {
          if (!femaleIds.contains(element.charId)) {
            tempChracter.add(element);
          }
          ;
        });
        allChracter = tempChracter.toList();

        tempChracter = [];

        return buildLoadListWidget();
      } else {
        return screenIdacator();
      }
    }));
  }

  Widget screenIdacator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.MyYellow,
      ),
    );
  }

  Widget buildLoadListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.Mygrey,
        child: Column(
          children: [buildCharcterList()],
        ),
      ),
    );
  }

  Widget buildCharcterList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchTextControler.text.isEmpty
            ? allChracter.length
            : searchForChracter.length,
        itemBuilder: ((context, index) {
          return CharacterItem(
            chracter: searchTextControler.text.isEmpty
                ? allChracter[index]
                : searchForChracter[index],
          );
        }));
  }

  startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    //  ModalRoute.of(context)!
    //     .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));

    setState(() {
      isSearching = true;
    });
  }

  stopSearching() {
    clearSearch();

    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextControler.clear();
    });
  }

  Widget buildAppBarTitle() {
    return Text(
      'All Characters',
      style: TextStyle(color: Color.fromARGB(192, 0, 0, 0)),
    );
  }

  Widget noInternetdWidget() {
    return Center(
      child: Container(
        color: MyColors.MyWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Can\'t Connect , Check Internet ",
              style: TextStyle(color: MyColors.Mygrey, fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/noInternet.png',
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
