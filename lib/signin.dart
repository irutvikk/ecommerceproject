import 'dart:convert';

import 'package:ecommerceproject/signup.dart';
import 'package:ecommerceproject/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  Loginphp? login;
  bool blankusername = false;
  bool blankpassword = false;
  bool circularindicator=false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tw = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: tw,
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.network(
                  "https://img.freepik.com/free-vector/happy-people-shopping-online_74855-5865.jpg?w=740&t=st=1679459153~exp=1679459753~hmac=ac4bff464c90f1806659664b1bcd66bc00efc529774be6c703fb9422884ad527",
                  height: 190,
                  width: tw * 0.7,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Welcome!",
                style: GoogleFonts.almarai(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 05,
              ),
              Text(
                "please login or sign up to continue our app",
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
                child: TextFormField(
                  controller: username,
                  cursorColor: Colors.black,
                  //textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: blankusername ? "Enter Username*" : "abc",
                    hintStyle:
                        TextStyle(color: blankusername ? Colors.red : null),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: blankusername ? Colors.red : Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: blankusername
                            ? Colors.red.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5),
                        width: 1,
                      ),
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
                child: TextFormField(
                  controller: password,
                  obscureText: true,
                  cursorColor: Colors.black,
                  //textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: blankpassword ? "Enter Password*" : "******",
                    hintStyle:
                        TextStyle(color: blankpassword ? Colors.red : null),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          color: blankpassword ? Colors.red : Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: blankpassword
                              ? Colors.red.withOpacity(0.5)
                              : Colors.black.withOpacity(0.5),
                          width: 1),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  if (username.text.isEmpty || password.text.isEmpty) {
                    if (username.text.isEmpty) {
                      setState(() {
                        blankusername = true;
                      });
                    } else {
                      setState(() {
                        blankusername = false;
                      });
                    }
                    if (password.text.isEmpty) {
                      setState(() {
                        blankpassword = true;
                      });
                    } else {
                      setState(() {
                        blankpassword = false;
                      });
                    }
                  } else {
                    setState(() {
                      blankusername = false;
                      blankpassword = false;
                    });

                    circularindicator=true;

                   showprogress(circularindicator);

                    Map passdata = {
                      'name': username.text,
                      'password': password.text
                    };

                    var url = Uri.parse(
                        'https://ecommercerutvik.000webhostapp.com/ecommercedata/login.php');
                    var response = await http.post(url, body: passdata);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    print("=================$url");

                    var dcode = jsonDecode(response.body);
                    setState(() {
                      login = Loginphp.fromJson(dcode);
                    });



                    if (login!.connection == 1 && login!.result == 1) {

                      String? id = login!.userdata!.id;
                      String? name = login!.userdata!.name;
                      String? email = login!.userdata!.email;
                      String? pass = login!.userdata!.password;
                      String? mobile = login!.userdata!.mobile;
                      String? image = login!.userdata!.image;

                      setState(() {
                        Splashscreenpage.prefs!.setString('id', id!);
                        Splashscreenpage.prefs!.setString('name', name!);
                        Splashscreenpage.prefs!.setString('email', email!);
                        Splashscreenpage.prefs!.setString('pass', pass!);
                        Splashscreenpage.prefs!.setString('mobile', mobile!);
                        Splashscreenpage.prefs!.setString('image', image!);

                        Splashscreenpage.prefs!.setBool('loginstatus', true);
                      });

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Login Success"),
                        duration: Duration(seconds: 1),
                      ));

                        Future.delayed(Duration(seconds: 1)).then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return Homepage();
                          },
                        ));
                      });

                    } else {
                      setState(() {
                       blankusername = true;
                       blankpassword = true;
                     });

                        Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("data not matching or result error")));
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
                      "Sign in",
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
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Signuppage();
                    },
                  ));
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
                    "Sign up",
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

class Loginphp {
  int? connection;
  int? result;
  Userdata? userdata;

  Loginphp({this.connection, this.result, this.userdata});

  Loginphp.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? id;
  String? name;
  String? email;
  String? password;
  String? mobile;
  String? image;

  Userdata(
      {this.id, this.name, this.email, this.password, this.mobile, this.image});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    return data;
  }
}
