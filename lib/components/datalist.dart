import 'package:flutter/material.dart';
import 'package:myprofile_greendee/components/delete.dart';
import 'package:myprofile_greendee/components/edit.dart';

class DataList extends StatefulWidget {
  final String account;
  final String password;
  final String entryId;
  const DataList({
    Key? key,
    required this.account,
    required this.password,
    required this.entryId,
  }) : super(key: key);

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {

  //10 letters maximum
  String insertLineBreaks(String input, int breakAfter) {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      buffer.write(input[i]);
      if ((i + 1) % breakAfter == 0) {
        buffer.write('\n');
      }
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10,
        bottom: 10,
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Account')),
                DataColumn(label: Text('Password')),
                DataColumn(label: Text('Actions')),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(
                      Text(
                        insertLineBreaks(widget.account, 10),
                      ),
                    ),
                    DataCell(
                      Text(
                        insertLineBreaks(widget.password, 10),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditModal(
                                    account: widget.account,
                                    password: widget.password,
                                  );
                                },
                              );
                            },
                          ),

                          DeleteButton(entryId: widget.entryId),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
