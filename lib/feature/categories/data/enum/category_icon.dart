import 'package:flutter/material.dart';

enum CategoryIcon {
  other(Icons.category),
  clothing(Icons.checkroom),
  date(Icons.favorite),
  education(Icons.school),
  entertainment(Icons.movie),
  food(Icons.restaurant),
  gift(Icons.card_giftcard),
  groceries(Icons.shopping_cart),
  health(Icons.medical_services),
  transport(Icons.directions_car),
  travel(Icons.flight),
  utilities(Icons.build),
  fitness(Icons.fitness_center),
  technology(Icons.devices),
  beauty(Icons.face),
  pets(Icons.pets),
  sports(Icons.sports),
  books(Icons.book),
  music(Icons.music_note),
  gaming(Icons.sports_esports),
  business(Icons.business_center),
  home(Icons.home),
  garden(Icons.yard),
  baby(Icons.child_care),
  art(Icons.palette),
  finance(Icons.account_balance),
  charity(Icons.volunteer_activism),
  hobby(Icons.directions_bike);

  const CategoryIcon(this.iconData);

  final IconData iconData;
}
