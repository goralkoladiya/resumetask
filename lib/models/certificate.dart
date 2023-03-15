class Certificate {
  int? personId;
  int? id;
  String? name;
  String? issuedBy;
  String? date;

  Certificate({
    this.personId,
    this.id,
    this.name,
    this.issuedBy,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "personId": personId,
      "id": id,
      "name": name,
      "issuedBy": issuedBy,
      "date": date,
    };
  }
}
