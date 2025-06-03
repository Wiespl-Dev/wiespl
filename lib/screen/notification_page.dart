import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/notification_list_response.dart';
import 'package:wiespl/presenter/notification_presenter.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    implements NotificationView {
  List<NotificationData> list = [];
  List<NotificationData> myListSearchResult = [];
  TextEditingController searchController = TextEditingController();

  NotificationPresenter? _presenter;

  _NotificationPageState() {
    _presenter = NotificationPresenter(this);
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {
      myListSearchResult = [];
    });
    _presenter!.getNotificationList();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();

    _presenter!.getNotificationList();

    //list.add(NotificationData1('Delight them with real-time updates', '08:54 PM', 'Keep your readers updated. Always. No one wants to be the last one to know something important. Send them notification is seconds from the news breaking in. This work brilliantly with breaking news, informing users about cricket scores and news that is time-sensitive.'));
    //list.add(NotificationData1('Lure users into subscribing', '08:54 PM', 'Be it subscribing to exclusive content or getting users into your email subscription list, leverage push notifications to lure them into subscribing. Show them what they are missing out on, tell them the benefits, and encourage subscription.'));
    //list.add(NotificationData1('Delight them with real-time updates', '08:54 PM', 'Keep your readers updated. Always. No one wants to be the last one to know something important. Send them notification is seconds from the news breaking in. This work brilliantly with breaking news, informing users about cricket scores and news that is time-sensitive.'));
    //list.add(NotificationData1('Lure users into subscribing', '08:54 PM', 'Be it subscribing to exclusive content or getting users into your email subscription list, leverage push notifications to lure them into subscribing. Show them what they are missing out on, tell them the benefits, and encourage subscription.'));
    //list.add(NotificationData1('Delight them with real-time updates', '08:54 PM', 'Keep your readers updated. Always. No one wants to be the last one to know something important. Send them notification is seconds from the news breaking in. This work brilliantly with breaking news, informing users about cricket scores and news that is time-sensitive.'));
    //list.add(NotificationData1('Lure users into subscribing', '08:54 PM', 'Be it subscribing to exclusive content or getting users into your email subscription list, leverage push notifications to lure them into subscribing. Show them what they are missing out on, tell them the benefits, and encourage subscription.'));
    //list.add(NotificationData1('Delight them with real-time updates', '08:54 PM', 'Keep your readers updated. Always. No one wants to be the last one to know something important. Send them notification is seconds from the news breaking in. This work brilliantly with breaking news, informing users about cricket scores and news that is time-sensitive.'));
    //list.add(NotificationData1('Lure users into subscribing', '08:54 PM', 'Be it subscribing to exclusive content or getting users into your email subscription list, leverage push notifications to lure them into subscribing. Show them what they are missing out on, tell them the benefits, and encourage subscription.'));

    //myListSearchResult.addAll(list);
  }

  onSearchTextChanged(String text) async {
    myListSearchResult.clear();
    if (text.isEmpty) {
      myListSearchResult.addAll(list);
      setState(() {});
      return;
    }
    for (var data in list) {
      if (data.title!.toLowerCase().contains(text.toLowerCase()) ||
          data.description!.toLowerCase().contains(text.toLowerCase())) {
        myListSearchResult.add(data);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorWhite,
          body: Column(
            children: [
              actionBar(context, "Notification", true),
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
                          style: Theme.of(context).textTheme.bodySmall,
                          //keyboardType:TextInputType.number,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Search'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  child: myListSearchResult.length > 0
                      ? ListView.builder(
                          itemCount: myListSearchResult.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = myListSearchResult[index];
                            return InkWell(
                              onTap: (() {
                                //Get.toNamed('/open_request_details');
                              }),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //verticalView(),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data.title!,
                                                overflow: TextOverflow.ellipsis,
                                                style: heading2(colorPrimary),
                                              ),
                                            ),
                                            Text(
                                              data.dateTime!,
                                              // DateFormat("dd-MM-yyyy HH:mm:ss a").parse(data.createdAt!).toString(),
                                              style: bodyText1(colorSecondary),
                                            ),
                                            /*const Icon(
                                        Icons.chevron_right,
                                        color: colorGray,
                                        size: 30,
                                      ),*/
                                          ],
                                        ),
                                        verticalView(),

                                        Text(
                                          data.description!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: bodyText2(colorSecondary),
                                        ),

                                        const SizedBox(height: 15),

                                        divider(),
                                        //const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(
                              'No Data Found',
                              style: heading2(colorBlack),
                            ),
                          ),
                        ),
                ),
              )),
              footer(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onError(int errorCode) {
    // TODO: implement onError
  }

  @override
  void onNotificationListSuccess(NotificationListResponse data) {
    if (data.status == 200) {
      setState(() {
        list = [];
        // list.addAll(data.results!);
        for (int i = 0; i < data.results!.length; i++) {
          try {
            var n = NotificationData();
            n.id = data.results![i].id;
            n.title = data.results![i].title;
            n.description = data.results![i].description;
            n.readStatus = data.results![i].readStatus;
            n.createdAt = data.results![i].createdAt;

            var dateValue = DateFormat("yyyy-MM-ddTHH:mm:ss")
                .parseUTC(n.createdAt!)
                .toLocal();
            String formattedDate =
                DateFormat("dd-MM-yyyy HH:mm:ss a").format(dateValue);

            n.dateTime = formattedDate;
            list.add(n);
          } on Exception catch (_) {
            print('invaild date');
          }
        }

        myListSearchResult.addAll(list);
      });
    }
  }
}
