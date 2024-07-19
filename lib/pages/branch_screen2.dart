// ignore_for_file: override_on_non_overriding_member, unused_local_variable, unused_import, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_declarations, curly_braces_in_flow_control_structures, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:trofeo/model/branch_model.dart';
import 'dart:convert';
import 'package:trofeo/model/route_model.dart';
import '../model/class_model.dart';
import 'package:trofeo/pages/home_page.dart';

class BranchScreen2 extends StatefulWidget {
  final Function(dynamic) onSelectedBranchId;
  final Function(dynamic) onSelectedBranchName;
  BranchScreen2(
      {super.key,
      required this.onSelectedBranchId,
      required this.onSelectedBranchName});

  @override
  State<BranchScreen2> createState() => _BranchScreen2State();
}

class _BranchScreen2State extends State<BranchScreen2> {
  @override
  void initState() {
    super.initState();
    getBranchData();
  }

  @override
  Branch_Data? branch_data;
  List<Branch_Data> branch_data_list = [];
  dynamic? selected_Branch_Id;
  dynamic? selected_Branch_Name;
  int? selectedIndex;

  Future showDialogbox(BuildContext context, Branch_Data value) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green[200],
            content: Text(
              'Pincode: ${value.branch_Pincode.toString()}',
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          );
        });
  }

  Future<void> getBranchData() async {
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndlYkBnbWFpbC5jb20iLCJyb2xlIjoic3VwZXJhZG1pbiIsIl9pZCI6IjY2MWNlM2JkNTIzZTUzZDYwZDI1NWRlNCIsImlhdCI6MTcyMTM3NTcxNywiZXhwIjoxNzIxNDYyMTE3fQ.GeVXTsjTfRadnt0yPOCy1Tj3NEAElZXaK5iZOrI-Ebw';
    final url = Uri.parse('http://192.168.0.116:3000/branch/list');
    final response = await http.post(
      url,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndlYkBnbWFpbC5jb20iLCJyb2xlIjoic3VwZXJhZG1pbiIsIl9pZCI6IjY2MWNlM2JkNTIzZTUzZDYwZDI1NWRlNCIsImlhdCI6MTcyMTM3NTcxNywiZXhwIjoxNzIxNDYyMTE3fQ.GeVXTsjTfRadnt0yPOCy1Tj3NEAElZXaK5iZOrI-Ebw',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      List<dynamic> branch_data = jsonDecode(response.body)["data"]["data"];
      List<Branch_Data> temp_Branch_List = [];

      if (branch_data.isNotEmpty) {
        for (var i = 0; i < branch_data.length; i++)
          temp_Branch_List.add(Branch_Data.fromJson(branch_data[i]));
      }
      setState(() {
        branch_data_list = temp_Branch_List;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Branch Screen',
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueAccent,
                  )),
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[400]),
                      child: Icon(
                        Icons.clear,
                        size: 20,
                        color: Colors.grey[800],
                      ))),
            ],
          ),
        ),
        const SizedBox(
          height: 17,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: branch_data_list.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    startActionPane:
                        ActionPane(motion: const StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          showDialogbox(context, branch_data_list[index]);
                        },
                        backgroundColor:
                            const Color.fromARGB(255, 156, 231, 159),
                        icon: Icons.check,
                      ),
                    ]),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected_Branch_Id =
                              branch_data_list[index].branch_Id;
                          selected_Branch_Name =
                              branch_data_list[index].branch_Name;
                        });
                        widget.onSelectedBranchId(selected_Branch_Id);
                        widget.onSelectedBranchName(selected_Branch_Name);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? Colors.green[100]
                                  : Colors.grey[400],
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            tileColor: selectedIndex == index
                                ? Colors.green[100]
                                : null,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                selected_Branch_Id =
                                    branch_data_list[index].branch_Id;
                                selected_Branch_Name =
                                    branch_data_list[index].branch_Name;
                              });
                              widget.onSelectedBranchId(selected_Branch_Id);
                              widget.onSelectedBranchName(selected_Branch_Name);
                              Navigator.pop(context);
                            },
                            title: Text(
                              branch_data_list[index].branch_Name,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
                            ),
                            subtitle: Text(
                              branch_data_list[index].branch_Pincode.toString(),
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                  const SizedBox(
                    height: 10,
                  );
                })),
      ],
    );
  }
}
