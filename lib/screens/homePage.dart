import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:interview/Models/CandidateDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:interview/Models/CandidatePrototype.dart';
import 'package:interview/screens/profilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeef8fd),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 41,
          vertical: 95,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Text(
                "Candidates",
                style: TextStyle(
                  color: Color(0xFF60BAED),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FutureBuilder(
              future: ReadJsonData(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(
                    child: Text("${data.error}"),
                  );
                } else if (data.hasData) {
                  var items = data.data as List<CandidateDataModel>;
                  return SizedBox(
                    height: 600,
                    child: ListView.builder(
                      itemCount: items == null ? 0 : items.length,
                      itemBuilder: (context, index) {
                        return candidateButton(
                          Name: items[index].name.toString(),
                          atype_: items[index].atype.toString(),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Wait please"),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<List<CandidateDataModel>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/candidates.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => CandidateDataModel.fromJson(e)).toList();
  }
}

class candidateButton extends StatelessWidget {
  TextEditingController ageController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  final String Name;
  int count = 0;
  String age = "";
  final String atype_;
  candidateButton({required this.Name, required this.atype_});

  @override
  Widget build(BuildContext context) {
    String name = Name;

    return GestureDetector(
      onTap: () {
        if (count == 0) {
          showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(
                name: Name,
                age: ageController.text,
                gender: genderController.text,
                aType: atype_,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Container(
          width: double.infinity,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "$name",
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Color(0xFF60BAED),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 4),
                color: Color(0xFF000000).withOpacity(0.25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      title: Text(
        Name,
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: double.infinity,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                hintText: "Age",
              ),
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(
                  hintText: "Gender (M if male and F if female)"),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (ageController.text != "" || genderController.text != "") {
                    count += 1;
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          buildGoToProfile(context),
                    );
                  }
                },
                child: Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGoToProfile(BuildContext context) {
    return AlertDialog(
      content: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(
                name: Name,
                age: ageController.text,
                gender: genderController.text,
                aType: atype_,
              ),
            ),
          );
        },
        child: Text("Go to profile"),
      ),
    );
  }
}
