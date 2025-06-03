import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

class ServiceRequestPlc extends StatefulWidget {
  const ServiceRequestPlc({Key? key}) : super(key: key);

  @override
  _ServiceRequestPlcState createState() => _ServiceRequestPlcState();
}

class _ServiceRequestPlcState extends State<ServiceRequestPlc> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [

              actionBar(context, '', true),
              title('Lokmanya Hospital'),

              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [

                      ],
                    )
                  ],
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}
