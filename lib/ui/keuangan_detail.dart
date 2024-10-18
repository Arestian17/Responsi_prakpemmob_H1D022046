import 'package:flutter/material.dart';
import '../model/keuangan.dart';
import 'keuangan_form.dart';

class KeuanganDetail extends StatefulWidget {
  final Keuangan keuangan;

  const KeuanganDetail({Key? key, required this.keuangan}) : super(key: key);

  @override
  _KeuanganDetailState createState() => _KeuanganDetailState();
}

class _KeuanganDetailState extends State<KeuanganDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.keuangan.value?.toString() ?? ''),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KeuanganForm(
                    keuangan: widget.keuangan, // Mengirim data keuangan untuk diedit
                  ),
                ),
              ).then((_) {
                // Refresh state setelah kembali dari halaman form
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Investment: ${widget.keuangan.investment ?? ''}'),
            Text('Value: ${widget.keuangan.value ?? ''}'),
            Text('Portofolio: ${widget.keuangan.portofolio?.toString() ?? ''}'),
          ],
        ),
      ),
    );
  }
}
