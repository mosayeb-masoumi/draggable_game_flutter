enum AnimalType { land, air }

class Animal {
  final String imageUrl;
  final AnimalType type;

  Animal({
    required this.imageUrl,
    required this.type,
  });
}

final allAnimals = [
  Animal(
    type: AnimalType.land,
    imageUrl: 'assets/images/animal1.png',
  ),
  Animal(
    type: AnimalType.air,
    imageUrl: 'assets/images/bird1.png',
  ),
  Animal(
    type: AnimalType.air,
    imageUrl: 'assets/images/bird2.png',
  ),
  Animal(
    type: AnimalType.land,
    imageUrl: 'assets/images/animal2.png',
  ),
  Animal(
    type: AnimalType.air,
    imageUrl: 'assets/images/bird3.png',
  ),
  Animal(
    type: AnimalType.land,
    imageUrl: 'assets/images/animal3.png',
  ),
];
