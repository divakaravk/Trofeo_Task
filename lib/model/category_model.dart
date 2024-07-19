// ignore_for_file: non_constant_identifier_names

class Category_Data {
  final String category_Name;
  final dynamic category_Id;
  final int category_Status;

  Category_Data(
      {required this.category_Name,
      required this.category_Status,
      required this.category_Id});

  factory Category_Data.fromJson(Map<String, dynamic> json) {
    return Category_Data(
        category_Name: json['category_name'],
        category_Status: json['status'],
        category_Id: json['_id']);
  }
}
