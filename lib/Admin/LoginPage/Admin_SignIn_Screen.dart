import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_firebase/Admin/LoginPage/widget/custom_text_field.dart';
import 'package:web_firebase/Widgets/colors.dart';

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _adminIDTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  loginAdmin() async {
    FirebaseFirestore.instance.collection("admin").get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((result) {
        if (result.get('id') != _adminIDTextEditingController.text.trim()) {
          EasyLoading.showInfo(
            "Votre id est incorrect.",
          );
        } else if (result.get("password") != _passwordTextEditingController.text.trim()) {
          EasyLoading.showInfo(
            "Votre mot de passe est incorrect.",
          );
        } else {
          EasyLoading.showInfo(
            "Bienvenu " + result.get("id"),
          );
          setState(() {
            _adminIDTextEditingController.clear();
            _passwordTextEditingController.clear();
          });
         Navigator.of(context).pushNamed('/homePage');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            decoration: new BoxDecoration(
               image: DecorationImage(
                  colorFilter: ColorFilter.srgbToLinearGamma(),
                  image: AssetImage('images/admin.png'),
                  fit: BoxFit.fitHeight,
                ),
              gradient: new LinearGradient(
                colors: [AppColors.LIGHT, AppColors.WHITE],
              ),
            ),
            alignment: Alignment.bottomCenter,
          ),
           Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Admin",
                  style: TextStyle(
                    color: AppColors.PRIMARY_COLOR.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
          Container(
            width: MediaQuery.of(context).size.width /2.5,
            child:  Column(
              mainAxisSize: MainAxisSize.max, children: [
           
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _adminIDTextEditingController,
                      data: Icons.person,
                      hintText: "Id",
                      fillColor: AppColors.PRIMARY_COLOR.withOpacity(0.1),
                      isObsecure: false,
                    ),
                    CustomTextField(
                      controller: _passwordTextEditingController,
                      data: Icons.lock,
                      hintText: "Mot de passe",
                      isObsecure: true,
                      fillColor: AppColors.PRIMARY_COLOR.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Connexion'.toUpperCase(),
                      style: TextStyle(color: AppColors.WHITE)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    _adminIDTextEditingController.text.isNotEmpty &&
                            _passwordTextEditingController.text.isNotEmpty
                        ? loginAdmin()
                        : EasyLoading.showInfo(
                            "Veuillez saisir votre id et mot de passe!");
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
