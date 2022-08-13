import 'package:fit_page_test/page/variable_details_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../common/constraints.dart';

class ScansDetailPage extends StatefulWidget {
  final Map scanObj;

  const ScansDetailPage({
    Key? key,
    required this.scanObj,
  }) : super(key: key);

  @override
  State<ScansDetailPage> createState() => _ScansDetailPageState();
}

class _ScansDetailPageState extends State<ScansDetailPage> {
  // List
  List arrCriteria = [];

  // Map
  late Map scanObj;

  @override
  void initState() {
    scanObj = widget.scanObj;
    arrCriteria.clear();
    arrCriteria.addAll(scanObj["criteria"]);
    super.initState();
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
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(scanObj["name"].toString()),
            Text(
              scanObj["tag"],
              style: TextStyle(
                color: (colorStringToColor
                        .containsKey(scanObj["color"].toString()))
                    ? colorStringToColor[scanObj["color"].toString()]
                    : Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _getBody() {
    return ListView.builder(
      itemCount: arrCriteria.length,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      itemBuilder: (itemContext, itemIndex) {
        Map criteriaObj = Map.from(arrCriteria[itemIndex]);
        if (criteriaObj["type"] == "variable") {
          return _getVariableCell(criteriaObj, itemIndex);
        }
        return _getPlainTextCell(criteriaObj, itemIndex);
      },
    );
  }

  Widget _getPlainTextCell(Map criteriaObj, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          criteriaObj["text"],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        (index < (arrCriteria.length - 1))
            ? Column(
                children: const [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "and",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  Widget _getVariableCell(Map criteriaObj, int index) {
    List<String> arrText = criteriaObj["text"].toString().split(" ");
    Map arrVariables = Map.from(criteriaObj["variable"]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            children: arrText.map((e) {
              return TextSpan(
                text: (e.contains("\$"))
                    ? (arrVariables[e]["type"] == "indicator")
                        ? "(${arrVariables[e]["default_value"]}) "
                        : "(${arrVariables[e]["values"].first}) "
                    : "$e ",
                style: TextStyle(
                  color: (e.contains("\$")) ? Colors.blue : Colors.white,
                  fontSize: 16,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (_) => VariableDetailsPage(
                          criteriaObj: criteriaObj,
                          selectedVarible: e,
                        ),
                      ),
                    )
                        .then((value) {
                      if (value != null) {
                        scanObj = value;
                        arrCriteria.clear();
                        arrCriteria.addAll(List.from(scanObj["criteria"]));
                        setState(() {});
                      }
                    });
                  },
              );
            }).toList(),
          ),
        ),
        (index < (arrCriteria.length - 1))
            ? Column(
                children: const [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "and",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
