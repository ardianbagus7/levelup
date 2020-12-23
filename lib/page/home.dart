import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shinkie/page/detail.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<List> getData() async {
    try {
      final response = await http.get("http://192.168.1.2/android/api2.php");
      return json.decode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LevelUp'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.data == null) {
                return Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Gagal terhubung ke server',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'Refresh',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              } else {
                return ListPaket(
                  data: snapshot.data,
                );
              }
          }
        },
      ),
    );
  }
}

class ListPaket extends StatelessWidget {
  ListPaket({
    Key key,
    this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data[i]['namagame']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${data[i]['namavoucher']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Image.network(data[i]['foto']),
                  SizedBox(height: 20),
                  Text(
                    'Rp. ${data[i]['hargavoucher']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                  SizedBox(height: 20),
                  Text('${data[i]['deskripsi']}'),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detailpage(
                                  data: data[i],
                                )),
                      );
                    },
                    color: Colors.blue,
                    child: Text('Beli Voucher'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
