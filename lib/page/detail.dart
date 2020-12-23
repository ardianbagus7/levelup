import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Detailpage extends StatefulWidget {
  Detailpage({
    Key key,
    this.data,
  }) : super(key: key);

  final data;

  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController nomerhpController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController idnicknameController = TextEditingController();

  void kirim() async {
    String url = "http://192.168.1.2/android/api.php";

    Map<String, dynamic> body = {
      'nama': namaController.text.toString(),
      'nomerhp': nomerhpController.text.toString(),
      'nickname': nicknameController.text.toString(),
      'idnickname': idnicknameController.text.toString(),
    };

    final response = await http.post(url, body: body);
    print(response.body);
    bool status = json.decode(response.body)['status'];
    if(status){
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail VoucherGame'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.data['foto']),
              SizedBox(height: 20),
              Text(
                'Pesan ${widget.data['namavoucher']}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SizedBox(height: 10),
              TextField(
                controller: namaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Lengkap',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nomerhpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nomor HP',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: nicknameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nickname In - Game',
                ),
              ),
                SizedBox(height: 10),
              TextField(
                controller: idnicknameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nomer ID In - Game',
                ),
              ),
              
              SizedBox(height: 10),
              RaisedButton(
                    onPressed: kirim,
                    color: Colors.blue,
                    child: Text('Beli Sekarang!'),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
