import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:ecommerceproject/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Signuppage extends StatefulWidget {

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  Color circleavatarbackgroundcolor = Colors.blue.shade200;

  bool circularindicator=false;

  bool blankimage=false;
  bool blankusername=false;
  bool blankemail=false;
  bool blankcontact=false;
  bool blankpassword=false;

  bool imagest = false;
  String imagepath = "";
  Registereddata? rg;

  @override
  Widget build(BuildContext context) {
    double tw = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Container(
                width: tw,
                alignment: AlignmentDirectional.center,
                child: GestureDetector(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery,imageQuality: 15);

                    setState(() {
                      imagepath = image!.path;
                      imagest = true;
                    });
                  },
                  child: imagest
                      ? CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(
                      File(imagepath),
                    ),
                  )
                      : CircleAvatar(
                    backgroundColor: circleavatarbackgroundcolor,
                    radius: 80,
                    child: Icon(
                      Icons.camera_alt_outlined,size: 55,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Sign Up",
                style: GoogleFonts.almarai(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 05,
              ),
              Text(
                "Create a New Account",
                style: GoogleFonts.almarai(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Username",
                style: GoogleFonts.almarai(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 05,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: username,
                  cursorColor: Colors.black,
                  //textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: blankusername?"Enter Username*" : "Joe",
                    hintStyle:
                    TextStyle(color: blankusername ? Colors.red : null),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,
                          color: blankusername? Colors.red : Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: blankusername ? Colors.red.withOpacity(0.5) : Colors.black.withOpacity(0.5), width: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email",
                style: GoogleFonts.almarai(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 05,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: email,
                  cursorColor: Colors.black,
                  //textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: blankemail?"Enter Email*" : "Joe@gmail.com",
                    hintStyle:
                    TextStyle(color: blankemail ? Colors.red : null),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,
                          color: blankemail? Colors.red : Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: blankemail ? Colors.red.withOpacity(0.5) : Colors.black.withOpacity(0.5), width: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Contact",
                style: GoogleFonts.almarai(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 05,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: phone,
                  obscureText: true,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  //textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: blankcontact?"Enter Contact*" : "0987654321",
                    hintStyle:
                    TextStyle(color: blankcontact ? Colors.red : null),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,
                          color: blankcontact? Colors.red : Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: blankcontact ? Colors.red.withOpacity(0.5) : Colors.black.withOpacity(0.5), width: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Password",
                style: GoogleFonts.almarai(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 05,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  cursorColor: Colors.black,
                  //textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: blankpassword?"Enter Password*" : "******",
                    hintStyle:
                    TextStyle(color: blankpassword ? Colors.red : null),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,
                          color: blankpassword ? Colors.red : Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: blankpassword ? Colors.red.withOpacity(0.5) : Colors.black.withOpacity(0.5), width: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  if(imagepath=="" || username.text.isEmpty || email.text.isEmpty || phone.text.isEmpty || password.text.isEmpty){
                    if(imagepath==""){
                      setState(() {
                        circleavatarbackgroundcolor=Colors.red;
                      });
                    }else{
                      setState(() {
                        circleavatarbackgroundcolor=Colors.blue.shade200;
                      });
                    }
                    if(username.text.isEmpty){
                      setState(() {
                        blankusername=true;
                      });
                    }else{
                      setState(() {
                        blankusername=false;
                      });
                    }
                    if(email.text.isEmpty){
                      setState(() {
                        blankemail=true;
                      });
                    }else{
                      setState(() {
                        blankemail=false;
                      });
                    }
                    if(phone.text.isEmpty){
                      setState(() {
                        blankcontact=true;
                      });
                    }else{
                      setState(() {
                        blankcontact=false;
                      });
                    }
                    if(password.text.isEmpty){
                      setState(() {
                        blankpassword=true;
                      });
                    }else{
                      setState(() {
                        blankpassword=false;
                      });
                    }
                  }
                  else{

                    setState(() {
                      blankimage=false;
                      blankusername=false;
                      blankemail=false;
                      blankcontact=false;
                      blankpassword=false;
                    });

                    circularindicator=true;
                    showprogress(circularindicator);

                    List<int> bytearray = File(imagepath).readAsBytesSync();
                    String imagepathe = base64Encode(bytearray);

                    Map registermap = {
                      "name": username.text,
                      "email": email.text,
                      "contact": phone.text,
                      "password": password.text,
                      "imagedata": imagepathe
                    };

                    var url = Uri.parse(
                        'https://ecommercerutvik.000webhostapp.com/ecommercedata/register.php');
                    var response = await http.post(url, body: registermap);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    var dcode = jsonDecode(response.body);
                    setState(() {
                      rg = Registereddata.fromJson(dcode);
                    });

                    print("=========dcode========$dcode");

                    if (rg!.connection == 1 && rg!.result == 1) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Registration Success"),
                        duration: Duration(seconds: 1),
                      ));
                      Navigator.pop(context);
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return Signinpage();
                          },
                        ));
                      });
                    } else if (rg!.result == 2) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Exist")));
                    } else if (rg!.connection == 0) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Database Connection Error")));
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All Error")));

                    }
                  }

                },
                child: Container(
                  margin: EdgeInsets.only(left: 60, right: 60),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: InkWell(
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.almarai(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return Signinpage();
                  },));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 60, right: 60),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Text(
                    "Sign in",
                    style: GoogleFonts.almarai(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showprogress(bool circularindicator) {
    setState(() {
      if(circularindicator){
        showDialog(context: context, builder: (context) {
          return Center(child: CircularProgressIndicator());
        },);
      }
    });
  }
}

class Registereddata {
  int? connection;
  int? result;

  Registereddata({this.connection, this.result});

  Registereddata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}

