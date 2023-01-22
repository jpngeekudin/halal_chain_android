class UmkmDocPembelian {
  UmkmDocPembelian({
    required this.id,
    required this.docId,
    required this.data,
  });

  String id;
  String docId;
  List<UmkmDocPembelianData> data;

  factory UmkmDocPembelian.fromJson(Map<String, dynamic> json) => UmkmDocPembelian(
    id: json["_id"],
    docId: json["doc_id"],
    data: List<UmkmDocPembelianData>.from(json["data"].map((x) => UmkmDocPembelianData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "doc_id": docId,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UmkmDocPembelianData {
  UmkmDocPembelianData({
    required this.tanggal,
    required this.namaDanMerk,
    required this.namaDanNegara,
    required this.halal,
    required this.expBahan,
    required this.noSertifikat,
    required this.strukPembelian,
    required this.paraf,
  });

  String tanggal;
  String namaDanMerk;
  String namaDanNegara;
  String halal;
  String expBahan;
  String? noSertifikat;
  String? strukPembelian;
  String paraf;

  factory UmkmDocPembelianData.fromJson(Map<String, dynamic> json) => UmkmDocPembelianData(
    tanggal: json["Tanggal"],
    namaDanMerk: json["nama_dan_merk"],
    namaDanNegara: json["nama_dan_negara"],
    halal: json["halal"],
    expBahan: json["exp_bahan"],
    noSertifikat: json["no_sertifikat"],
    strukPembelian: json["struk_pembelian"],
    paraf: json["paraf"],
  );

  Map<String, dynamic> toJson() => {
    "Tanggal": tanggal,
    "nama_dan_merk": namaDanMerk,
    "nama_dan_negara": namaDanNegara,
    "halal": halal,
    "exp_bahan": expBahan,
    "no_sertifikat": noSertifikat,
    "struk_pembelian": strukPembelian,
    "paraf": paraf,
  };
}

class UmkmDocProduksi {
  UmkmDocProduksi({
    required this.id,
    required this.docId,
    required this.data,
  });

  String id;
  String docId;
  List<UmkmDocProduksiData> data;

  factory UmkmDocProduksi.fromJson(Map<String, dynamic> json) => UmkmDocProduksi(
    id: json["_id"],
    docId: json["doc_id"],
    data: List<UmkmDocProduksiData>.from(json["data"].map((x) => UmkmDocProduksiData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "doc_id": docId,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UmkmDocProduksiData {
  UmkmDocProduksiData({
    required this.tanggalProduksi,
    required this.namaProduk,
    required this.jumlahAwal,
    required this.jumlahProdukKeluar,
    required this.sisaStok,
    required this.paraf,
  });

  DateTime tanggalProduksi;
  String namaProduk;
  String jumlahAwal;
  String jumlahProdukKeluar;
  String sisaStok;
  String? paraf;

  factory UmkmDocProduksiData.fromJson(Map<String, dynamic> json) => UmkmDocProduksiData(
    tanggalProduksi: DateTime.fromMillisecondsSinceEpoch(int.parse(json["tanggal_produksi"])),
    namaProduk: json["nama_produk"],
    jumlahAwal: json["jumlah_awal"] ?? '0',
    jumlahProdukKeluar: json["jumlah_produk_keluar"] ?? '0',
    sisaStok: json["sisa_stok"] ?? '0',
    paraf: json["paraf"],
  );

  Map<String, dynamic> toJson() => {
    "tanggal_produksi": tanggalProduksi.millisecondsSinceEpoch,
    "nama_produk": namaProduk,
    "jumlah_awal": jumlahAwal,
    "jumlah_produk_keluar": jumlahProdukKeluar,
    "sisa_stok": sisaStok,
    "paraf": paraf,
  };
}