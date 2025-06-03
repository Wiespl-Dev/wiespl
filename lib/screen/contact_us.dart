import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/widget.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorLightGrayBG,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child:
                                Image.asset(appIcon, height: 150, width: 150)),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Western India Electronmedical Systems Private Limited',
                              style: heading2(colorPrimary),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  menuContactUs,
                                  height: 35,
                                  width: 35,
                                  color: colorPrimary,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address',
                                      style: heading2(colorPrimary),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Plot No. 14, Sector No. 4, \nNarsinha Colony, BRT Road Aundh\n - Revet BRTS Rd, Tathawade,\n Pimpri-Chinchwad, Maharashtra 411057',
                                      //overflow: TextOverflow.clip,
                                      textAlign: TextAlign.left,
                                      style: heading1(colorTertiary),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  menuContactUs,
                                  height: 35,
                                  width: 35,
                                  color: colorPrimary,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Website',
                                      style: heading2(colorPrimary),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      'www.wiespl.com',
                                      //overflow: TextOverflow.clip,
                                      textAlign: TextAlign.left,
                                      style: heading1(colorTertiary),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  menuContactUs,
                                  height: 35,
                                  width: 35,
                                  color: colorPrimary,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      style: heading2(colorPrimary),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      'sale@wiespl.com',
                                      //overflow: TextOverflow.clip,
                                      textAlign: TextAlign.left,
                                      style: heading1(colorTertiary),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  menuContactUs,
                                  height: 35,
                                  width: 35,
                                  color: colorPrimary,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Contact Us',
                                      style: heading2(colorPrimary),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '+91-72760 06580',
                                      //overflow: TextOverflow.clip,
                                      textAlign: TextAlign.left,
                                      style: heading1(colorTertiary),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
