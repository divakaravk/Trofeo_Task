class Route_data {
  final String route_Name;
  final dynamic route_Code;
  final int status;
  final dynamic route_Id;

  Route_data(
      {required this.route_Name,
      required this.route_Code,
      required this.status,
      required this.route_Id});

  factory Route_data.fromJson(Map<String, dynamic> json) {
    return Route_data(
      route_Name: json['route_name'],
      route_Code: json['route_code'],
      status: json['status'],
      route_Id: json['_id'],
    );
  }
}
