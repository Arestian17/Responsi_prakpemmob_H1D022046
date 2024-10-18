Nama: Mochamad Azizan
NIM: H1D022046
Shift baru: D


Source code:
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


Penjelasan source code:

Tentu, saya akan memberikan penjelasan lengkap untuk source code yang Anda berikan:

1. Impor dan Deklarasi:
   - Kode ini mengimpor paket Flutter, model Keuangan, http untuk request API, dan helpers untuk URL API.
   - `KeuanganForm` adalah StatefulWidget yang bisa menerima objek Keuangan opsional.

2. State Class (`_KeuanganFormState`):
   - Menggunakan `GlobalKey<FormState>` untuk validasi form.
   - Menyiapkan controller untuk setiap input field.
   - Variabel `judul` dan `tombolSubmit` digunakan untuk mengatur tampilan form.

3. Inisialisasi State:
   - `initState()` memanggil `isUpdate()` untuk memeriksa apakah ini form untuk update atau create baru.
   - `isUpdate()` mengecek apakah ada objek Keuangan yang diberikan. Jika ada, form diatur untuk mode update.

4. Membangun UI (metode `build`):
   - Menggunakan Scaffold dengan AppBar yang menampilkan judul.
   - Form dibungkus dalam SingleChildScrollView untuk menghindari overflow saat keyboard muncul.
   - Form berisi tiga TextFormField (investment, value, portofolio) dan satu tombol submit.

5. Widget Input:
   - `_investmentTextField()`: Input untuk investment (tipe String).
   - `_valueTextField()`: Input untuk value (tipe number).
   - `_portofolioTextField()`: Input untuk portofolio (tipe String).
   - Setiap field memiliki validasi dasar untuk memastikan tidak kosong.

6. Tombol Submit:
   - `_buttonSubmit()` membuat OutlinedButton yang memanggil `_saveKeuangan()` jika form valid.

7. Menyimpan Data:
   - `_saveKeuangan()` membuat objek Keuangan baru dari input form.
   - Menggunakan http.post untuk mengirim data ke server dalam format JSON.
   - Jika berhasil, menampilkan SnackBar dan kembali ke layar sebelumnya.
   - Jika gagal, menampilkan pesan error.

8. Penanganan Error:
   - Menggunakan try-catch untuk menangani error saat melakukan request ke server.
   - Menampilkan pesan error menggunakan SnackBar jika terjadi kesalahan.

9. Navigasi:
   - Menggunakan `Navigator.pop()` untuk kembali ke layar sebelumnya setelah berhasil menyimpan data.

Kekurangan dan Potensi Perbaikan:
1. Tidak ada implementasi untuk operasi Read dan Delete.
2. Logika update belum sepenuhnya diimplementasikan (hanya persiapan UI).
3. Tidak ada penanganan loading state saat melakukan request ke server.
4. Validasi input bisa ditingkatkan, misalnya memastikan value adalah angka valid.
5. Bisa ditambahkan konfirmasi sebelum menyimpan atau mengubah data.
6. Penanganan error bisa lebih spesifik, misalnya membedakan antara error jaringan dan error server.

Secara keseluruhan, kode ini menyediakan dasar yang baik untuk form pembuatan/pengubahan data keuangan, namun masih memerlukan beberapa penyempurnaan untuk menjadi implementasi CRUD yang lengkap dan robust.
 
 
 
 
 
 
 ![image](https://github.com/user-attachments/assets/dab2d3a6-ce3a-495a-9d12-f24645b18718)
![image](https://github.com/user-attachments/assets/b53138af-a87d-463e-bb5d-dba6d47ebb86)
![image](https://github.com/user-attachments/assets/dec728d3-f12f-4098-89af-187bbef6e1e4)
![image](https://github.com/user-attachments/assets/7323cdf8-294c-4d41-85ad-929932b4e333)

 
