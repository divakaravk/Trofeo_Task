// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable

class Customer {
  final String name;
  final mobilenumber;
  final int opening_Bal;
  final category_name;
  final String branch_name;
  final String route_name;
  final List<PendingAssetInfo> pending_asset_info;

  Customer({
    required this.name,
    required this.mobilenumber,
    required this.opening_Bal,
    required this.category_name,
    required this.branch_name,
    required this.route_name,
    required this.pending_asset_info,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    var pendingAssets = json['pending_asset_info'] as List;
    List<PendingAssetInfo> pendingAssetInfoList =
        pendingAssets.map((i) => PendingAssetInfo.fromJson(i)).toList();
    return Customer(
      name: json['name'],
      mobilenumber: json['mobile_no'],
      opening_Bal: json['opening_balance'],
      category_name: json['category_name'],
      branch_name: json['branch_name'],
      route_name: json['route_name'],
      pending_asset_info: pendingAssetInfoList,
    );
  }
}

class PendingAssetInfo {
  final String assetCode;
  final int assetsStatus;

  PendingAssetInfo({
    required this.assetCode,
    required this.assetsStatus,
  });

  factory PendingAssetInfo.fromJson(Map<String, dynamic> json) {
    return PendingAssetInfo(
      assetCode: json['asset_code'],
      assetsStatus: json['assets_status'],
    );
  }
}
