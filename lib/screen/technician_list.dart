import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wiespl/model/login_response.dart';
import 'package:wiespl/model/technician_data.dart';
import 'package:wiespl/utils/color.dart';
import 'package:wiespl/utils/images.dart';
import 'package:wiespl/utils/string.dart';
import 'package:wiespl/utils/widget.dart';

import '../model/technician_list_response.dart';
import '../presenter/technician_presenter.dart';

class TechnicianList extends StatefulWidget {
  const TechnicianList({Key? key}) : super(key: key);

  @override
  _TechnicianListState createState() => _TechnicianListState();
}

class _TechnicianListState extends State<TechnicianList>
    implements TechnicianView {
  List<TechnicianData> technicianDataList = [];

  TechnicianPresenter? _presenter;

  _TechnicianListState() {
    _presenter = TechnicianPresenter(this);
  }

  int type = 0;

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {
      technicianDataList = [];
    });
    _presenter!.getTechnicianList();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _presenter!.getTechnicianList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorLightGrayBG,
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: technicianDataList.length > 0
                  ? Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: ListView.builder(
                  itemCount: technicianDataList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = technicianDataList[index];
                    return InkWell(
                      onTap: (() {}),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalViewBig(),
                            Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  border: Border.all(color: colorApp),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /*const Icon(
                                    Icons.supervised_user_circle,
                                    color: colorPrimary,
                                    size: 50,
                                  ),*/
                                    Image.asset(appIcon,
                                        height: 50, width: 50),
                                    horizontalView(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data.name!,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: colorPrimary,
                                                      fontFamily: "Medium"),
                                                ),
                                              ),
                                              Text(
                                                data.status! == 1
                                                    ? 'Active'
                                                    : 'Inactive',
                                                // style: heading1(userData!.status! == 1 ? colorGreen : colorOrange),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: data.status! == 1
                                                        ? colorGreen
                                                        : colorOrange,
                                                    fontFamily: "Medium"),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Email : ' + data.email!,
                                            style: bodyText2(colorSecondary),
                                          ),
                                          Text(
                                            'Mobile : ' + data.mobile!,
                                            style: bodyText2(colorSecondary),
                                          ),
                                          /*Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  data.status! == 1 ? 'Active' : 'Inactive',
                                                  // style: heading1(userData!.status! == 1 ? colorGreen : colorOrange),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: data.status! == 1 ? colorGreen : colorOrange,
                                                      fontFamily: "Medium"),
                                                ),
                                              )*/
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    'No Requests Found',
                    style: heading2(colorBlack),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onError(int errorCode) {
    if (errorCode == 401) {
      toastMassage('Please login again');
    }
  }

  @override
  void onTechnicianListSuccess(TechnicianListResponse data) {
    if (data.status == 200) {
      setState(() {
        technicianDataList.addAll(data.results!);
      });
    }
  }
}
