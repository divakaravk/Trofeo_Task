// ignore_for_file: override_on_non_overriding_member, unused_local_variable, unused_import, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_declarations, curly_braces_in_flow_control_structures, dead_code, annotate_overrides

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trofeo/model/route_model.dart';
import 'package:trofeo/pages/home_page.dart';

class RouteScreen extends StatefulWidget {
  final Function(dynamic) onRouteSelectedRouteId;
  final Function(dynamic) onSelectedIdName;
  RouteScreen(
      {super.key,
      required this.onRouteSelectedRouteId,
      required this.onSelectedIdName});
  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  @override
  void initState() {
    super.initState();
    getRouteData();
  }

  Future showDialogbox(BuildContext context, Route_data value) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green[200],
            content: Text(
              'Status: ${value.status.toString()}',
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          );
        });
  }

  @override
  Route_data? route_data;
  List<Route_data> route_data_list = [];
  dynamic? selected_routeId;
  dynamic? selected_Id_Name;
  int? selectedIndex;

  Future<void> getRouteData() async {
    final token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndlYkBnbWFpbC5jb20iLCJyb2xlIjoic3VwZXJhZG1pbiIsIl9pZCI6IjY2MWNlM2JkNTIzZTUzZDYwZDI1NWRlNCIsImlhdCI6MTcyMTM3NTcxNywiZXhwIjoxNzIxNDYyMTE3fQ.GeVXTsjTfRadnt0yPOCy1Tj3NEAElZXaK5iZOrI-Ebw';
    final url = Uri.parse('http://192.168.0.116:3000/route/list');
    final response = await http.post(
      url,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndlYkBnbWFpbC5jb20iLCJyb2xlIjoic3VwZXJhZG1pbiIsIl9pZCI6IjY2MWNlM2JkNTIzZTUzZDYwZDI1NWRlNCIsImlhdCI6MTcyMTM3NTcxNywiZXhwIjoxNzIxNDYyMTE3fQ.GeVXTsjTfRadnt0yPOCy1Tj3NEAElZXaK5iZOrI-Ebw',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      List<dynamic> route_Data = jsonDecode(response.body)["data"]["data"];
      List<Route_data> temp_Route_List = [];

      if (route_Data.isNotEmpty) {
        for (var i = 0; i < route_Data.length; i++)
          temp_Route_List.add(Route_data.fromJson(route_Data[i]));
      }
      setState(() {
        route_data_list = temp_Route_List;
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
              const Text('Route Screen',
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
                itemCount: route_data_list.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    startActionPane:
                        ActionPane(motion: const StretchMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {
                          showDialogbox(context, route_data_list[index]);
                        },
                        backgroundColor:
                            const Color.fromARGB(255, 156, 231, 159),
                        icon: Icons.check,
                      )
                    ]),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected_routeId = route_data_list[index].route_Id;
                          selected_Id_Name = route_data_list[index].route_Name;
                        });
                        widget.onRouteSelectedRouteId(
                          selected_routeId,
                        );
                        widget.onSelectedIdName(selected_Id_Name);
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
                                selected_routeId =
                                    route_data_list[index].route_Id;
                                selected_Id_Name =
                                    route_data_list[index].route_Name;
                              });
                              widget.onRouteSelectedRouteId(
                                selected_routeId,
                              );
                              widget.onSelectedIdName(selected_Id_Name);
                              Navigator.pop(context);
                            },
                            title: Text(
                              route_data_list[index].route_Name,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
                            ),
                            subtitle: Text(
                              route_data_list[index].route_Code,
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
