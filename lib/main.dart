import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: BApp()));

class BApp extends StatefulWidget {
  const BApp({super.key});
  @override
  State<BApp> createState() => _BAppState();
}

class _BAppState extends State<BApp> {
  String q = '';
  final b = [
    {
      'j': 'Laskar Pelangi',
      'p': 'Aliyah Tasya',
      't': 2005,
      'r': 4.8,
      'a': true,
      'g': 'Novel',
    },
    {
      'j': 'Laskar Cinta',
      'p': 'Tasya farasya',
      't': 2007,
      'r': 4.5,
      'a': false,
      'g': 'Novel',
    },
    {
      'j': 'Hujan Rintik',
      'p': 'lia miaw',
      't': 1999,
      'r': 4.8,
      'a': true,
      'g': 'Fiksi',
    },
    {
      'j': 'Laut Bercerita',
      'p': 'Rasya Li',
      't': 1985,
      'r': 4.3,
      'a': true,
      'g': 'Non Fiksi',
    },
    {
      'j': 'Lihat Aku',
      'p': 'iyah ria',
      't': 2010,
      'r': 4.8,
      'a': true,
      'g': 'Novel',
    },
    {
      'j': 'Pemrograman mobile',
      'p': 'Yasir',
      't': 2013,
      'r': 4.8,
      'a': true,
      'g': 'Sains',
    },
  ];

  // Fungsi KategoriRating
  String kat(double r) =>
      r >= 4.8 ? 'Sangat Baik' : (r >= 3.5 ? 'Baik' : 'Cukup');
  Set<String> get gen => b.map((x) => x['g'] as String).toSet();

  @override
  
  Widget build(BuildContext context) {
    
    // Filter .where()
    final l = b .where((x) => x['j'].toString().toLowerCase().contains(q.toLowerCase())).toList();

    return Scaffold(appBar: AppBar(title: const Text('Katalog Buku')),
    body: Column(children: [
      TextField(onChanged: (v) => setState(() => q = v), decoration: const InputDecoration(hintText: 'Cari...')),
      Wrap(children: gen.map((g) => Chip(label: Text(g))).toList()),
        Expanded(
          child: ListView.builder(
            itemCount: l.length,
            itemBuilder: (_, i) => Card(
              child: ListTile(
                title: Text('${l[i]['j']} (${l[i]['r']})'),
                subtitle: Text('${l[i]['p']} • ${kat(l[i]['r'] as double)}'),
                // 4. Ternary badge
                trailing: Text(l[i]['a'] == true ? 'Tersedia' : 'Dipinjam', style: TextStyle(color: l[i]['a'] == true ? Colors.green : Colors.red)),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DPage(x: l[i]))),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

// 5. Detail (StatefulWidget) + Nullable String? & Operator ??
class DPage extends StatefulWidget {
  final Map<String, dynamic> x;
  const DPage({super.key, required this.x});
  @override
  State<DPage> createState() => _DPageState();
}

class _DPageState extends State<DPage> {
  String? c; // Nullable String?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.x['j'] as String)),
      body: Center(
        child: Column(children: [
          Text('Tahun: ${widget.x['t']} | Rating: ${widget.x['r']}'),
          // Operator ??
          Text('Catatan: ${c ?? "(Tidak ada catatan)"}'),
          ElevatedButton(onPressed: () => setState(() => c = 'Dipinjam'), child: const Text('Tambah Catatan')),
        ]),
      ),
    );
  }
}


   
    