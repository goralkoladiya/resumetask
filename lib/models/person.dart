class Person {
  int? id;
  String? title;
  String? firstName;
  String? surname;
  String? aboutMe;
  String? dob;
  String? nationality;
  String? country;
  String? city;
  String? creationDateTime;
  String? phone;
  String? email;
  String? address;
  String? linkedin;
  String? facebook;
  String? github;

  Person({
    this.id,
    this.title,
    this.firstName,
    this.surname,
    this.aboutMe,
    this.dob,
    this.nationality,
    this.country,
    this.city,
    this.creationDateTime,
    this.phone,
    this.email,
    this.address,
    this.linkedin,
    this.facebook,
    this.github,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "firstName": firstName,
      "surname": surname,
      "aboutMe": aboutMe,
      "dob": dob,
      "nationality": nationality,
      "country": country,
      "city": city,
      "creationDateTime": creationDateTime,
      "phone": phone,
      "email": email,
      "address": address,
      "linkedin": linkedin,
      "facebook": facebook,
      "github": github,
    };
  }
}
