import 'package:draggable_game/data.dart';
import 'package:draggable_game/draggable_widget.dart';
import 'package:draggable_game/utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Animal> all = allAnimals;
  final List<Animal> land = [];
  final List<Animal> air = [];

  final double size = 150;

  void removeAll(Animal toRemove) {
    all.removeWhere((animal) => animal.imageUrl == toRemove.imageUrl);
    land.removeWhere((animal) => animal.imageUrl == toRemove.imageUrl);
    air.removeWhere((animal) => animal.imageUrl == toRemove.imageUrl);
  }


  int score = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("draggable game"),
      centerTitle: true,
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        Text("Your Score is $score" , style: TextStyle(color: Colors.green , fontSize: 20 , fontWeight: FontWeight.bold),),

        buildTarget(
          context,
          text: 'All',
          animals: all,
          acceptTypes: AnimalType.values,
          onAccept: (data) => setState(() {
            removeAll(data);
            all.add(data);



            score -= 100;
            if(score < 0){
              score = 0;
            }

          }),


        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildTarget(
              context,
              text: 'Animals',
              animals: land,
              acceptTypes: [AnimalType.land],
              onAccept: (data) => setState(() {
                removeAll(data);
                land.add(data);
              }),
            ),
            buildTarget(
              context,
              text: 'Birds',
              animals: air,
              acceptTypes: [AnimalType.air],
              onAccept: (data) => setState(() {
                removeAll(data);
                air.add(data);
              }),
            ),
          ],
        ),
      ],
    ),
  );

  Widget buildTarget(
      BuildContext context, {
        required String text,
        required List<Animal> animals,
        required List<AnimalType> acceptTypes,
        required DragTargetAccept<Animal> onAccept,
      }) =>
      CircleAvatar(
        radius: size / 2,
        child: DragTarget<Animal>(
          builder: (context, candidateData, rejectedData) => Stack(
            children: [
              ...animals
                  .map((animal) => DraggableWidget(animal: animal))
                  .toList(),
              IgnorePointer(child: Center(child: buildText(text))),
            ],
          ),
          onWillAccept: (data) => true,
          onAccept: (data) {
            if (acceptTypes.contains(data.type)) {
              Utils.showSnackBar(
                context,
                text: 'This Is Correct 🥳',
                color: Colors.green,
              );

              setState(() {
                score += 50;
              });
              onAccept(data);

            } else {
              Utils.showSnackBar(
                context,
                text: 'This Looks Wrong 🤔',
                color: Colors.red,
              );

              setState(() {
                score -= 20;
                if(score < 0){
                  score = 0;
                }

              });
            }


          },
        ),
      );

  Widget buildText(String text) => Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.8),
        blurRadius: 12,
      )
    ]),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
