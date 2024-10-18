import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luwasa_web/widgets/text_widget.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    return Card(
                      color: Colors.white,
                      child: SizedBox(
                        height: 200,
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: '${data.docs.length}',
                              fontSize: 75,
                              fontFamily: 'Bold',
                              color: Colors.green,
                            ),
                            TextWidget(
                              text: 'Number of Users',
                              fontSize: 17,
                              fontFamily: 'Regular',
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                width: 50,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Payments')
                    .where('month', isEqualTo: DateTime.now().month)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  // Get the documents and calculate the total amount
                  final data = snapshot.requireData;
                  num totalAmount = 0;

                  // Iterate through each document and sum the 'amount' field
                  for (var doc in data.docs) {
                    num? amount = doc['amount'];
                    if (amount != null) {
                      totalAmount += amount;
                    }
                  }

                  return Card(
                    color: Colors.white,
                    child: SizedBox(
                      height: 200,
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: '₱ ${totalAmount.toStringAsFixed(2)}',
                            fontSize: 50,
                            fontFamily: 'Bold',
                            color: Colors.green,
                          ),
                          TextWidget(
                            text: 'Total Bill Paid this Month',
                            fontSize: 17,
                            fontFamily: 'Regular',
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          TextWidget(
            text: 'Monthly Water Usage',
            fontSize: 28,
            fontFamily: 'Bold',
            color: Colors.black,
          ),
          const Card(
            color: Colors.white,
            child: SizedBox(
              height: 350,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
