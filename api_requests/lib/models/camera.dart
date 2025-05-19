class Camera {
  int? id;
  String? name;
  int? roverId;
  String? fullName;

  Camera({this.id, this.name, this.roverId, this.fullName});

  Camera.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    roverId = json['rover_id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rover_id'] = this.roverId;
    data['full_name'] = this.fullName;
    return data;
  }
}