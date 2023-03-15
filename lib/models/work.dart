class Work {
  int? personId;
  int? id;
  String? jobTitle;
  String? company;
  String? department;
  String? years;
  String? notes;

  Work({
    this.personId,
    this.id,
    this.jobTitle,
    this.company,
    this.department,
    this.years,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      "personId": personId,
      "id": id,
      "jobTitle": jobTitle,
      "company": company,
      "department": department,
      "years": years,
      "notes": notes,
    };
  }
}
