// ignore_for_file: prefer_const_declarations, prefer_const_constructors, unused_local_variable, unnecessary_null_comparison, curly_braces_in_flow_control_structures, unused_element, non_constant_identifier_names, use_key_in_widget_constructors, library_private_types_in_public_api, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, dead_code

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trofeo/model/bottom_model.dart';
import 'dart:convert';
import 'package:trofeo/pages/branch_screen2.dart';
import 'package:trofeo/pages/category_screen.dart';
import 'package:trofeo/pages/route_Screen.dart';
import '../model/class_model.dart';

class CustomerListScreen extends StatefulWidget {
  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  Customer? customer;
  List<Customer> cusList = [];
  dynamic? selected_routeId;
  dynamic? selected_BranchId;
  dynamic? selected_Category_Id;
  Color icon_color = Colors.blueGrey;
  dynamic? routeLabel = "";
  dynamic? routeName = "";
  dynamic? branchLabel = "";
  dynamic? branchName = "";
  dynamic? categoryLabel = "";
  dynamic? categoryName = "";

  @override
  void initState() {
    super.initState();
    fetchCustomerData(
        selected_routeId, selected_BranchId, selected_Category_Id);
  }

  void onselectedRouteName(
    dynamic? route_Name,
  ) {
    setState(() {
      routeLabel = "Route";
      routeName = route_Name;
      branchLabel = "Branch";
      categoryLabel = "Category";
    });
  }

  void onselectedBranchName(dynamic? branch_Name) {
    setState(() {
      branchLabel = "Branch";
      branchName = branch_Name;
      routeLabel = "Route";
      categoryLabel = "Category";
    });
  }

  void onselectedCategoryName(dynamic? category_Name) {
    setState(() {
      categoryLabel = "Category";
      categoryName = category_Name;
      branchLabel = "Branch";
      routeLabel = "Route";
    });
  }

  void onselectedRouteId(dynamic? route_Id) {
    setState(() {
      selected_routeId = route_Id;
    });
    fetchCustomerData(
        selected_routeId, selected_BranchId, selected_Category_Id);
  }

  void onSelectedBranchId(dynamic? branch_Id) {
    setState(() {
      selected_BranchId = branch_Id;
    });
    fetchCustomerData(
        selected_routeId, selected_BranchId, selected_Category_Id);
  }

  void onSelectedCategoryId(dynamic? category_Id) {
    setState(() {
      selected_Category_Id = category_Id;
    });
    fetchCustomerData(
        selected_routeId, selected_BranchId, selected_Category_Id);
  }

