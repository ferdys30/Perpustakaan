import 'package:flutter/material.dart';
import 'package:Perpustakaan/db/database_instance.dart';
import 'package:Perpustakaan/models/transaksi_model.dart';
import 'package:Perpustakaan/screens/create_screen.dart';
import 'package:Perpustakaan/screens/update_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kelola Duitku",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseInstance? databaseInstance;

  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  showAlertDialog(BuildContext contex, int idTransaksi) {
    Widget okButton = ElevatedButton(
      child: Text("Yakin"),
      onPressed: () {
        //delete disini
        databaseInstance!.hapus(idTransaksi);
        Navigator.of(contex, rootNavigator: true).pop();
        setState(() {});
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Peringatan !"),
      content: Text("Anda yakin akan menghapus ?"),
      actions: [okButton],
    );

    showDialog(
        context: contex,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perpustakaan"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CreateScreen()))
                  .then((value) {
                setState(() {});
              });
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<TransaksiModel>>(
                future: databaseInstance!.getAll(),
                builder: (context, snapshot) {
                  print('HASIL : ' + snapshot.data.toString());
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  } else {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              
                              return ListTile(
                                  title: Text(
                                    snapshot.data![index].name!
                                    ),
                                  subtitle :Text(snapshot.data![index].tglakhr!.toString()),
                                  leading: snapshot.data![index].type == 2
                                      ? Icon(
                                          Icons.check_box,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.check_box_outline_blank_outlined,
                                          color: Colors.green,
                                        ),
                                  trailing: Wrap(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateScreen(
                                                          transaksiMmodel:snapshot.data![index],
                                                        )))
                                                .then((value) {
                                              setState(() {});
                                            });
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.grey,
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showAlertDialog(context,
                                                snapshot.data![index].id!);
                                          },
                                          icon: Icon(Icons.delete,
                                              color: Colors.red))
                                    ],
                                  ));
                            }),
                      );
                    } else {
                      return Text("Tidak ada data");
                    }
                  }
                }),

                FutureBuilder(
                future: databaseInstance!.totalPemasukan(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("-");
                  } else {
                    if (snapshot.hasData) {
                      return Text(
                          "Total Buku Dipinjam :  ${snapshot.data.toString()}");
                    } else {
                      return Text("");
                    }
                  }
                }),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: databaseInstance!.totalPengeluaran(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("-");
                  } else {
                    if (snapshot.hasData) {
                      return Text(
                          "Total Pengembalian Buku :  ${snapshot.data.toString()}");
                    } else {
                      return Text("");
                    }
                  }
                }),
                SizedBox(
              height: 50,
            ),

          ],
        )),
      ),
    );
  }
}
