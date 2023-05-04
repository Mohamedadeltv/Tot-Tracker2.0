import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import '../custom_drawer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
class InviteFriend extends StatefulWidget {
  static const routeName = '/invitefriendscreen';

  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the previous page
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return false;
      },
      child: Container(
        color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
        child: SafeArea(
          top: false,
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 15, 53, 143)),
              ),
              centerTitle: true,
              title: const Center(
                child: Text(
                  'Invite A Friend',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FeaturesOverviewScreen()));
                },
              ),
            ),
            backgroundColor:
                isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
            body: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 16,
                      right: 16),
                  child: Image.asset('assets/drawables/inviteImage.png'),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Invite Your Friends',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isLightMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Are you one of those who makes everything\n at the last moment?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: isLightMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        //method here for functionality
                        print('Share Action.');
                      },
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isLightMode ? Colors.blue : Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: const Offset(4, 4),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                String text =
                                    'Check out this cool app! Invitation link: <insert your invitation link here>';
                               Share.share(text);
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.share,
                                      color: isLightMode
                                          ? Colors.white
                                          : Colors.black,
                                      size: 22,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Share',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: isLightMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
