class Keuangan {
  final int? id;
  final int? value;
  final String? portofolio;
  final String? investment;

  Keuangan({this.id, this.value, this.portofolio, this.investment});

  factory Keuangan.fromJson(Map<String, dynamic> json) {
    return Keuangan(
      id: json['id'],
      value: json['value'],
      portofolio: json['portofolio'],
      investment: json['investment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'portofolio': portofolio,
      'investment': investment,
    };
  }
}
