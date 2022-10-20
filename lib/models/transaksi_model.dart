class TransaksiModel {
  /*
  tipe
  1 -> pemasukan
  2 -> pengeluaran
  */
  int? id, type, total;
  String? name, createdAt, updatedAt, judul, tglawl, tglakhr;

  TransaksiModel(
      {this.id,
      this.name,
      this.judul,
      this.type,
      this.total,
      this.tglawl,
      this.tglakhr,
      this.createdAt,
      this.updatedAt});

  factory TransaksiModel.fromJson(Map<String, dynamic> json) {
    return TransaksiModel(
        id: json['id'],
        name: json['name'],
        judul: json['judul_buku'],
        type: json['type'],
        total: json['total'],
        tglawl: json['tgl_awl'],
        tglakhr: json['tgl_akhr'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
