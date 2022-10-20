import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:Perpustakaan/db/database_instance.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  int _value = 1;

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama"),
            TextField(
              controller: nameController,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Judul"),
            TextField(
              controller: judulController,
            ),
            SizedBox(
              height: 20,
            ),
            // Text("No Telephone"),
            // TextField(
            //   controller: nameController,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Text("Status"),
            ListTile(
              title: Text("Peminjaman"),
              leading: Radio(
                  groupValue: _value,
                  value: 1,
                  onChanged: (value) {
                    setState(() {
                      _value = int.parse(value.toString());
                    });
                  }),
            ),
            // ListTile(
            //   title: Text("Pengeluaran"),
            //   leading: Radio(
            //       groupValue: _value,
            //       value: 2,
            //       onChanged: (value) {
            //         setState(() {
            //           _value = int.parse(value.toString());
            //         });
            //       }),
            // ),
            SizedBox(
              height: 20,
            ),
            Text("Total Buku"),
            TextField(
              controller: totalController,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  int idInsert = await databaseInstance.insert({
                    'name': nameController.text,
                    'judul_buku': judulController.text,
                    'type': _value,
                    'total': totalController.text,
                    'tgl_awl': DateTime.now().toString(),
                    'tgl_akhr': DateTime.now().add(Duration(hours: 24*7)).toString(),
                    'created_at': DateTime.now().toString(),
                    'updated_at': DateTime.now().toString(),
                  });
                  print("sudah masuk : " + idInsert.toString());
                  Navigator.pop(context);
                  setState(() {
                  });
                },
                child: Text("Simpan")),
          ],
        ),
      )),
    );
  }
}
