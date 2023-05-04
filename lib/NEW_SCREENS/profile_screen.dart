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

class ProfileScreens extends StatefulWidget {
  @override
  static const routeName = '/profile';
  State<ProfileScreens> createState() => ProfileScreensState();
}

class ProfileScreensState extends State<ProfileScreens> {
  bool isObscurePassword = true;
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

  void _editField(String fieldName) {}

  Widget buildEditableTextField(String label, String text, Icon icon,
      bool isPassword, VoidCallback onEditPressed) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: text,
            readOnly: true,
            obscureText: isPassword,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Colors.grey),
              prefixIcon: icon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            final braceletQuerySnapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where(label, isEqualTo: text)
                .get();
            final braceletDoc = braceletQuerySnapshot.docs.first.reference;

            await showDialog(
              context: context,
              builder: (ctx) {
                String newText = text;
                return AlertDialog(
                  title: Text('Edit $label'),
                  content: TextFormField(
                    initialValue: text,
                    onChanged: (value) {
                      newText = value;
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await braceletDoc.update({
                          label: newText,
                        });
                        setState(() {
                          text = newText;
                        });
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Save'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
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
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Profile Screen',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          // Navigate back to the previous page
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    print("yessssssss");
                    U.User userData = snapshot.data as U.User;
                    TextEditingController nameController =
                        TextEditingController(text: userData.name ?? '');

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
                                          .where('email',
                                              isEqualTo: user!.email)
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              buildEditableTextField(
                                "name",
                                userData.name ?? '',
                                Icon(Icons.person, color: Color(0xff9a3a51)),
                                false,
                                () => _editField('name'),
                              ),
                              const SizedBox(height: 15),
                              buildEditableTextField(
                                "email",
                                userData.email ?? '',
                                Icon(Icons.email, color: Color(0xff1c69a2)),
                                false,
                                () => _editField('email'),
                              ),
                              const SizedBox(height: 15),
                              buildEditableTextField(
                                "password",
                                userData.password ?? '',
                                Icon(Icons.lock, color: Color(0xff9a3a51)),
                                true,
                                () => _editField('password'),
                              ),
                              const SizedBox(height: 15),
                              buildEditableTextField(
                                "gender",
                                userData.gender ?? '',
                                Icon(Icons.male, color: Color(0xff1c69a2)),
                                false,
                                () => _editField('gender'),
                              ),
                              const SizedBox(height: 15),
                              buildEditableTextField(
                                "country",
                                userData.country ?? '',
                                Icon(Icons.countertops,
                                    color: Color(0xff9a3a51)),
                                false,
                                () => _editField('country'),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              child: Text("cancel",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: Text("save",
                                    style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 2,
                                        color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))))
                          ],
                        ),
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
      ),
    );
  }
}
