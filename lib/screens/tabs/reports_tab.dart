import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luwasa_web/widgets/text_widget.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({super.key});

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
  List columns = [
    'Billing ID',
    'Meter ID',
    'Customer Name',
    'Baranggay',
    'Total Payment',
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Payments')
            .where('isPaid', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            );
          }

          final data = snapshot.requireData;
          return Padding(
              padding: const EdgeInsets.all(20.0),
              child: DataTable(columns: [
                for (int i = 0; i < columns.length; i++)
                  DataColumn(
                    label: TextWidget(
                      text: columns[i],
                      fontSize: 18,
                      fontFamily: 'Bold',
                    ),
                  ),
              ], rows: [
                for (int i = 0; i < data.docs.length; i++)
                  DataRow(cells: [
                    DataCell(
                      TextWidget(
                        text: data.docs[i].id,
                        fontSize: 16,
                        fontFamily: 'Medium',
                      ),
                    ),
                    DataCell(
                      TextWidget(
                        text: data.docs[i]['meterid'],
                        fontSize: 16,
                        fontFamily: 'Medium',
                      ),
                    ),
                    DataCell(
                      TextWidget(
                        text: data.docs[i]['name'],
                        fontSize: 16,
                        fontFamily: 'Medium',
                      ),
                    ),
                    DataCell(
                      TextWidget(
                        text: data.docs[i]['brgy'],
                        fontSize: 16,
                        fontFamily: 'Medium',
                      ),
                    ),
                    DataCell(
                      TextWidget(
                        text: data.docs[i]['amount'].toString(),
                        fontSize: 16,
                        fontFamily: 'Medium',
                      ),
                    ),
                  ])
              ]));
        });
  }
}
