import 'package:flutter/material.dart';

class FeatureItem with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  bool isFavorite;

FeatureItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false,
  });
  void toggleFavoritestatus(){
    isFavorite=!isFavorite;
    notifyListeners();
    /* hna ba2ol roh notify kol el listeners el by-listeno le any object of class Product we hnak 
    fel widget bta3tha modify any needed updates  */
  }
}

class Features with ChangeNotifier{
  List<FeatureItem> _items =[
    FeatureItem(
      id: 'p1',
      title: 'Baby cry analyzer',
      description: 'A red shirt - it is pretty red!',
      imageUrl:
          'https://kakigoristudio.com/wp-content/uploads/2021/01/parents-desperate-with-baby-crying-05175.jpg',
    ),
    FeatureItem(
      id: 'p2',
      title: 'Monitor vital signs',
      description: 'A nice pair of trousers.',
      imageUrl:
          'https://health.clevelandclinic.org/wp-content/uploads/sites/3/2022/10/Childrens-Vital-Signs-1333890585-770x533-1-650x428.jpg',
    ),
    FeatureItem(
      id: 'p3',
      title: 'Track sleeping pattern',
      description: 'Warm and cozy - exactly what you need for the winter.',
      imageUrl:
          'https://www.verywellfamily.com/thmb/KXYARp6hnzwQ0wumjRlbGRAM1vM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/VWFAM_Illustration_Where-Should-My-Baby-Sleep_Madelyn-Goodnight_Less-Text_Final-5808c2e35e2d4df4a66e8260a5b77415.jpg',
    ),
    FeatureItem(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

   List<FeatureItem> get items{
     return [..._items];
   }
List<FeatureItem> get showFavItems{
     return _items.where((product) => product.isFavorite).toList();
   }
   FeatureItem findById(String id){
     return _items.firstWhere((product) => product.id == id);
   }
   void addProduct(){
     notifyListeners();
   }

}