import 'dart:convert';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fit_page_test/common/utils.dart';
import 'package:fit_page_test/model/web_services.dart';
import 'package:fit_page_test/page/scans_details_page.dart';
import 'package:flutter/material.dart';

import '/common/constraints.dart';
import '/model/prefrence_utils.dart';

class ScansListPage extends StatefulWidget {
  const ScansListPage({Key? key}) : super(key: key);

  @override
  State<ScansListPage> createState() => _ScansListPageState();
}

class _ScansListPageState extends State<ScansListPage> {
  // List
  List arrScansList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (() {
      initData(true);
    }));
  }

  Future<void> initData([bool needFetchData = false]) async {
    String strJsonData =
        await PrefrenceUtils.getStringValueFromKey(key: keyScanData) ?? "";
    if (strJsonData.isNotEmpty) {
      arrScansList.clear();
      arrScansList.addAll(json.decode(strJsonData));

      setState(() {});
      return;
    }

    if (arrScansList.isEmpty && needFetchData) {
      fetchDataFromAPI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorDarkBlue,
      appBar: _getAppBar(),
      body: _getBody(),
    );
  }

  //Widgets
  PreferredSizeWidget _getAppBar() {
    return AppBar(
      title: const Text(appTitle),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _getBody() {
    return ListView.builder(
      itemCount: arrScansList.length,
      itemBuilder: (itemContext, itemIndex) {
        Map scanObj = arrScansList[itemIndex];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ScansDetailPage(
                  scanObj: scanObj,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: DottedDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scanObj["name"],
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  scanObj["tag"],
                  style: TextStyle(
                    color: (colorStringToColor
                            .containsKey(scanObj["color"].toString()))
                        ? colorStringToColor[scanObj["color"].toString()]
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // API Calls
  Future<void> fetchDataFromAPI() async {
    if (!await WS.checkInternet()) {
      Utils.showAlert(strMsg: noInternet, context: context);
      return;
    }

    Utils.showProgress(context);
    WSResponse response = await WS.getAPICall(url: apiData);

    if (response.success) {
      await PrefrenceUtils.setStringValueWithKey(
          key: keyScanData, value: response.body);
      if (!mounted) return;
      Utils.dismissProgress(context);
      initData(false);
    } else {
      if (!mounted) return;
      Utils.dismissProgress(context);
      Utils.showAlert(strMsg: response.msg, context: context);
    }
  }

  // Dispose
  @override
  void dispose() {
    super.dispose();
  }
}
