
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:totalcare/auth/services/auth_service.dart';
import 'package:totalcare/commons%20widget/button.dart';

import 'package:totalcare/commons%20widget/loader.dart';

import 'package:totalcare/commons%20widget/text_icon.dart';

import 'package:totalcare/constant/global_variables.dart';
import 'package:totalcare/constant/show_snackbar.dart';
import 'package:totalcare/constant/utils.dart';
import 'package:totalcare/home/bottom_navi_page.dart';

import 'package:totalcare/provider/theme_provider.dart';

import '../../models/member.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final authService = AuthService();
  final nameCont = TextEditingController();

  final mobileCont = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UniqueKey uniqueKey = UniqueKey();

  String? img;

  List<Member>? mem;
  Member? member;
  bool flag = true;

  void selectedImage() async {
    img = await selectImage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    memData();
  }

  memData() async {
    mem = await authService.fetchMember(context);
    setState(() {});
  }

  updateMember(Member member) async {
    await authService.edit(
        context: context,
        name: nameCont.text,
        mobile: int.parse(mobileCont.text),
        image: img!);
  }

  // language

  void setLocal(Locale value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return mem == null
        ? const Loader()
        : Drawer(
            backgroundColor: navbarColor,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: mem!.length,
                      itemBuilder: (context, index) {
                        var memData = mem![index];
                        return ListTile(
                          // leading: Text(memProv.name),
                          leading: ClipOval(
                            child: img != null
                                ? Image.file(
                                    File(img!),
                                    height: 100,
                                    width: 60,
                                    fit: BoxFit.fill,
                                  )
                                : Image.network(
                                    memData.image,
                                    height: 100,
                                    width: 60,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                          title: Text(memData.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(memData.email),
                              Text(memData.mobile.toString())
                            ],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: textColor,
                  ),
                  TextIcon(
                      onPressed: () {
                        setLocal(Locale.fromSubtags(languageCode: 'de'));
                        setState(() {});
                      },
                      icon: Icons.settings,
                      text: 'Settings'),
                  TextIcon(
                      onPressed: () {
                        themeDialog(context);
                      },
                      icon: Icons.edit,
                      text: 'Theme'),
                  TextIcon(
                      onPressed: () {
                        myDialog(context);
                      },
                      icon: Icons.edit,
                      text: 'Profile'),
                  TextIcon(
                      onPressed: () {
                        AuthService().logout(context);
                      },
                      icon: Icons.logout,
                      text: 'Logout'),
                ],
              ),
            )),
          );
  }

  myDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Member Profile'),
            content: StatefulBuilder(builder: (context, setState) {
              return Container(
                height: 400,
                width: 100,
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: mem!.length,
                        itemBuilder: (context, index) {
                          var data = mem![index];
                          return Form(
                            key: formKey,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    selectedImage();
                                    setState(() {});
                                  },
                                  
                                  child: ClipOval(
                                    child: img != null
                                        ? Image.file(File(img!),
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover)
                                        : Image.network(
                                            data.image,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                
                                ElevatedButton(
                                    onPressed: () {
                                      
                                      setState(() {});
                                    },
                                    child: const Text('Upload')),
                                
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: nameCont,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Enter Your New Name';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: data.name,
                                      hintStyle: TextStyle(color: textColor)),
                                ),
                                TextFormField(
                                  controller: mobileCont,
                                  validator: (String? val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Enter Your New Mobile';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: data.mobile.toString(),
                                      hintStyle: TextStyle(color: textColor)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Button(
                                    text: 'Update Profile',
                                    onTap: () {
                                      if (formKey.currentState!.validate() &&
                                          img!.isNotEmpty) {
                                        updateMember(data);
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            BottomNavi.bottomNavi,
                                            (route) => false);
                                        showSnackBar(
                                            context, 'Your Profile is updated');
                                      } else {}
                                    },
                                    color: Colors.green)
                              ],
                            ),
                          );
                        })
                  ],
                ),
              );
            }),
          );
        });
  }

  themeDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            shadowColor: Colors.white,
            title: const Text('Choose a Theme Color'),
            content: SizedBox(
              height: 200,
              width: 100,
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        ThemeData themeOrange = ThemeData(
                            colorScheme: ColorScheme.fromSeed(
                                seedColor:
                                    const Color.fromRGBO(237, 179, 90, 1)),
                            scaffoldBackgroundColor:
                                const Color.fromRGBO(237, 179, 90, 1));
                        Provider.of<ThemeProvider>(context, listen: false)
                            .setThemeColor(themeOrange);

                        setState(() {});
                      },
                      child: const Text(
                        'Orange',
                        style: TextStyle(fontSize: 20),
                      )),
                  TextButton(
                      onPressed: () {
                        ThemeData themeBlue = ThemeData(
                            colorScheme: ColorScheme.fromSeed(
                                seedColor: backgroundColor),
                            scaffoldBackgroundColor: backgroundColor);
                        Provider.of<ThemeProvider>(context, listen: false)
                            .setThemeColor(themeBlue);
                        setState(() {});
                      },
                      child: const Text(
                        'Blue',
                        style: TextStyle(fontSize: 20),
                      )),
                  TextButton(
                      onPressed: () {
                        ThemeData themeGreen = ThemeData(
                            colorScheme: ColorScheme.fromSeed(
                                seedColor:
                                    const Color.fromARGB(255, 174, 231, 176)),
                            scaffoldBackgroundColor:
                                const Color.fromARGB(255, 174, 231, 176));
                        Provider.of<ThemeProvider>(context, listen: false)
                            .setThemeColor(themeGreen);
                        setState(() {});
                      },
                      child: const Text(
                        'Green',
                        style: TextStyle(fontSize: 20),
                      )),
                  TextButton(
                      onPressed: () {
                        ThemeData themeYellow = ThemeData(
                            colorScheme:
                                ColorScheme.fromSeed(seedColor: Colors.yellow),
                            scaffoldBackgroundColor: Colors.yellow);
                        Provider.of<ThemeProvider>(context, listen: false)
                            .setThemeColor(themeYellow);

                        setState(() {});
                      },
                      child: const Text(
                        'Yellow',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
