class Language {
 int? personId;
 int? id;
 String? name;
 int? proficiency;

  Language({
    this.personId,
    this.id,
    this.name,
    this.proficiency,
  });

  Map<String, dynamic> toMap() {
    return {
      "personId": personId,
      "id": id,
      "name": name,
      "proficiency": proficiency,
    };
  }
}
