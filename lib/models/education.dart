class Education {
  int? id;
  int? personId;
  String? years;
  String? school;
  String? faculty;
  String? department;
  String? grade;
  String? notes;

  Education({
    this.id,
    this.personId,
    this.years,
    this.school,
    this.faculty,
    this.department,
    this.grade,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "personId": personId,
      "years": years,
      "school": school,
      "faculty": faculty,
      "department": department,
      "grade": grade,
      "notes": notes,
    };
  }
}
