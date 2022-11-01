class CandidateDataModel {
  String? name;
  String? id;
  String? atype;

  CandidateDataModel({
    this.name,
    this.id,
    this.atype,
  });

  CandidateDataModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
    atype = json["atype"];
  }

  static fromJSON(e) {}
}
