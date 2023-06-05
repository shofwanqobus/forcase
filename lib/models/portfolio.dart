class Portfolio {
  late int id;
  late String judul;
  late String nama;
  late String rating;
  late String suka;
  late String deskripsiPendek;
  late String deksripsiPanjang;
  late String jenis;
  late String framework;
  late String review;
  late String images;
  late String pengerjaan;
  late String rilis;
  late String status;
  late String harga;

  Portfolio(
    this.id,
    this.judul,
    this.nama,
    this.rating,
    this.suka,
    this.deskripsiPendek,
    this.deksripsiPanjang,
    this.jenis,
    this.framework,
    this.review,
    this.images,
    this.pengerjaan,
    this.rilis,
    this.status,
    this.harga,
  );

  Portfolio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    nama = json['nama'];
    rating = json['rating'];
    suka = json['suka'];
    deskripsiPendek = json['deskripsi_pendek'];
    deksripsiPanjang = json['deskripsi_panjang'];
    jenis = json['jenis'];
    framework = json['framework'];
    review = json['review'];
    images = json['images'];
    pengerjaan = json['pengerjaan'];
    rilis = json['rilis'];
    status = json['status'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "judul": judul,
        "nama": nama,
        "rating": rating,
        "suka": suka,
        "deskripsi_pendek": deskripsiPendek,
        "deskripsi_panjang": deksripsiPanjang,
        "jenis": jenis,
        "framework": framework,
        "review": review,
        "images": images,
        "pengerjaan": pengerjaan,
        "rilis": rilis,
        "status": status,
        "harga": harga,
      };
}
