import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(name, email, number, houseno, meterid, brgy, userId) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc(userId);

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
    'uid': userId,
  };

  await docUser.set(json);
}
