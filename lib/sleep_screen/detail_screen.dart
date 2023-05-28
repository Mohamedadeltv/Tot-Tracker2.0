import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'const.dart';
import 'custom_clipper.dart';
import 'grid_item.dart';
import 'progress_vertical.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    // For Grid Layout
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16, _cellHeight = 150.0;
    int _crossAxisCount = 2;

    double _width = (MediaQuery.of(context).size.width -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double _aspectRatio =
        _width / (_cellHeight + _mainAxisSpacing + (_crossAxisCount + 1));

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.lightBlue,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),

          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Status",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Sleeping",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Constants.darkBlue),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 40,
            child: Container(
              height: 120,
              width: 120,
              child: Image(
                  image: AssetImage('assets/drawables/tottracker4.png'),
                  height: 200,
                  width: 200,
                  color: Colors.white.withOpacity(1)),
            ),
          ),
          // BODY
          SizedBox(height: 80),
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Back Button

                        SizedBox(width: 20),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 30),
                // Chart
                Material(
                  shadowColor: Colors.grey.withOpacity(0.01), // added
                  type: MaterialType.card,
                  elevation: 10, borderRadius: new BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 400,
                    child: Column(
                      children: <Widget>[
                        // Rest Active Legend
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10.0),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Constants.lightBlue,
                                  shape: BoxShape.circle),
                            ),
                            Text("Sleep"),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Constants.darkBlue,
                                  shape: BoxShape.circle),
                            ),
                            Text("Active"),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Main Cards - Heartbeat and Blood Pressure
                        Container(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              ProgressVertical(
                                value: 50,
                                date: "5/11",
                                isShowDate: true,
                                key: Key("a"),
                              ),
                              ProgressVertical(
                                value: 50,
                                date: "5/12",
                                isShowDate: false,
                                key: Key("b"),
                              ),
                              ProgressVertical(
                                value: 45,
                                date: "5/13",
                                isShowDate: false,
                                key: Key("c"),
                              ),
                              ProgressVertical(
                                value: 30,
                                date: "5/14",
                                isShowDate: true,
                                key: Key("d"),
                              ),
                              ProgressVertical(
                                value: 50,
                                date: "5/15",
                                isShowDate: false,
                                key: Key("e"),
                              ),
                              ProgressVertical(
                                value: 20,
                                date: "5/16",
                                isShowDate: false,
                                key: Key("f"),
                              ),
                              ProgressVertical(
                                value: 45,
                                date: "5/17",
                                isShowDate: true,
                                key: Key("g"),
                              ),
                              ProgressVertical(
                                value: 67,
                                date: "5/18",
                                isShowDate: false,
                                key: Key("h"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        // Line Graph
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10.0),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Constants.lightBlue,
                                  shape: BoxShape.circle),
                            ),
                            Text("Sleep"),
                            Divider(
                              color: Color.fromARGB(255, 230, 41,
                                  41), // Customize the color if desired
                              thickness:
                                  1.0, // Customize the thickness if desired
                              indent: 20.0, // Customize the indent if desired
                              endIndent: 20.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Constants.darkBlue,
                                  shape: BoxShape.circle),
                            ),
                            Text("Active"),
                          ],
                        ),
                      ],
                    ),
                  ), // added
                ),
                SizedBox(height: 30),
                Container(
                  child: new GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                      crossAxisSpacing: _crossAxisSpacing,
                      mainAxisSpacing: _mainAxisSpacing,
                      childAspectRatio: _aspectRatio,
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      switch (index) {
                        case 0:
                          return GridItem(
                            status: "Total Sleep",
                            time: "4h 45m",
                            icon: Icon(Icons.bed, color: Colors.blueAccent),
                            remarks: "ok",
                            key: Key("a"),
                          );
                          break;
                        case 1:
                          return GridItem(
                            status: "Active",
                            time: "30m",
                            icon: Icon(
                              Icons.notifications_active_sharp,
                              color: Colors.amber,
                            ),
                            remarks: "ok",
                            key: Key("a"),
                          );
                          break;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
