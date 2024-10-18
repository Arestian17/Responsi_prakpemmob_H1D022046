import 'package:flutter/material.dart';
import '/model/keuangan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/helpers/api_url.dart';

// ignore: must_be_immutable
class KeuanganForm extends StatefulWidget {
  Keuangan? keuangan;

  KeuanganForm({Key? key, this.keuangan}) : super(key: key);

  @override
  _KeuanganFormState createState() => _KeuanganFormState();
}

class _KeuanganFormState extends State<KeuanganForm> {
  final _formKey = GlobalKey<FormState>();
  String judul = "TAMBAH KEUANGAN";
  String tombolSubmit = "SIMPAN";

  final _investmentTextboxController = TextEditingController();
  final _valueTextboxController = TextEditingController();
  final _portofolioTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.keuangan != null) {
      judul = "UBAH KEUANGAN";
      tombolSubmit = "UBAH";
      _investmentTextboxController.text = widget.keuangan!.investment ?? '';
      _valueTextboxController.text = widget.keuangan!.value?.toString() ?? '';
      _portofolioTextboxController.text = widget.keuangan!.portofolio ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _investmentTextField(),
                _valueTextField(),
                _portofolioTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Investment
  Widget _investmentTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Investment"),
      keyboardType: TextInputType.text,  // Ubah ke text karena investment adalah String
      controller: _investmentTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Investment harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Value
  Widget _valueTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Value"),  // Ubah label
      keyboardType: TextInputType.number,  // Ubah ke number karena value adalah int
      controller: _valueTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Value harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Portofolio
  Widget _portofolioTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Portofolio"),
      keyboardType: TextInputType.text,  // Ubah ke text karena portofolio adalah String
      controller: _portofolioTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Portofolio harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Tambahkan logika untuk menyimpan data di sini
          _saveKeuangan();
        }
      },
    );
  }

  void _saveKeuangan() async {
    Keuangan keuangan = Keuangan(
      investment: _investmentTextboxController.text,
      value: int.tryParse(_valueTextboxController.text) ?? 0,
      portofolio: _portofolioTextboxController.text,
    );

    try {
      var response = await http.post(
        Uri.parse(ApiUrl.createKeuangan),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(keuangan.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data keuangan berhasil disimpan')),
        );
        Navigator.pop(context, true);  // Tambahkan true sebagai hasil
      } else {
        throw Exception('Failed to save keuangan: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
