import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tottracker/NEW_SCREENS/baby_cry_analyzer_screen.dart';
import '../providers/features.dart';

class FeatureDetailScreen extends StatelessWidget {
  static const routeName = '/feature/detail';
  @override
  Widget build(BuildContext context) {
    final featureId = ModalRoute.of(context)?.settings.arguments as String;
    //hatet el listen be false ashan mesh ayzo y-rebuild when i change something fel list
    final loadedFeatureListener = Provider.of<Features>(context, listen: false);
    final loadedFeature = loadedFeatureListener.findById(featureId);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 224, 224),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 53, 143),
        title: Center(child: Text(loadedFeature.title )),
      ),
      body:loadedFeature.id=='p1'? BabyCryAnalyzerScreen(): SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedFeature.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedFeature.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
