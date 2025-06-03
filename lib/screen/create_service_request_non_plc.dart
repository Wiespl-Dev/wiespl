import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wiespl/model/common_response.dart';

import '../common/check_response_code.dart';
import '../data/constant.dart';
import '../model/client/system_list_response.dart';
import '../model/error_list_response.dart';
import '../model/site_list_response.dart';
import '../presenter/management/create_request_non_plc_presenter.dart';
import '../utils/color.dart';
import '../utils/string.dart';
import '../utils/widget.dart';

class CreateServiceRequestNonPlc extends StatefulWidget {
  const CreateServiceRequestNonPlc({Key? key}) : super(key: key);

  @override
  State<CreateServiceRequestNonPlc> createState() =>
      _CreateServiceRequestNonPlcState();
}

class _CreateServiceRequestNonPlcState extends State<CreateServiceRequestNonPlc>
    implements CreateRequestNonPlcView {
  CreateRequestNonPlcPresenter? presenter;

  final _companySearchController = TextEditingController();
  List<SiteData> siteList = [];
  String? selectedSiteId;

  final _errorSearchController = TextEditingController();
  List<ErrorData> errorList = [];
  String? selectedErrorId;

  final _systemSearchController = TextEditingController();
  List<SystemListData> systemList = [];
  String? selectedSystemId;

  TextEditingController commentController = TextEditingController();

  _CreateServiceRequestNonPlcState() {
    presenter = CreateRequestNonPlcPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    presenter!.getSites();
    presenter!.getErrorList();
  }

  void onClickSubmit() {
    if (selectedSiteId == null) {
      toastMassage('Please select site');
      return;
    }

    if (selectedErrorId == null) {
      toastMassage('Please select error');
      return;
    }

    if (selectedSystemId == null) {
      toastMassage('Please select system');
      return;
    }

    if (commentController.text.isEmpty) {
      toastMassage('Please enter comment');
      return;
    }

    confirmationDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title('Service Request Non PLC'),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Site',
                                  style: heading1(colorPrimary),
                                ),
                                // DropdownSearch<SiteData>(
                                //   dropdownDecoratorProps:
                                //       DropDownDecoratorProps(
                                //     dropdownSearchDecoration: InputDecoration(
                                //       hintText: "Please Select Site",
                                //       hintStyle: bodyText1(colorBlack),
                                //       contentPadding:
                                //           EdgeInsets.fromLTRB(0, 12, 0, 0),
                                //       border: InputBorder.none,
                                //     ),
                                //   ),
                                //   popupProps: PopupProps.menu(
                                //     showSearchBox: true,
                                //     searchFieldProps: TextFieldProps(
                                //       controller: _companySearchController,
                                //       style: heading2(colorText),
                                //       decoration: InputDecoration(
                                //         suffixIcon: IconButton(
                                //           icon: Icon(Icons.clear),
                                //           onPressed: () {
                                //             setState(() {
                                //               _companySearchController.clear();
                                //               systemList = [];
                                //               _systemSearchController.clear();
                                //             });
                                //           },
                                //         ),
                                //       ),
                                //     ),
                                //     showSelectedItems: true,
                                //     itemBuilder: _customPopupItemBuilderSite,
                                //     scrollbarProps: ScrollbarProps(
                                //       thumbVisibility:
                                //           true, // replaces isAlwaysShown
                                //       thickness: 7,
                                //     ),
                                //   ),
                                //   compareFn: (item, selectedItem) =>
                                //       item?.hospitalName ==
                                //       selectedItem?.hospitalName,
                                //   asyncItems: (String? filter) =>
                                //       getSiteData(filter),
                                //   onChanged: (data) {
                                //     print(data?.id!);
                                //     setState(() {
                                //       selectedSiteId = data!.id.toString();
                                //       systemList = [];
                                //       selectedSystemId = null;
                                //       _systemSearchController.clear();
                                //       presenter!.getSystemList(
                                //           selectedSiteId.toString());
                                //     });
                                //   },
                                //   selectedItem:
                                //       null, // add this if needed to display selected value
                                //   dropdownBuilder: _customDropDownSite,
                                // ),
                                const Divider(
                                    height: 1, thickness: 1, color: colorApp),
                                verticalViewBig(),
                                Text(
                                  'System Name',
                                  style: heading1(colorPrimary),
                                ),
                                verticalView(),
                                // DropdownSearch<SystemListData>(
                                //   asyncItems: (String? filter) =>
                                //       getSystemData(filter),
                                //   selectedItem: null,
                                //   onChanged: (data) {
                                //     print(data?.id);
                                //     selectedSystemId = data?.id.toString();
                                //   },
                                //   compareFn: (item, selectedItem) =>
                                //       item?.name == selectedItem?.name,
                                //   dropdownDecoratorProps:
                                //       DropDownDecoratorProps(
                                //     dropdownSearchDecoration: InputDecoration(
                                //       hintText: "Please Select System",
                                //       hintStyle: bodyText1(colorBlack),
                                //       contentPadding: const EdgeInsets.fromLTRB(
                                //           0, 12, 0, 0),
                                //       border: InputBorder.none,
                                //     ),
                                //   ),
                                //   popupProps: PopupProps.menu(
                                //     showSearchBox: true,
                                //     searchFieldProps: TextFieldProps(
                                //       controller: _systemSearchController,
                                //       style: heading2(colorText),
                                //       decoration: InputDecoration(
                                //         suffixIcon: IconButton(
                                //           icon: Icon(Icons.clear),
                                //           onPressed: () {
                                //             _systemSearchController.clear();
                                //           },
                                //         ),
                                //       ),
                                //     ),
                                //     itemBuilder: _customPopupItemBuilderSystem,
                                //     showSelectedItems: true,
                                //   ),
                                //   dropdownBuilder: _customDropDownSystem,
                                // ),
                                const Divider(
                                    height: 1, thickness: 1, color: colorApp),
                                verticalViewBig(),
                                Text(
                                  'Select Error',
                                  style: heading1(colorPrimary),
                                ),
                                verticalView(),
                                // DropdownSearch<ErrorData>(
                                //   asyncItems: (String? filter) =>
                                //       getErrorData(filter),
                                //   selectedItem: null,
                                //   onChanged: (data) {
                                //     print(data?.id);
                                //     selectedErrorId = data?.id.toString();
                                //   },
                                //   compareFn: (item, selectedItem) =>
                                //       item?.error == selectedItem?.error,
                                //   dropdownDecoratorProps:
                                //       DropDownDecoratorProps(
                                //     dropdownSearchDecoration: InputDecoration(
                                //       hintText: "Please Select Error",
                                //       hintStyle: bodyText1(colorBlack),
                                //       contentPadding: const EdgeInsets.fromLTRB(
                                //           0, 12, 0, 0),
                                //       border: InputBorder.none,
                                //     ),
                                //   ),
                                //   popupProps: PopupProps.menu(
                                //     showSearchBox: true,
                                //     searchFieldProps: TextFieldProps(
                                //       controller: _errorSearchController,
                                //       style: heading2(colorText),
                                //       decoration: InputDecoration(
                                //         suffixIcon: IconButton(
                                //           icon: Icon(Icons.clear),
                                //           onPressed: () {
                                //             _errorSearchController.clear();
                                //           },
                                //         ),
                                //       ),
                                //     ),
                                //     itemBuilder: _customPopupItemBuilderError,
                                //     showSelectedItems: true,
                                //   ),
                                //   dropdownBuilder: _customDropDownError,
                                //   autoValidateMode:
                                //       AutovalidateMode.onUserInteraction,
                                // ),
                                const Divider(
                                    height: 1, thickness: 1, color: colorApp),
                                verticalViewBig(),
                                Text(
                                  comment,
                                  style: heading1(colorPrimary),
                                ),
                                verticalView(),
                                Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      //color: colorOffWhite,
                                      border: Border.all(color: colorApp),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            obscureText: false,
                                            textAlign: TextAlign.start,
                                            controller: commentController,
                                            autofocus: false,
                                            keyboardType:
                                                TextInputType.multiline,
                                            minLines: 1,
                                            maxLines: 5,
                                            onChanged: (text) {},
                                            style: bodyText2(colorBlack),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: writeComments),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                verticalView(),
                              ],
                            ),
                          ),
                        ),
                        verticalViewBig(),
                        InkWell(
                            onTap: (() {
                              onClickSubmit();
                            }),
                            child: btnHalf(context, 'Submit')),
                        verticalViewBig(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  confirmationDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: colorOffWhite,
            title: const Text("Confirmation",
                style: TextStyle(
                    fontSize: 18, color: colorBlack, fontFamily: "Medium")),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Do you want to Submit this Request?',
                      style: blackTitle1()),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "NO",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                child: Text(
                  "YES",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onPressed: () {
                  Get.back();

                  presenter!.createNonPlcRequest(
                      selectedSiteId!,
                      selectedSystemId!,
                      selectedErrorId!,
                      commentController.text);
                },
              )
            ],
          );
        });
  }

  Widget _customDropDownSite(BuildContext context, SiteData? item) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: Text(item.hospitalName!),
    );
  }

  Widget _customPopupItemBuilderSite(
      BuildContext context, SiteData? item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item?.hospitalName ?? '',
          style: bodyText2(colorText),
        ),
      ),
    );
  }

  Future<List<SiteData>> getSiteData(String? filter) async {
    List<SiteData> _searchResult = [];

    print(filter);
    for (var userDetail in siteList) {
      if (userDetail.hospitalName!
          .toLowerCase()
          .contains(filter!.toLowerCase())) _searchResult.add(userDetail);
      // print(userDetail);
    }

    //setState(() {});
    return _searchResult;
  }

  Widget _customDropDownError(BuildContext context, ErrorData? item) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: Text(item.error!),
    );
  }

  Widget _customPopupItemBuilderError(
      BuildContext context, ErrorData? item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item?.error ?? '',
          style: bodyText2(colorText),
        ),
      ),
    );
  }

  Future<List<ErrorData>> getErrorData(String? filter) async {
    List<ErrorData> _searchResult = [];

    print(filter);
    for (var userDetail in errorList) {
      if (userDetail.error!.toLowerCase().contains(filter!.toLowerCase()))
        _searchResult.add(userDetail);
      // print(userDetail);
    }

    //setState(() {});
    return _searchResult;
  }

  Widget _customDropDownSystem(BuildContext context, SystemListData? item) {
    if (item == null) {
      return Container();
    }

    return Container(
      child: Text(item.name!),
    );
  }

  Widget _customPopupItemBuilderSystem(
      BuildContext context, SystemListData? item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item?.name ?? '',
          style: bodyText2(colorText),
        ),
      ),
    );
  }

  Future<List<SystemListData>> getSystemData(String? filter) async {
    List<SystemListData> _searchResult = [];

    print(filter);
    for (var userDetail in systemList) {
      if (userDetail.name!.toLowerCase().contains(filter!.toLowerCase()))
        _searchResult.add(userDetail);
      // print(userDetail);
    }

    //setState(() {});
    return _searchResult;
  }

  @override
  void onError(int errorCode) {
    CheckResponseCode.getResponseCode(errorCode, context);
  }

  @override
  void onSitesListSuccess(SiteListResponse data) {
    print(data);

    siteList = [];
    if (data.status == 200) {
      setState(() {
        siteList = data.results!;
      });
    }
  }

  @override
  void onErrorListSuccess(ErrorListResponse data) {
    print(data);

    errorList = [];
    if (data.status == 200) {
      setState(() {
        errorList = data.errorList!;
      });
    }
  }

  @override
  void onSystemListSuccess(SystemListResponse data) {
    print(data);

    systemList = [];
    if (data.status! == 200) {
      setState(() {
        systemList = data.results!;
      });
    }
  }

  @override
  void onCreateRequestSuccess(CommonResponse data) {
    toastMassage(data.msg!);
    if (data.status! == 200) {
      //Get.back();

      Get.offAllNamed('/main_screen');
      Get.toNamed('/management_request_list',
          arguments: [false, Constant.open]);

      setState(() {
        _errorSearchController.clear();
        _companySearchController.clear();
        _systemSearchController.clear();
        commentController.clear();
      });
    }
  }
}
