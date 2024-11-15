import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luwasa_web/services/add_user.dart';
import 'package:luwasa_web/utils/colors.dart';
import 'package:luwasa_web/widgets/button_widget.dart';
import 'package:luwasa_web/widgets/text_widget.dart';
import 'package:luwasa_web/widgets/textfield_widget.dart';
import 'package:luwasa_web/widgets/toast_widget.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({super.key});

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  List columns = [
    'Name',
    'House Number',
    'Baranggay',
    'Contact Number',
    'Meter ID'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: ButtonWidget(
            width: 125,
            height: 40,
            label: 'Add User',
            onPressed: () {
              addUserDialog();
            },
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Users').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            text: data.docs[i]['name'],
                            fontSize: 16,
                            fontFamily: 'Medium',
                          ),
                        ),
                        DataCell(
                          TextWidget(
                            text: data.docs[i]['houseno'],
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
                            text: data.docs[i]['number'],
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
                      ])
                  ]));
            }),
      ],
    );
  }

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final number = TextEditingController();

  final houseno = TextEditingController();
  final brgy = TextEditingController();
  final meterid = TextEditingController();

  addUserDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Create User',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      hasValidator: false,
                      hint: 'Enter fullname',
                      borderColor: Colors.grey,
                      label: 'Fullname',
                      controller: name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a email';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      inputType: TextInputType.number,
                      hasValidator: false,
                      hint: 'Enter contact number',
                      borderColor: Colors.grey,
                      label: 'Contact Number',
                      controller: number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a email';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      hasValidator: false,
                      hint: 'Enter House Number',
                      borderColor: Colors.grey,
                      label: 'House Number',
                      controller: houseno,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a house number';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      hasValidator: false,
                      hint: 'Enter Baranggay',
                      borderColor: Colors.grey,
                      label: 'Baranggay',
                      controller: brgy,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Baranggay';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      hasValidator: false,
                      hint: 'Enter Meter ID',
                      borderColor: Colors.grey,
                      label: 'Meter ID',
                      controller: meterid,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Meter ID';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      hasValidator: false,
                      hint: 'Enter email',
                      borderColor: Colors.grey,
                      label: 'Email',
                      controller: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a email';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        TextFieldWidget(
                          hasValidator: false,
                          hint: 'Enter password',
                          showEye: true,
                          borderColor: Colors.grey,
                          label: 'Password',
                          isObscure: true,
                          controller: password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ButtonWidget(
                      label: 'Register',
                      onPressed: () {
                        register(context);
                      },
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  register(context) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);

      addUser(name.text, email.text, number.text, houseno.text, meterid.text,
          brgy.text, user.user?.uid ?? '');

      // signup(nameController.text, numberController.text, addressController.text,
      //     emailController.text);

      Navigator.of(context).pop();
      showToast("User Registered Successfully!");

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        showToast('The email address is not valid.');
      } else {
        showToast(e.toString());
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