  Future displayBottomSheet(
    BuildContext context,
    Customer value,
  ) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 600,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(22),
                  topLeft: Radius.circular(22),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: icon_color,
                                size: 26,
                              ),
                              SizedBox(width: 5),
                              Text(value.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[400]),
                              child: Icon(
                                Icons.close,
                                color: Colors.grey[800],
                              ))
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Pending Asset Info",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: value.pending_asset_info.length,
                          itemBuilder: (context, index) {
                            var assetInfo = value.pending_asset_info[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: ListTile(
                                      title: Text(
                                        assetInfo.assetCode,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[700]),
                                      ),
                                      subtitle: Text(
                                        assetInfo.assetsStatus.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700]),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0),
                                  child: Divider(),
                                ),
                              ],
                            );
                          })),
                ],
              ),
            ));
  }

  Future<void> fetchCustomerData(
      dynamic route_Id, dynamic branch_Id, dynamic category_Id) async {
    cusList.clear();
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndlYkBnbWFpbC5jb20iLCJyb2xlIjoic3VwZXJhZG1pbiIsIl9pZCI6IjY2MWNlM2JkNTIzZTUzZDYwZDI1NWRlNCIsImlhdCI6MTcyMTM3NTcxNywiZXhwIjoxNzIxNDYyMTE3fQ.GeVXTsjTfRadnt0yPOCy1Tj3NEAElZXaK5iZOrI-Ebw';
    final url = Uri.parse('http://192.168.0.116:3000/customer/list');
    final response = await http.post(
      url,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndlYkBnbWFpbC5jb20iLCJyb2xlIjoic3VwZXJhZG1pbiIsIl9pZCI6IjY2MWNlM2JkNTIzZTUzZDYwZDI1NWRlNCIsImlhdCI6MTcyMTM3NTcxNywiZXhwIjoxNzIxNDYyMTE3fQ.GeVXTsjTfRadnt0yPOCy1Tj3NEAElZXaK5iZOrI-Ebw',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "searchValue": "",
        "category_id": category_Id ?? "",
        "branch_id": branch_Id ?? "",
        "route_id": route_Id ?? "",
        "priceList_id": "",
        "status": ""
      }),
    );

    if (response.statusCode == 201) {
      List<dynamic> data = jsonDecode(response.body)["data"]["data"];
      List<Customer> tempList = [];
      if (data.isNotEmpty) {
        for (var i = 0; i < data.length; i++)
          tempList.add(Customer.fromJson(data[i]));
      }
      setState(() {
        cusList = tempList;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future routeDataBottomSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(25))),
              child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    backgroundColor: Colors.grey[200],
                    appBar: AppBar(
                      elevation: 0.0,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.green[100],
                      title: TabBar(
                          labelColor: Colors.white,
                          splashBorderRadius: BorderRadius.circular(12),
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.grey[300],
                          tabs: [
                            Tab(
                              child: Text(
                                'Route',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Tab(
                              child: Text('Branch',
                                  style: TextStyle(color: Colors.grey[700])),
                            ),
                            Tab(
                              child: Text(
                                'category',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                          ]),
                    ),
                    body: TabBarView(children: [
                      RouteScreen(
                          onRouteSelectedRouteId: onselectedRouteId,
                          onSelectedIdName: onselectedRouteName),
                      BranchScreen2(
                          onSelectedBranchId: onSelectedBranchId,
                          onSelectedBranchName: onselectedBranchName),
                      CategoryScreen3(
                          onSelectedCategoryId: onSelectedCategoryId,
                          onSelectedCategoryName: onselectedCategoryName)
                    ]),
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Task',
          style: TextStyle(color: Colors.blueGrey),
        ),
        leading: IconButton(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CustomerListScreen();
                })),
            icon: Icon(
              Icons.refresh_rounded,
              color: icon_color,
              size: 28,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: IconButton(
                onPressed: () => routeDataBottomSheet(
                      context,
                    ),
                icon: const Icon(
                  Icons.filter_alt_outlined,
                  size: 28,
                  color: Colors.blueGrey,
                )),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      routeLabel,
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 3),
                    Center(
                      child: Text(
                        routeName,
                        style:
                            TextStyle(fontSize: 16, color: Colors.green[400]),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      branchLabel,
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 3),
                    Center(
                      child: Text(
                        branchName,
                        style:
                            TextStyle(fontSize: 17, color: Colors.green[400]),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      categoryLabel,
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 3),
                    Center(
                      child: Text(
                        categoryName,
                        style:
                            TextStyle(fontSize: 17, color: Colors.green[400]),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      routeName = "";
                      branchName = "";
                      categoryName = "";
                      fetchCustomerData("", "", "");
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CustomerListScreen();
                    }));
                  },
                  child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey)),
                      child: Icon(
                        Icons.clear,
                        size: 18,
                        color: Colors.grey[600],
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: cusList.isEmpty == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: cusList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            displayBottomSheet(context, cusList[index]!),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.person,
                                                color: icon_color),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(cusList[index]!.name),
                                          ],
                                        ),
                                        Text(
                                          cusList[index]!
                                              .opening_Bal
                                              .toString(),
                                          style: TextStyle(
                                              color: cusList[index]!
                                                          .opening_Bal >
                                                      1
                                                  ? Colors.green
                                                  : cusList[index]!
                                                              .opening_Bal ==
                                                          0
                                                      ? Colors.grey[800]
                                                      : Colors.red,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.category,
                                                color: icon_color),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(cusList[index]!.route_name),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'images/categories.png',
                                              height: 20,
                                              width: 20,
                                              color: icon_color,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(cusList[index]!.category_name),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.broadcast_on_home,
                                                color: icon_color),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(cusList[index]!.branch_name),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          color: Colors.grey[500],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
