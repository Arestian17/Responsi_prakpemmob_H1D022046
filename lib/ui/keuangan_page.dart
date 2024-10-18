import 'package:flutter/material.dart';
import 'package:untitled/bloc/keuangan_bloc.dart';
import 'package:untitled/bloc/logout_bloc.dart';
import 'package:untitled/model/keuangan.dart';
import 'package:untitled/ui/keuangan_form.dart';
import 'package:untitled/ui/login_page.dart';

class KeuanganPage extends StatefulWidget {
  const KeuanganPage({Key? key}) : super(key: key);

  @override
  _KeuanganPageState createState() => _KeuanganPageState();
}

class _KeuanganPageState extends State<KeuanganPage> {
  late Future<List<Keuangan>> _keuanganFuture;

  @override
  void initState() {
    super.initState();
    _refreshKeuanganList();
  }

  void _refreshKeuanganList() {
    setState(() {
      _keuanganFuture = KeuanganBloc.getKeuangans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Keuangan'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Keuangan>>(
        future: KeuanganBloc.getKeuangans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}\n\n'
                'Detail: ${snapshot.error.toString()}',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data keuangan.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Keuangan keuangan = snapshot.data![index];
                return ListTile(
                  title: Text(keuangan.portofolio ?? ''),
                  subtitle: Text('Investasi: ${keuangan.investment ?? ''}'),
                  trailing: Text('Rp ${keuangan.value?.toString() ?? '0'}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KeuanganForm()),
          );
          if (result == true) {
            _refreshKeuanganList();
          }
        },
      ),
    );
  }

  void _logout(BuildContext context) async {
    await LogoutBloc.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}

class ListKeuangan extends StatelessWidget {
  final List<Keuangan>? list;

  const ListKeuangan({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemKeuangan(
          keuangan: list![i],
        );
      },
    );
  }
}

class ItemKeuangan extends StatelessWidget {
  final Keuangan keuangan;

  const ItemKeuangan({Key? key, required this.keuangan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KeuanganForm(
              keuangan: keuangan,
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(keuangan.value?.toString() ?? ''),  // Ubah ke toString() karena value adalah int
          subtitle: Text(keuangan.portofolio ?? ''),      // Tidak perlu toString() karena portofolio adalah String
          trailing: Text(keuangan.investment ?? ''),      // Tidak ada perubahan
        ),
      ),
    );
  }
}
