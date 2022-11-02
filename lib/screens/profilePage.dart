import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String aType;
  ProfilePage({
    required this.name,
    required this.age,
    required this.gender,
    required this.aType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF60BAED),
        title: Text(name),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30,
          ),
          child: Column(
            children: [
              Container(
                child: Text(
                  "$age years old",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Container(
                  child: Text(
                    (gender == "M" || gender == 'm') ? "Male" : "Female",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Container(
                  child: Text(
                    "$aType Employee",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: Text("Log out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
