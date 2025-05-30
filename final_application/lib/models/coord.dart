class Coord {
  double? lat;
  double? lon;

  Coord({this.lat, this.lon});

   Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toDouble(); // Convert to double if not null
    lon = json['lon']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}