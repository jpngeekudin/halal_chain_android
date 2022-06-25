import 'package:flutter/material.dart';
import 'package:halal_chain/helpers/date_helper.dart';
import 'package:halal_chain/helpers/form_helper.dart';
import 'package:halal_chain/models/umkm_model.dart';
import 'package:logger/logger.dart';

class UmkmDaftarHadirKajiPage extends StatefulWidget {
  const UmkmDaftarHadirKajiPage({ Key? key }) : super(key: key);

  @override
  State<UmkmDaftarHadirKajiPage> createState() => _UmkmDaftarHadirKajiPageState();
}

class _UmkmDaftarHadirKajiPageState extends State<UmkmDaftarHadirKajiPage> {

  final _tanggalController = TextEditingController();
  DateTime? _tanggalModel;

  final _namaController = TextEditingController();
  final _jabatanController = TextEditingController();
  final _parafController = TextEditingController();

  final _pembahasanController = TextEditingController();
  final _perbaikanController = TextEditingController();

  List<UmkmDaftarHadirKaji> _daftarHadir = [];
  List<UmkmDaftarHadirKajiPembahasan> _daftarPembahasan = [];

  final _titleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  Widget _getHadirItem(UmkmDaftarHadirKaji kehadiran) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(kehadiran.nama, style: TextStyle(
                  fontWeight: FontWeight.bold
                )),
                SizedBox(height: 5),
                Text(kehadiran.jabatan, style: TextStyle(
                  color: Colors.grey[600]
                ))
              ],
            ),
          ),
          InkWell(
            onTap: () => _removeKehadiran(kehadiran),
            child: Icon(Icons.remove, color: Colors.red),
          )
        ],
      )
    );
  }

  Widget _getTablePembahsan(List<UmkmDaftarHadirKajiPembahasan> daftarPembahasan) {
    Widget getTableCell(Widget content) {
      return TableCell(
        child: Container(
          padding: EdgeInsets.all(10),
          child: content
        ),
      );
    }

    return Table(
      border: TableBorder.all(
        color: Theme.of(context).dividerColor
      ),
      columnWidths: {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FixedColumnWidth(42)
      },
      children: [
        TableRow(
          children: [
            getTableCell(
              Text('Pembahasan', style: TextStyle(
                fontWeight: FontWeight.bold
              ))
            ),
            getTableCell(
              Text('Perbaikan', style: TextStyle(
                fontWeight: FontWeight.bold
              ))
            ),
            getTableCell(
              Icon(Icons.more_horiz)
            ),
          ]
        ),
        ..._daftarPembahasan.map((pembahasan) {
          return TableRow(
            children: [
              getTableCell(
                Text(pembahasan.pembahasan)
              ),
              getTableCell(
                Text(pembahasan.perbaikan)
              ),
              getTableCell(
                InkWell(
                  onTap: () => _removePembahasan(pembahasan),
                  child: Icon(Icons.remove, color: Colors.red)
                )
              ),
            ]
          );
        })
      ],
    );
  }

  void _addKehadiran() {
    if (
      _namaController.text.isEmpty ||
      _jabatanController.text.isEmpty
    ) {
      final snackBar = SnackBar(content: Text('Harap isi semua field yang dibutuhkan.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final kehadiran = UmkmDaftarHadirKaji(_namaController.text, _jabatanController.text, '');
    setState(() => _daftarHadir.add(kehadiran));

    _namaController.text = '';
    _jabatanController.text = '';
    _parafController.text = '';
  }

  void _removeKehadiran(UmkmDaftarHadirKaji kehadiran) {
    setState(() => _daftarHadir.remove(kehadiran));
  }

  void _addPembahasan() {
    if (
      _pembahasanController.text.isEmpty ||
      _perbaikanController.text.isEmpty
    ) {
      final snackBar = SnackBar(content: Text('Harap isi semua field yang dibutuhkan.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final pembahasan = UmkmDaftarHadirKajiPembahasan(_pembahasanController.text, _perbaikanController.text);
    setState(() => _daftarPembahasan.add(pembahasan));
    
    _pembahasanController.text = '';
    _perbaikanController.text = '';
  }

  void _removePembahasan(UmkmDaftarHadirKajiPembahasan pembahasan) {
    setState(() => _daftarPembahasan.remove(pembahasan));
  }

  void _submit() async {
    String? error;
    if (_daftarPembahasan.isEmpty) error = 'Harap isi pembahasan';
    if (_daftarHadir.isEmpty) error = 'Harap isi daftar hadir!';
    if (_tanggalModel == null) error = 'Harap isi tanggal!';

    if (error != null) {
      final snackBar = SnackBar(content: Text(error));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    final params = {
      'id': '',
      'tanggal': _tanggalModel?.millisecondsSinceEpoch,
      'list_orang': _daftarHadir.map((hadir) => {
        'nama': hadir.nama,
        'jabatan': hadir.jabatan,
        'paraf': hadir.paraf
      }).toList(),
      'pembahasan': _daftarPembahasan.map((pembahasan) => {
        'pembahasan': pembahasan.pembahasan,
        'perbaikan': pembahasan.perbaikan
      }).toList()
    };

    final logger = Logger();
    logger.i(params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Hadir Kaji'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getInputWrapper(
                  label: 'Tanggal',
                  input: TextFormField(
                    controller: _tanggalController,
                    decoration: getInputDecoration(label: 'Tanggal'),
                    style: inputTextStyle,
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _tanggalController.text.isNotEmpty
                          ? defaultDateFormat.parse(_tanggalController.text)
                          : DateTime.now(),
                        firstDate: DateTime(2016),
                        lastDate: DateTime(2100),
                      );

                      if (picked != null) {
                        setState(() => _tanggalModel = picked);
                        _tanggalController.text = defaultDateFormat.format(picked);
                      }
                    },
                  ),
                ),
                SizedBox(height: 30),

                Text('Daftar Hadir', style: _titleTextStyle),
                SizedBox(height: 10),
                if (_daftarHadir.isEmpty) Text('Belum ada daftar hadir')
                else ..._daftarHadir.map((hadir) => _getHadirItem(hadir)),
                SizedBox(height: 30),

                Text('Tambah Kehadiran', style: _titleTextStyle),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: getInputWrapper(
                        label: 'Nama',
                        input: TextField(
                          controller: _namaController,
                          decoration: getInputDecoration(label: 'Nama'),
                          style: inputTextStyle,
                        )
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: getInputWrapper(
                        label: 'Jabatan',
                        input: TextField(
                          controller: _jabatanController,
                          decoration: getInputDecoration(label: 'Jabatan'),
                          style: inputTextStyle,
                        )
                      ),
                    )
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.person_add, color: Colors.black),
                          SizedBox(width: 10),
                          Text('Tambah', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      onPressed: () => _addKehadiran(),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[200],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),

                Text('Daftar Pembahasan', style: _titleTextStyle),
                SizedBox(height: 10),
                if (_daftarPembahasan.isEmpty) Text('Belum ada pembahasan')
                else _getTablePembahsan(_daftarPembahasan),
                SizedBox(height: 30),

                Text('Tambah Pembahasan', style: _titleTextStyle),
                SizedBox(height: 10),
                getInputWrapper(
                  label: 'Pembahasan',
                  input: TextField(
                    controller: _pembahasanController,
                    decoration: getInputDecoration(label: 'Pembahasan'),
                    style: inputTextStyle,
                  )
                ),
                getInputWrapper(
                  label: 'Perbaikan',
                  input: TextField(
                    controller: _perbaikanController,
                    decoration: getInputDecoration(label: 'Perbaikan'),
                    style: inputTextStyle,
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.add_box, color: Colors.black),
                          SizedBox(width: 10),
                          Text('Tambah', style: TextStyle(
                            color: Colors.black
                          ))
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[200]
                      ),
                      onPressed: () => _addPembahasan(),
                    )
                  ],
                ),
                SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () => _submit(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}