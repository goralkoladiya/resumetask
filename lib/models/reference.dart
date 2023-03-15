class Reference {
  int? personId;
  int? id;
  String? fullName;
  String? workPlace;
  String? designation;
  String? email;
  String? phone;

  Reference({
    this.personId,
    this.id,
    this.fullName,
    this.workPlace,
    this.designation,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      "personId": personId,
      "id": id,
      "fullName": fullName,
      "workPlace": workPlace,
      "designation": designation,
      "email": email,
      "phone": phone,
    };
  }
}
