import 'package:aptm/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../profile/data/providers/profile_detail_provider.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});
  static const path = 'notifications';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.refresh(profilDetailsProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff0000ff),
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Notifications',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                // color: Color(0xff222222),
              ),
            ),
          ),
        ),
        body: userData.when(
            data: (noti) => ListView.builder(
                  itemCount: noti.data.notifications.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 340,
                          decoration: const BoxDecoration(
                            color: Color(0xfff5faff),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      noti.data.notifications[index].title,
                                      style: const TextStyle(
                                          color: Color(0xff222222),
                                          fontFamily: 'Poppins',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      noti.data.notifications[index].body,
                                      style: const TextStyle(
                                          color: Color(0xff666666),
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            error: (error, stackTrace) => Text('Error: $error'),
            loading: () {
              return Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 86,
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        'You haven\'t gotten any notifications yet',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          // color: Color(0xff222222),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'we\'ll alert you once something cool happens.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Color(0xff666666),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
