import 'package:database_project/modules/utils/helper/db_helper.dart';
import 'package:database_project/modules/utils/models/helperModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});
  @override
  int selectedIndex = 0;
  TextEditingController name = TextEditingController();
  TextEditingController city = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.changeTheme(
                Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
          },
          icon: const Icon(Icons.dark_mode),
        ),
        title: const Text("Database "),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Stack(
                  children: [
                    Card(
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

                              int? res = await DBhelper.dBhelper
                                  .insertData(data: data);

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
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: FutureBuilder(
                future: DBhelper.dBhelper.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List rawData = snapshot.data!;

                    List<Data> ListOfdata = rawData
                        .map(
                          (e) => Data.rawToObject(data: e),
                        )
                        .toList();

                    return ListView.builder(
                      itemCount: ListOfdata.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              ListOfdata[index].name,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Database error');
                  } else {
                    return CircularProgressIndicator(
                      color: Colors.blue,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
