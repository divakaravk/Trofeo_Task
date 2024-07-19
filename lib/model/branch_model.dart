class Branch_Data {
  final dynamic branch_Id;
  final String branch_Name;
  final dynamic branch_Code;
  num branch_mob_Num;
  final int branch_Pincode;

  Branch_Data(
      {required this.branch_Id,
      required this.branch_Name,
      required this.branch_Code,
      required this.branch_mob_Num,
      required this.branch_Pincode});

  factory Branch_Data.fromJson(Map<String, dynamic> json) {
    return Branch_Data(
        branch_Id: json['_id'],
        branch_Name: json['branch_name'],
        branch_Code: json['branch_code'],
        branch_mob_Num: json['mobile_no'],
        branch_Pincode: json['pincode']);
  }
}
