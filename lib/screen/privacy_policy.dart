import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              actionBar(context, privacyPolicy, true),
              //title(privacyPolicy),
              Expanded(
                child: SingleChildScrollView(
                  child:  _buildPanel(),
                ),
              ),
              footer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expandedHeaderPadding: const EdgeInsets.all(2),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.headerValue,
                style:  heading2(colorPrimary),
              ),
            );
          },
          body: ListTile(
            //title: Text(item.expandedValue),
              subtitle: Text(item.expandedValue, style: bodyText2(colorSecondary)),
              //trailing: const Icon(Icons.delete),
              onTap: () {
                /*setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });*/
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    if (index == 0 || index == 2 || index == 4 || index == 6) {
      return Item(
        headerValue: 'What Are Mobile Terms and Conditions?',
        expandedValue:
        'Mobile app terms and conditions, also referred to as app terms of service or app terms of use, explain the rules, requirements, restrictions, and limitations that users must abide by in order to use a mobile application. Specifically, they act as a binding contract between you and your users. This contract helps protect the rights of both parties.',
      );
    } else {
      return Item(
        headerValue: 'Are Terms and Conditions for My Mobile App Required?',
        expandedValue:
        'No, terms and conditions for your mobile app are not legally required. However, including terms and conditions on your mobile app is strongly recommended, as they give both you and your end-users certain advantages.',
      );
    }
  });
}

