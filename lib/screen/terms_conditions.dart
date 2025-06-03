import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  final List<Item> _data = generateItems(8);
  TextEditingController searchController = TextEditingController();

  onSearchTextChanged(String text) async {
    /* myListSearchResult.clear();
    if (text.isEmpty) {
      myListSearchResult.addAll(_list);
      setState(() {});
      return;
    }
    for (var data in _list) {
      if (data.projectName.toLowerCase().contains(text.toLowerCase())) {
        myListSearchResult.add(data);
      }
    }
    setState(() {});*/
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          //body: _buildPanel(),
          body: Column(
            children: [
              actionBar(context, termsAndConditions, true),
              //title(termsAndConditions),

              /*verticalView(),
                Text(
                  termsAndConditions,
                  style: const  TextStyle(
                      fontSize: 24, fontFamily: "Medium", color: colorText),
                ),
                verticalView(),*/

              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: const BoxDecoration(
                    color: Color(0xffF2F2F7),
                    //border: Border.all(color: colorGray),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 30.0,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: TextField(
                          obscureText: false,
                          textAlign: TextAlign.left,
                          controller: searchController,
                          autofocus: false,
                          onChanged: (text) {
                            onSearchTextChanged(text);
                          },
                          style: Theme.of(context).textTheme.bodyLarge,
                          //keyboardType:TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Search'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildPanel(),
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
                style: heading2(colorPrimary),
              ),
            );
          },
          body: ListTile(
              //title: Text(item.expandedValue),
              subtitle:
                  Text(item.expandedValue, style: bodyText2(colorSecondary)),
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
