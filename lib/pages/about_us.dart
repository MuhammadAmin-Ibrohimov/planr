import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Placeholder(
            fallbackHeight: 200,
          ),
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Produced by Infinitium Team ",
                style: TextStyle(
                    color: Color.fromARGB(255, 4, 8, 247),
                    fontSize: 20,
                    fontStyle: FontStyle.normal),
              )),
          SizedBox(
            width: 500,
            child: Text(
                "Biz sun'iy intelektga oid dasturlar yaratish borasida foaliyat yuritayotgan kompaniyamiz"),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 500,
            child: Text("Biznig rasmiy web sahifalarimiz : "),
          ),
        ],
      ),
    );
  }
}
