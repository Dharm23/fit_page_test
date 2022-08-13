import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import '../common/constraints.dart';

class VariableDetailsPage extends StatefulWidget {
  final Map criteriaObj;
  final String selectedVarible;

  const VariableDetailsPage({
    Key? key,
    required this.criteriaObj,
    required this.selectedVarible,
  }) : super(key: key);

  @override
  State<VariableDetailsPage> createState() => _VariableDetailsPageState();
}

class _VariableDetailsPageState extends State<VariableDetailsPage> {
  // Map

  late Map criteriaObj;
  late Map arrVariables;
  late Map selectedItem;

  // String
  late String selectedVarible;

  //
  final TextEditingController _txtIndicator = TextEditingController();

  @override
  void initState() {
    criteriaObj = widget.criteriaObj;
    selectedVarible = widget.selectedVarible;
    arrVariables = Map.from(criteriaObj["variable"]);
    selectedItem = arrVariables[selectedVarible];
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
            Text((selectedItem["type"] == "indicator")
                ? selectedItem["study_type"].toString().toUpperCase()
                : selectedItem["values"].first.toString()),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _getBody() {
    if (selectedItem["type"] == "indicator") {
      return _getIndicator();
    } else {
      return _getVariableWidget();
    }
  }

  Widget _getIndicator() {
    _txtIndicator.text = selectedItem["default_value"].toString();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Set Parameters",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Period"),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: TextField(
                    controller: _txtIndicator,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getVariableWidget() {
    List arrValues = List.from(selectedItem["values"]);

    return ListView.builder(
      itemCount: arrValues.length,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      itemBuilder: (itemContext, itemIndex) {
        return GestureDetector(
          onTap: () async {},
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: DottedDecoration(
              color: Colors.white,
            ),
            child: Text(
              arrValues[itemIndex].toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _txtIndicator.dispose();
    super.dispose();
  }
}
