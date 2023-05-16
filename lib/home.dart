import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ecommerceproject/signin.dart';
import 'package:ecommerceproject/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Homepage extends StatefulWidget {


  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  String? id;
  String? name;
  String? email;
  String? pass;
  String? mobile;
  String? image;

  int count = 0;
  List<Widget> listofwidget = [
    Viewproductpage(),
    Addproductpage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    setState(() {
      id = Splashscreenpage.prefs!.getString('id') ?? "";
      name = Splashscreenpage.prefs!.getString('name') ?? "";
      email = Splashscreenpage.prefs!.getString('email') ?? "";
      pass = Splashscreenpage.prefs!.getString('pass') ?? "";
      mobile = Splashscreenpage.prefs!.getString('mobile') ?? "";
      image = Splashscreenpage.prefs!.getString('image') ?? "";
      print("==========$image======");

     // Viewproductpage();

      // Future.delayed(Duration()).then((value) {
      //   setState(() {
      //
      //   });
      // });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: count == 0 ? AppBar(title: Text("View Product")) : count ==1 ? AppBar(title: Text("Add Product"),) : null,
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 190,
              child: UserAccountsDrawerHeader(currentAccountPictureSize: Size.square(90),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage("https://ecommercerutvik.000webhostapp.com/ecommercedata/$image")
                  ),
                  accountName: Text("Hello, $name", style: GoogleFonts.almarai(fontSize: 22),),
                  accountEmail: Text("$email",style: GoogleFonts.almarai(fontSize: 20),)),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  count = 0;
                });
              },
              child: Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(
                  title: Text("View Products"),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  count = 1;
                });
              },
              child: Container(
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(
                  title: Text("Add Product"),
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Signinpage();
                },));
              },
              child: Container(
                margin: EdgeInsets.only(top: 3,left: 70,right: 70),
                decoration: BoxDecoration(
                    color: Colors.red.shade800,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      Splashscreenpage.prefs!.setBool('loginstatus', false);
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return Signinpage();
                    },));
                  },
                  title: Center(child: Text("Logout",style: TextStyle(color: Colors.white),)),
                ),
              ),
            ),

          ],
        ),
      ),
      body: listofwidget[count],
    );
  }
}

class Addproductpage extends StatefulWidget {
  const Addproductpage({Key? key}) : super(key: key);

  @override
  State<Addproductpage> createState() => _AddproductpageState();
}

class _AddproductpageState extends State<Addproductpage> {
  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  bool imagest = false;
  String imagepath = "";
  Addproduct? prod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  // Pick an image
                  final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 20
                  );

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
                    : CircleAvatar(backgroundColor: Colors.blue, radius: 80),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    hintText: "product name", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: type,
                decoration: InputDecoration(
                    hintText: "product type", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "product price", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: description,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "product description",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(120, 45))),
                  onPressed: () async {
                    List<int> bytearray = File(imagepath).readAsBytesSync();
                    String imagepathe = base64Encode(bytearray);

                    Map addproductmap = {
                      "productname": name.text,
                      "producttype": type.text,
                      "productprice": price.text,
                      "productdesc": description.text,
                      "pimage": imagepathe,
                      "userid": Splashscreenpage.prefs!.getString('id')
                    };

                    var url = Uri.parse(
                        'https://ecommercerutvik.000webhostapp.com/ecommercedata/addproduct.php');
                    var response = await http.post(url, body: addproductmap);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    print("=======$url");

                    var dcode = jsonDecode(response.body);
                    setState(() {
                      prod = Addproduct.fromJson(dcode);
                    });

                    if (prod!.connection == 1)
                    {
                      if(prod!.result == 1) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return Homepage();
                          },
                        ));
                      }
                    }
                  },
                  child: Text("Add product")),
            ],
          ),
        ),
      ),
    );
  }
}

class Viewproductpage extends StatefulWidget {
  const Viewproductpage({Key? key}) : super(key: key);

  @override
  State<Viewproductpage> createState() => _ViewproductpageState();
}

class _ViewproductpageState extends State<Viewproductpage> {
  String id = "";
  Viewdata? viewdata;
  Deleteproduct? del;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      id = Splashscreenpage.prefs!.getString('id')??"";
    });
    imageCache.clear();
    imageCache.clearLiveImages();
    Viewallproducts();

  }

  Future<void> Viewallproducts() async {
    Map passid = {'userid': id};

    var url = Uri.parse(
        'https://ecommercerutvik.000webhostapp.com/ecommercedata/viewdata.php');
    var response = await http.post(url, body: passid);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print("=================$url");

    var dcode = jsonDecode(response.body);
    setState(() {
      viewdata = Viewdata.fromJson(dcode);
      status = true;
    });

  }
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return viewdata!= null?Scaffold(
        body:
             ListView.builder(
          itemCount: viewdata!.productdata!.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {

                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                    SlidableAction(
                      onPressed: (context) async {

                        Map passdata = {
                          'productid': viewdata!.productdata![index].productid,
                        };

                        var url = Uri.parse(
                            'https://ecommercerutvik.000webhostapp.com/ecommercedata/delete.php');
                        var response = await http.post(url, body: passdata);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        print("=================$url");

                        var dcode = jsonDecode(response.body);

                        setState(() {
                          del = Deleteproduct.fromJson(dcode);
                        });

                        Viewallproducts();

                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ]),
              child: InkWell(
                onTap: () {

                },
                child: Card(
                  elevation: 03,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 4,
                            child: Image.network(
                              "https://ecommercerutvik.000webhostapp.com/ecommercedata/${viewdata!.productdata![index].productimage}",
                              height: 110,
                              fit: BoxFit.fill,
                            )),
                        Expanded(
                            flex: 9,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${viewdata!.productdata![index].productname}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 05,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 120,
                                    color: Colors.red.shade900,
                                    child: Center(
                                        child: Text("Limited time deal",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12))),
                                  ),
                                  SizedBox(
                                    height: 05,
                                  ),
                                  Text(
                                    "₹${viewdata!.productdata![index].productprice}",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  Text(
                                    "${viewdata!.productdata![index].producttype}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )):Center(
      child: Text("No Records Found.."),
    );
  }
}

class Addproduct {
  int? connection;
  int? result;

  Addproduct({this.connection, this.result});

  Addproduct.fromJson(Map<String, dynamic> json) {
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


class Viewdata {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  Viewdata({this.connection, this.result, this.productdata});

  Viewdata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? productid;
  String? productname;
  String? producttype;
  String? productprice;
  String? productdisc;
  String? productimage;
  String? userid;

  Productdata(
      {this.productid,
        this.productname,
        this.producttype,
        this.productprice,
        this.productdisc,
        this.productimage,
        this.userid});

  Productdata.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    productname = json['productname'];
    producttype = json['producttype'];
    productprice = json['productprice'];
    productdisc = json['productdisc'];
    productimage = json['productimage'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    data['productname'] = this.productname;
    data['producttype'] = this.producttype;
    data['productprice'] = this.productprice;
    data['productdisc'] = this.productdisc;
    data['productimage'] = this.productimage;
    data['userid'] = this.userid;
    return data;
  }
}


class Deleteproduct {
  int? connection;
  int? result;

  Deleteproduct({this.connection, this.result});

  Deleteproduct.fromJson(Map<String, dynamic> json) {
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
