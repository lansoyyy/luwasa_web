import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luwasa_web/screens/auth/login_screen.dart';
import 'package:luwasa_web/screens/tabs/dashboard_tab.dart';
import 'package:luwasa_web/screens/tabs/reports_tab.dart';
import 'package:luwasa_web/screens/tabs/users_tab.dart';
import 'package:luwasa_web/services/add_payment.dart';
import 'package:luwasa_web/utils/colors.dart';
import 'package:luwasa_web/widgets/button_widget.dart';
import 'package:luwasa_web/widgets/logout_widget.dart';
import 'package:luwasa_web/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:luwasa_web/widgets/textfield_widget.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showUsers();
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 75),
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              TextWidget(
                text: 'Luwasa Admin',
                fontSize: 32,
                fontFamily: 'Bold',
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              width: 400,
              height: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                        leading: Icon(
                          Icons.dashboard_outlined,
                          color: index == 0 ? Colors.black : Colors.grey,
                        ),
                        title: TextWidget(
                          text: 'Dashboard',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: index == 0 ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        leading: Icon(
                          Icons.groups_2_outlined,
                          color: index == 1 ? Colors.black : Colors.grey,
                        ),
                        title: TextWidget(
                          text: 'Users',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: index == 1 ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            index = 2;
                          });
                        },
                        leading: Icon(
                          Icons.insert_chart_sharp,
                          color: index == 2 ? Colors.black : Colors.grey,
                        ),
                        title: TextWidget(
                          text: 'Reports',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: index == 2 ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        onTap: () {
                          logout(context, const LoginScreen());
                        },
                        leading: const Icon(
                          Icons.logout_outlined,
                          color: Colors.red,
                        ),
                        title: TextWidget(
                          text: 'Logout',
                          fontSize: 18,
                          fontFamily: 'Bold',
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.grey[100],
              child: IndexedStack(
                index: index,
                children: const [
                  DashboardTab(),
                  UsersTab(),
                  ReportsTab(),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  final searchController = TextEditingController();
  String nameSearched = '';
  showUsers() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              height: 500,
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(100)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Regular',
                                fontSize: 14),
                            onChanged: (value) {
                              setState(() {
                                nameSearched = value;
                              });
                            },
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                hintText: 'Search User',
                                hintStyle: TextStyle(
                                    fontFamily: 'Regular', fontSize: 18),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                )),
                            controller: searchController,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .where('name',
                                isGreaterThanOrEqualTo:
                                    toBeginningOfSentenceCase(nameSearched))
                            .where('name',
                                isLessThan:
                                    '${toBeginningOfSentenceCase(nameSearched)}z')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error);
                            return const Center(child: Text('Error'));
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.black,
                              )),
                            );
                          }

                          final data = snapshot.requireData;
                          return SizedBox(
                            height: 350,
                            width: 500,
                            child: ListView.builder(
                              itemCount: data.docs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      showAmount(data.docs[index]);
                                    },
                                    leading: SizedBox(
                                      width: 300,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.account_circle,
                                            size: 65,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          TextWidget(
                                            text: data.docs[index]['name'],
                                            fontSize: 23,
                                            fontFamily: 'Bold',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  final amount = TextEditingController();
  showAmount(dynamic data) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFieldWidget(
                    label: 'Enter Amount',
                    controller: amount,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    label: 'Continue',
                    onPressed: () {
                      addPayment(
                          data['name'],
                          data['email'],
                          data['number'],
                          data['houseno'],
                          data['meterid'],
                          data['brgy'],
                          data.id,
                          int.parse(amount.text));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
