import 'package:flutter/material.dart';
import 'package:tottracker/providers/signup_controller.dart';
import 'package:tottracker/providers/user.dart';
import '../NEW_WIDGETS/button.dart';
import 'package:get/get.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final controller = Get.put(SignUpController());
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _genderController = TextEditingController();
  final _countryController = TextEditingController();
  String nameState = 'Enter Your Name';
  String email = 'Enter Your Email';
  String pass = 'Enter Your Password';
  String configPass = 'Confirm Password';
  String gender = 'Enter Your Gender';
  String country = 'Enter Your Country';
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _configpassFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          OutlinedButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _saveForm() async {
    //returns true lw kol el returns mel validator is null
    final is_valid = _form.currentState?.validate();
    if (!is_valid!) {
      setState(() {});
      return;
    }
    _form.currentState!.save();
    final user = User(
        name: controller.nameController.text.trim(),
        email: controller.emailController.text.trim(),
        password: controller.passwordController.text.trim(),
        country: controller.countryController.text.trim(),
        gender: controller.genderController.text.trim());
    SignUpController.instance.registerUser(user).then((value) =>
        SignUpController.instance.createUser(controller.emailController.text,
            controller.passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    List<String> countries = [
      "Afghanistan",
      "Åland Islands",
      "Albania",
      "Algeria",
      "American Samoa",
      "Andorra",
      "Angola",
      "Anguilla",
      "Antarctica",
      "Antigua and Barbuda",
      "Argentina",
      "Armenia",
      "Aruba",
      "Australia",
      "Austria",
      "Azerbaijan",
      "Bahamas",
      "Bahrain",
      "Bangladesh",
      "Barbados",
      "Belarus",
      "Belgium",
      "Belize",
      "Benin",
      "Bermuda",
      "Bhutan",
      "Bolivia, Plurinational State of",
      "Bonaire, Sint Eustatius and Saba",
      "Bosnia and Herzegovina",
      "Botswana",
      "Bouvet Island",
      "Brazil",
      "British Indian Ocean Territory",
      "Brunei Darussalam",
      "Bulgaria",
      "Burkina Faso",
      "Burundi",
      "Cambodia",
      "Cameroon",
      "Canada",
      "Cape Verde",
      "Cayman Islands",
      "Central African Republic",
      "Chad",
      "Chile",
      "China",
      "Christmas Island",
      "Cocos (Keeling) Islands",
      "Colombia",
      "Comoros",
      "Congo",
      "Congo, the Democratic Republic of the",
      "Cook Islands",
      "Costa Rica",
      "CÃte d'Ivoire",
      "Croatia",
      "Cuba",
      "CuraÃ§ao",
      "Cyprus",
      "Czech Republic",
      "Denmark",
      "Djibouti",
      "Dominica",
      "Dominican Republic",
      "Ecuador",
      "Egypt",
      "El Salvador",
      "Equatorial Guinea",
      "Eritrea",
      "Estonia",
      "Ethiopia",
      "Falkland Islands (Malvinas)",
      "Faroe Islands",
      "Fiji",
      "Finland",
      "France",
      "French Guiana",
      "French Polynesia",
      "French Southern Territories",
      "Gabon",
      "Gambia",
      "Georgia",
      "Germany",
      "Ghana",
      "Gibraltar",
      "Greece",
      "Greenland",
      "Grenada",
      "Guadeloupe",
      "Guam",
      "Guatemala",
      "Guernsey",
      "Guinea",
      "Guinea-Bissau",
      "Guyana",
      "Haiti",
      "Heard Island and McDonald Islands",
      "Holy See (Vatican City State)",
      "Honduras",
      "Hong Kong",
      "Hungary",
      "Iceland",
      "India",
      "Indonesia",
      "Iran, Islamic Republic of",
      "Iraq",
      "Ireland",
      "Isle of Man",
      "Israel",
      "Italy",
      "Jamaica",
      "Japan",
      "Jersey",
      "Jordan",
      "Kazakhstan",
      "Kenya",
      "Kiribati",
      "Korea, Democratic People's Republic of",
      "Korea, Republic of",
      "Kuwait",
      "Kyrgyzstan",
      "Lao People's Democratic Republic",
      "Latvia",
      "Lebanon",
      "Lesotho",
      "Liberia",
      "Libya",
      "Liechtenstein",
      "Lithuania",
      "Luxembourg",
      "Macao",
      "Macedonia, the Former Yugoslav Republic of",
      "Madagascar",
      "Malawi",
      "Malaysia",
      "Maldives",
      "Mali",
      "Malta",
      "Marshall Islands",
      "Martinique",
      "Mauritania",
      "Mauritius",
      "Mayotte",
      "Mexico",
      "Micronesia, Federated States of",
      "Moldova, Republic of",
      "Monaco",
      "Mongolia",
      "Montenegro",
      "Montserrat",
      "Morocco",
      "Mozambique",
      "Myanmar",
      "Namibia",
      "Nauru",
      "Nepal",
      "Netherlands",
      "New Caledonia",
      "New Zealand",
      "Nicaragua",
      "Niger",
      "Nigeria",
      "Niue",
      "Norfolk Island",
      "Northern Mariana Islands",
      "Norway",
      "Oman",
      "Pakistan",
      "Palau",
      "Palestine, State of",
      "Panama",
      "Papua New Guinea",
      "Paraguay",
      "Peru",
      "Philippines",
      "Pitcairn",
      "Poland",
      "Portugal",
      "Puerto Rico",
      "Qatar",
      "RÃ©union",
      "Romania",
      "Russian Federation",
      "Rwanda",
      "Saint BarthÃ©lemy",
      "Saint Helena, Ascension and Tristan da Cunha",
      "Saint Kitts and Nevis",
      "Saint Lucia",
      "Saint Martin (French part)",
      "Saint Pierre and Miquelon",
      "Saint Vincent and the Grenadines",
      "Samoa",
      "San Marino",
      "Sao Tome and Principe",
      "Saudi Arabia",
      "Senegal",
      "Serbia",
      "Seychelles",
      "Sierra Leone",
      "Singapore",
      "Sint Maarten (Dutch part)",
      "Slovakia",
      "Slovenia",
      "Solomon Islands",
      "Somalia",
      "South Africa",
      "South Georgia and the South Sandwich Islands",
      "South Sudan",
      "Spain",
      "Sri Lanka",
      "Sudan",
      "Suriname",
      "Svalbard and Jan Mayen",
      "Swaziland",
      "Sweden",
      "Switzerland",
      "Syrian Arab Republic",
      "Taiwan, Province of China",
      "Tajikistan",
      "Tanzania, United Republic of",
      "Thailand",
      "Timor-Leste",
      "Togo",
      "Tokelau",
      "Tonga",
      "Trinidad and Tobago",
      "Tunisia",
      "Turkey",
      "Turkmenistan",
      "Turks and Caicos Islands",
      "Tuvalu",
      "Uganda",
      "Ukraine",
      "United Arab Emirates",
      "United Kingdom",
      "United States",
      "United States Minor Outlying Islands",
      "Uruguay",
      "Uzbekistan",
      "Vanuatu",
      "Venezuela, Bolivarian Republic of",
      "Viet Nam",
      "Virgin Islands, British",
      "Virgin Islands, U.S.",
      "Wallis and Futuna",
      "Western Sahara",
      "Yemen",
      "Zambia",
      "Zimbabwe"
    ];

    List<DropdownMenuItem<String>> dropdownItems = [
      DropdownMenuItem(
        value: 'Enter Your Country',
        child: Text(
          'Enter Your Country',
          style: TextStyle(
              color: Color.fromARGB(255, 108, 105, 105), fontSize: 16),
        ),
      ),
    ];

    countries.forEach((country) {
      dropdownItems.add(
        DropdownMenuItem(
          value: country,
          child: Text(country),
        ),
      );
    });
    return Scaffold(
      //backgroundColor: Color(0xff3F3C3C),
      backgroundColor: Color.fromARGB(255, 228, 224, 224),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: 100,
              height: 100,
              child: Image.asset('assets/drawables/tottracker4.png'),
            ),
            Row(
              children: [
                Text(
                  '  Hello',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Color(0xff9a3a51),
                      fontFamily: 'Silom',
                      fontSize: 35,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '...!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Color(0xff1c69a2),
                      fontFamily: 'Silom',
                      fontSize: 35,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocusNode,
                        cursorColor: Color(0xff9a3a51),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 0.0,
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff9a3a51),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                          hintText: nameState,
                          hintStyle: TextStyle(
                              color: nameState.startsWith('Please')
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        controller: controller.nameController,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            nameState = 'Please Enter Your Name!';
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: TextFormField(
                        focusNode: _passFocusNode,
                        textInputAction: TextInputAction.next,
                        cursorColor: Color(0xff1c69a2),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 0.0,
                          ),
                          prefixIcon: Icon(
                            Icons.email_sharp,
                            color: Color(0xff1c69a2),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                          hintText: email,
                          hintStyle: TextStyle(
                              color: email.startsWith('Please')
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        controller: controller.emailController,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            email = 'Please Enter Your Email!';
                            return '';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value.toString();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        focusNode: _configpassFocusNode,
                        textInputAction: TextInputAction.next,
                        cursorColor: Color(0xff9a3a51),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 0.0,
                          ),
                          prefixIcon: Icon(
                            Icons.password,
                            color: Color(0xff9a3a51),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                          hintText: pass,
                          hintStyle: TextStyle(
                              color: pass.startsWith('Please')
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        controller: controller.passwordController,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            pass = 'Please Enter Your Password!';
                            return '';
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value.toString();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        focusNode: _genderFocusNode,
                        textInputAction: TextInputAction.next,
                        cursorColor: Color(0xff1c69a2),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 0.0,
                          ),
                          prefixIcon: Icon(
                            Icons.confirmation_number,
                            color: Color(0xff1c69a2),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                          hintText: configPass,
                          hintStyle: TextStyle(
                              color: configPass.startsWith('Please')
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            configPass = 'Please Confirm Your Password!';
                            return '';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 212, 207, 207),
                      ),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Please select your gender',
                          prefixIcon: Icon(
                            Icons.male,
                            color: Color(0xff9a3a51),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.all(
                            13,
                          ),
                          child: Icon(Icons.arrow_drop_down,
                              size: 25, color: Color.fromARGB(255, 90, 90, 90)),
                        ),
                        value: gender,
                        isExpanded: true,
                        onChanged: (val) {
                          setState(() {
                            controller.genderController.text = val!;
                            gender = val.toString();
                          });
                        },
                        items: [
                          DropdownMenuItem<String>(
                            value: "Enter Your Gender",
                            child: Text(
                              "Enter Your Gender",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 108, 105, 105),
                                  fontSize: 16),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: "male",
                            child: Text("Male"),
                          ),
                          DropdownMenuItem<String>(
                            value: "female",
                            child: Text("Female"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 212, 207, 207),
                        ),
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Please select your country',
                              prefixIcon: Icon(
                                Icons.travel_explore,
                                color: Color(0xff1c69a2),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            icon: const Padding(
                              padding: EdgeInsets.all(
                                13,
                              ),
                              child: Icon(Icons.arrow_drop_down,
                                  size: 25,
                                  color: Color.fromARGB(255, 90, 90, 90)),
                            ),
                            value: country,
                            isExpanded: true,
                            onChanged: (val) {
                              controller.countryController.text = val!;
                              setState(() {
                                controller.countryController.text = val!;
                                country = val.toString();
                              });
                            },
                            items: dropdownItems)),
                  ),
                ],
              ),
            ),
            MYB(
                text: "SIGN UP",
                text_color: Color.fromARGB(255, 210, 210, 205),
                ontap: _saveForm)
          ],
        ),
      ),
    );
  }
}
