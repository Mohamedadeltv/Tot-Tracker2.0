import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';
import 'package:tottracker/providers/profile_controller.dart';
import '../providers/user.dart' as U;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProfileScreen extends StatefulWidget {
  @override
  static const routeName = '/profile';
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late ImageProvider imageProvider;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  Future<void> requestPermissionsForCamera() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();
    print(statuses[Permission.camera]);
  }

  Future<void> requestPermissionsForStorage() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[Permission.storage]);
  }

  Future<String> uploadImageToFirebaseStorage(PickedFile imageFile) async {
    final user = FirebaseAuth.instance.currentUser;
    String fileName = DateTime.now().toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('profile_images/${user?.email}/$fileName');
    try {
      // Upload the image to Firebase Storage
      UploadTask uploadTask = reference.putFile(File(imageFile.path));
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      // Get the download URL for the image
      String downloadURL = await storageTaskSnapshot.ref.getDownloadURL();

      // Update the user's profile picture URL in Firestore

      print('HHHHHHHHHHHHHHHHHH  ' + user!.uid);

      await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: user.email)
          .get()
          .then((querySnapshot) {
            querySnapshot.docs.forEach((documentSnapshot) {
              setState(() {
                documentSnapshot.reference.set(
                    {'profile_picture_url': downloadURL},
                    SetOptions(merge: true));
              });
            });
          })
          .then((value) => print('Profile picture updated successfully'))
          .catchError(
              (error) => print('Failed to update profile picture: $error'));
      return downloadURL;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(children: <Widget>[
        Text(
          "Change Profile Picture",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton.icon(
              onPressed: () {
                takePhoto(ImageSource.camera);
                requestPermissionsForCamera();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.camera),
              label: Text('Take a photo'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                takePhoto(ImageSource.gallery);
                requestPermissionsForStorage();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.image),
              label: Text('Gallery'),
            ),
          ],
        )
      ]),
    );
  }

  Future<void> takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile!;
    });
    if (_imageFile != null) {
      uploadImageToFirebaseStorage(_imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    // Assuming that you have a reference to the Firestore document containing the image URL
    final user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: user!.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.size > 0) {
        // Assuming that the image URL is stored in a field called "profile_picture_url"
        String imageUrl = querySnapshot.docs[0].get('profile_picture_url');

        // Use the retrieved image URL to display the image
        imageProvider = NetworkImage(imageUrl);
      } else {
        // If no documents match the query, display a placeholder image
        imageProvider = AssetImage(
            'assets/drawables/blank-profile-picture-973460_1280.webp');
      }
    }).catchError((error) {
      // If an error occurs, display a placeholder image
      imageProvider =
          AssetImage('assets/drawables/blank-profile-picture-973460_1280.webp');
    });

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 15, 53, 143)),
        ),
        centerTitle: true,
        title: const Center(
          child: Text(
            'Profile Screen',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => FeaturesOverviewScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  print("yessssssss");
                  U.User userData = snapshot.data as U.User;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Stack(children: [
                        CircleAvatar(
                          backgroundColor: Colors.amberAccent,
                          minRadius: 75.0,
                          child: CircleAvatar(
                              radius: 71.0, backgroundImage: imageProvider),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 140,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.amberAccent,
                              ),
                              child: PopupMenuButton(
                                onSelected: (FilterOptions selectedValue) {
                                  if (selectedValue ==
                                      FilterOptions.Favorites) {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) => bottomsheet());
                                  } else {
                                    imageProvider = AssetImage(
                                        'assets/drawables/blank-profile-picture-973460_1280.webp');
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .where('email', isEqualTo: user!.email)
                                        .get()
                                        .then((querySnapshot) {
                                      querySnapshot.docs.forEach((doc) {
                                        setState(() {
                                          doc.reference.update({
                                            'profile_picture_url':
                                                FieldValue.delete()
                                          });
                                        });
                                      });
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                itemBuilder: (_) => [
                                  PopupMenuItem(
                                    child: Text('Edit profile Picture'),
                                    value: FilterOptions.Favorites,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Remove Profile Picture'),
                                    value: FilterOptions.All,
                                  ),
                                ],
                              ),
                            ))
                      ]),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Form(
                          child: Column(
                        children: [
                          Stack(children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  initialValue: userData.name ?? '',
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Name : ',
                                    ),
                                    prefixIcon: Icon(Icons.person,
                                        color: Color(0xff9a3a51)),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 15,
                                        top: 15,
                                        right: 15),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 35,
                                right: 50,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black38,
                                    size: 20,
                                  ),
                                )),
                          ]),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Stack(children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  initialValue: userData.email ?? '',
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Email : ',
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Color(0xff1c69a2),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 15,
                                        top: 15,
                                        right: 15),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 35,
                                right: 50,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black38,
                                    size: 20,
                                  ),
                                )),
                          ]),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Stack(children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(60),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  initialValue: userData.gender ?? '',
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Gender : ',
                                    ),
                                    prefixIcon: Icon(Icons.male,
                                        color: Color(0xff9a3a51)),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 15,
                                        top: 15,
                                        right: 15),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 35,
                                right: 50,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black38,
                                    size: 20,
                                  ),
                                )),
                          ]),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Stack(children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  border: Border.all(width: 2),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  initialValue: userData.country ?? '',
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Country : ',
                                    ),
                                    prefixIcon: Icon(
                                      Icons.countertops,
                                      color: Color(0xff1c69a2),
                                    ),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 15,
                                        top: 15,
                                        right: 15),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 35,
                                right: 50,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black38,
                                    size: 20,
                                  ),
                                )),
                          ]),
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      )),
                    ],
                  );
                } else if (snapshot.hasError) {
                  print("no");
                  print("Error while fetching user data: ${snapshot.error}");
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  print("noooo");
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
