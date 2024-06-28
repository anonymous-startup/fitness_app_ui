import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/onboarding/models/onboarding_data_model.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class SelectionDropDown extends StatefulWidget {
  const SelectionDropDown(
      {super.key, required this.title, required this.injuries});
  final String title;
  final List<String> injuries;

  @override
  State<SelectionDropDown> createState() => _SelectionDropDownState();
}

class _SelectionDropDownState extends State<SelectionDropDown> {
  final Set<int> selectedItems = {};
  ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    List<String> items = List<String>.generate(
        widget.injuries.length, (index) => widget.injuries[index]);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      margin: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(14),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Row(children: [
            Image.asset(
              'assets/images/onboarding/muscle_pain.png',
              width: getProportionateScreenWidth(37),
            ),
            SizedBox(
              width: getProportionateScreenWidth(20),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          controller: controller,
          children: List.generate(items.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  if (selectedItems.contains(index)) {
                    selectedItems.remove(index);
                    OnboardingDataModel.injuries.remove(items[index]);
                  } else {
                    selectedItems.add(index);
                    OnboardingDataModel.injuries.add(items[index]);
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedItems.contains(index)
                            ? primaryColor
                            : const Color.fromARGB(255, 145, 146, 147),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: ListTile(
                        title: Text(items[index]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
