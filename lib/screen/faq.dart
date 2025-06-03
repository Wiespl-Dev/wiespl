import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final List<Item> _data = generateItems(7);

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
          body: Column(
            children: [
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
                  child: Container(
                    child: _buildPanel(),
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
    if (index == 0) {
      return Item(
        headerValue: 'What is a Smart HVAC Control Mobile Application?',
        expandedValue:
            'A Smart HVAC Control Mobile Application is a smartphone app that allows you to remotely control and monitor your heating, ventilation, and air conditioning (HVAC) system using your mobile device.',
      );
    } else if (index == 1) {
      return Item(
        headerValue:
            'What features does a Smart HVAC Control Mobile Application offer?',
        expandedValue:
            'A Smart HVAC Control Mobile Application typically offers a range of features, including temperature control, humidity control, scheduling, energy usage monitoring, and more.',
      );
    } else if (index == 2) {
      return Item(
        headerValue: 'How does a Smart HVAC Control Mobile Application work?',
        expandedValue:
            'A Smart HVAC Control Mobile Application works by connecting to your HVAC system through a Wi-Fi network, allowing you to control and monitor your system from anywhere using your mobile device.',
      );
    } else if (index == 3) {
      return Item(
        headerValue:
            'What are the benefits of using a Smart HVAC Control Mobile Application?',
        expandedValue:
            'The benefits of using a Smart HVAC Control Mobile Application include increased energy efficiency, improved comfort and convenience, and the ability to monitor and control your system remotely.',
      );
    } else if (index == 4) {
      return Item(
        headerValue:
            'Is a Smart HVAC Control Mobile Application compatible with all HVAC systems?',
        expandedValue:
            'Not all HVAC systems are compatible with Smart HVAC Control Mobile Applications. Before purchasing a Smart HVAC Control Mobile Application, it is important to verify that it is compatible with your specific HVAC system.',
      );
    } else if (index == 5) {
      return Item(
        headerValue:
            'How do I install a Smart HVAC Control Mobile Application?',
        expandedValue:
            'The installation process for a Smart HVAC Control Mobile Application varies depending on the specific app and HVAC system. Generally, the installation involves downloading the app from the app store and following the setup instructions provided by the app.',
      );
    } else if (index == 6) {
      return Item(
        headerValue: 'Is a Smart HVAC Control Mobile Application secure?',
        expandedValue:
            'Yes, most Smart HVAC Control Mobile Applications use advanced encryption and security measures to ensure that your data is secure and protected from unauthorized access.',
      );
    } else {
      return Item(headerValue: '', expandedValue: '');
    }
  });
}
