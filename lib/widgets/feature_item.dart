import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tottracker/NEW_SCREENS/feature_detail_screen.dart';
import '../providers/features.dart' as f;

class FeatureItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feature = Provider.of<f.FeatureItem>(context, listen: false);

    return Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.grey,
      width: 2.0,
    ),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.7),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          footer: GridTileBar(
            trailing: Consumer<f.FeatureItem>(
              builder: (ctx, featuree, child) => IconButton(
                icon: Icon(
                    featuree.isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  featuree.toggleFavoritestatus();
                },
                color:  Color(0xff9a3a51),
              ),
            ),
            backgroundColor: Colors. black45,
            title: SingleChildScrollView(
                
                child: Text(feature.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.w900,fontFamily:'Silom' ),maxLines: 3,),
              
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(FeatureDetailScreen.routeName,
                  arguments: feature.id);
            },
            child: Image.network(
              feature.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
