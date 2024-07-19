// ignore_for_file: override_on_non_overriding_member, unused_local_variable, unused_import, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_declarations, curly_braces_in_flow_control_structures, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:trofeo/model/category_model.dart';
import 'dart:convert';
import 'package:trofeo/pages/home_page.dart';

class CategoryScreen3 extends StatefulWidget {
  final Function(dynamic) onSelectedCategoryId;
  final Function(dynamic) onSelectedCategoryName;
  CategoryScreen3(
      {super.key,
      required this.onSelectedCategoryId,
      required this.onSelectedCategoryName});

  @override
  State<CategoryScreen3> createState() => _CategoryScreen3State();
}

class _CategoryScreen3State extends State<CategoryScreen3> {
  @override
  void initState() {
    super.initState();
    getCategoryData();
  }

  @override
  Category_Data? category_data;
  List<Category_Data> category_data_list = [];
  dynamic? selected_CategoryId;
  dynamic? selected_CategoryName;
  int? selectedIndex;
  bool isHovered = false;

  Future showDialogBox(BuildContext context, Category_Data value) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green[200],
            content: Text('Status:${value.category_Status.toString()}',
                style: TextStyle(fontSize: 22, color: Colors.grey[800])),
          );
        });
  }

  Future<void> getCategoryData() async {
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndlYkBnbWFpbC5jb20iLCJyb2xlIjoic3VwZXJhZG1pbiIsIl9pZCI6IjY2MWNlM2JkNTIzZTUzZDYwZDI1NWRlNCIsImlhdCI6MTcyMTM3NTcxNywiZXhwIjoxNzIxNDYyMTE3fQ.GeVXTsjTfRadnt0yPOCy1Tj3NEAElZXaK5iZOrI-Ebw';
    final url = Uri.parse('http://192.168.0.116:3000/customer/category/list');
    final response = await http.post(
      url,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndlYkBnbWFpbC5jb20iLCJyb2xlIjoic3VwZXJhZG1pbiIsIl9pZCI6IjY2MWNlM2JkNTIzZTUzZDYwZDI1NWRlNCIsImlhdCI6MTcyMTM3NTcxNywiZXhwIjoxNzIxNDYyMTE3fQ.GeVXTsjTfRadnt0yPOCy1Tj3NEAElZXaK5iZOrI-Ebw',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      List<dynamic> category_data = jsonDecode(response.body)["data"]["data"];
      List<Category_Data> temp_Category_List = [];

      if (category_data.isNotEmpty) {
        for (var i = 0; i < category_data.length; i++)
          temp_Category_List.add(Category_Data.fromJson(category_data[i]));
      }
      setState(() {
        category_data_list = temp_Category_List;
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
              const Text('Category Screen',
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
                itemCount: category_data_list.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    startActionPane:
                        ActionPane(motion: const StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          showDialogBox(context, category_data_list[index]);
                        },
                        backgroundColor:
                            const Color.fromARGB(255, 156, 231, 159),
                        icon: Icons.check,
                      )
                    ]),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected_CategoryId =
                              category_data_list[index].category_Id;
                          selected_CategoryName =
                              category_data_list[index].category_Name;
                        });
                        widget.onSelectedCategoryId(selected_CategoryId);
                        widget.onSelectedCategoryName(selected_CategoryName);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: isHovered
                                  ? Colors.green[100]
                                  : selectedIndex == index
                                      ? Colors.green[100]
                                      : Colors.grey[400],
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            tileColor: isHovered
                                ? Colors.green
                                : selectedIndex == index
                                    ? Colors.green[100]
                                    : null,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                selected_CategoryId =
                                    category_data_list[index].category_Id;
                                selected_CategoryName =
                                    category_data_list[index].category_Name;
                              });
                              widget.onSelectedCategoryId(selected_CategoryId);
                              widget.onSelectedCategoryName(
                                  selected_CategoryName);
                              Navigator.pop(context);
                            },
                            title: Text(
                              category_data_list[index].category_Name,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
                            ),
                            subtitle: Text(
                              category_data_list[index]
                                  .category_Status
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Divider(
                      color: Colors.grey[800],
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
