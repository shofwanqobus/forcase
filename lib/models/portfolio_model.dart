class PortfolioModel {
  List<PortfolioItems> portfolioItems;

  PortfolioModel({required this.portfolioItems});

  factory PortfolioModel.fromJson(Map<String, dynamic> portfolio) =>
      PortfolioModel(
          portfolioItems: List<PortfolioItems>.from(
        (portfolio["application"] as List)
            .map((x) => PortfolioItems.fromJson(x))
            .where(
              (portfolioItems) => portfolioItems.images != null,
            ),
      ));
}

class PortfolioItems {
  int id;
  String judul;
  String nama;
  String rating;
  String suka;
  String deskripsiPendek;
  String deksripsiPanjang;
  String jenis;
  String framework;
  String review;
  String? images;
  String pengerjaan;
  String rilis;
  String status;
  String harga;

  PortfolioItems({
    required this.id,
    required this.judul,
    required this.nama,
    required this.rating,
    required this.suka,
    required this.deskripsiPendek,
    required this.deksripsiPanjang,
    required this.jenis,
    required this.framework,
    required this.review,
    required this.images,
    required this.pengerjaan,
    required this.rilis,
    required this.status,
    required this.harga,
  });

  factory PortfolioItems.fromJson(Map<String, dynamic> json) => PortfolioItems(
        id: json["id"],
        judul: json["judul"],
        nama: json["nama"],
        rating: json["rating"],
        suka: json["suka"],
        deskripsiPendek: json["deskripsi_pendek"],
        deksripsiPanjang: json["deskripsi_panjang"],
        jenis: json["jenis"],
        framework: json["framework"],
        review: json["review"],
        images: json["images"],
        pengerjaan: json["pengerjaan"],
        rilis: json["rilis"],
        status: json["status"],
        harga: json["harga"],
      );

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
