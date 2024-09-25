import 'package:luwasa_web/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                        leading: const Icon(
                          Icons.dashboard_outlined,
                        ),
                        title: TextWidget(
                          text: 'Dashboard',
                          fontSize: 18,
                          fontFamily: 'Bold',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        leading: const Icon(
                          Icons.file_present_outlined,
                        ),
                        title: TextWidget(
                          text: 'FSIC/FSEC Form',
                          fontSize: 18,
                          fontFamily: 'Bold',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        leading: const Icon(
                          Icons.groups_2_outlined,
                        ),
                        title: TextWidget(
                          text: 'Clients',
                          fontSize: 18,
                          fontFamily: 'Bold',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        leading: const Icon(
                          Icons.insert_chart_sharp,
                        ),
                        title: TextWidget(
                          text: 'Reports',
                          fontSize: 18,
                          fontFamily: 'Bold',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: 300,
                      child: ListTile(
                        leading: const Icon(
                          Icons.logout_outlined,
                        ),
                        title: TextWidget(
                          text: 'Logout',
                          fontSize: 18,
                          fontFamily: 'Bold',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.grey[200],
            )),
          ],
        ),
      ),
    );
  }
}
