import 'package:flutter/material.dart';
import 'package:flutter_ml_integration_demo_1/pages/addition_info.dart';
import 'package:flutter_ml_integration_demo_1/pages/base.dart';
import 'package:flutter_ml_integration_demo_1/pages/about_us.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSection.basePage;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSection.basePage) {
      container = const BasePage();
    } else if (currentPage == DrawerSection.additionalinfo) {
      container = const AdditionPage();
    } else if (currentPage == DrawerSection.contactUs) {
      container = const ContactUsPage();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("Plant disease detector")),
      ),
      drawer: Drawer(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: Colors.blue[100],
                width: double.infinity,
                child: Center(
                    child: DrawerHeader(
                        child: Column(children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "Plant disease detector",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                      flex: 5,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const Image(
                              image: AssetImage('assets/images/plant.jpg'))))
                ])))),
            myDreawerList()
          ],
        ),
      )),
      body: container,
    );
  }

  Widget myDreawerList() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          menuItem(1, "Asosiy", Icons.home_outlined,
              currentPage == DrawerSection.basePage ? true : false),
          menuItem(2, "Qo'shimcha ma'lumotlar", Icons.info_outline,
              currentPage == DrawerSection.additionalinfo ? true : false),
          menuItem(3, "Biz haqimizda", Icons.group_outlined,
              currentPage == DrawerSection.contactUs ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData iconData, bool selected) {
    return Material(
      color: selected
          ? Theme.of(context).secondaryHeaderColor
          : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSection.basePage;
            } else if (id == 2) {
              currentPage = DrawerSection.additionalinfo;
            } else if (id == 3) {
              currentPage = DrawerSection.contactUs;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                iconData,
                size: 20,
                color: Colors.black,
              )),
              Expanded(
                  flex: 4,
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSection {
  basePage,
  additionalinfo,
  contactUs,
}
