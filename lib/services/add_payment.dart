import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Future addPayment(
    name, email, number, houseno, meterid, brgy, userId, int amount) async {
  final docUser = FirebaseFirestore.instance.collection('Payments').doc();

  final json = {
    'name': name,
    'number': number,
    'email': email,
    'houseno': houseno,
    'meterid': meterid,
    'brgy': brgy,
    'id': docUser.id,
    'isVerified': false,
    'profile': '',
    'isPaid': false,
    'isActive': false,
    'amount': amount,
    'uid': userId,
    'date': DateTime.now(),
    'month': DateTime.now().month,
    'year': DateTime.now().year,
    'monthName': DateFormat.MMMM().format(DateTime.now()),
  };

  await docUser.set(json);
}
