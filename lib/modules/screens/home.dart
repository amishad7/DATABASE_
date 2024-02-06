import 'package:database_project/modules/utils/helper/db_helper.dart';
import 'package:database_project/modules/utils/models/helperModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController city = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Database "),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.blueGrey.withOpacity(0.2),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: TextFormField(
                      autocorrect: true,
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: "Name Text",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: TextFormField(
                      autocorrect: true,
                      controller: city,
                      decoration: const InputDecoration(
                        labelText: "City Text",
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Data data = Data(
                        name: name.text,
                        city: city.text,
                      );

                      int? res = await DBhelper.dBhelper.insertData(data: data);

                      Get.snackbar(
                          'Response of table', 'Position of data $res');
                      city.clear();
                      name.clear();
                    },
                    child: const Text(
                      'Pass',
                      style: TextStyle(
                          //    fontSize: 30,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
