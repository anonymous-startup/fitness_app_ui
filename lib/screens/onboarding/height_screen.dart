import 'package:fitness_app/constants.dart';
import 'package:fitness_app/screens/onboarding/models/onboarding_data_model.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  final List<bool> _toggleSelected = [false, true];
  late bool isCm = _toggleSelected[1];
  String imagePath = "assets/images/onboarding/person_height.png";
  final double _imageHeight = getProportionateScreenHeight(400);

  final ScrollController _scrollController = ScrollController();

  List<GlobalKey> cmlistKeys =
      List<GlobalKey>.generate(151, (index) => GlobalKey());
  final GlobalKey _specifiedAreaKey = GlobalKey();

  List<GlobalKey> ftlistKeys =
      List<GlobalKey>.generate(61, (index) => GlobalKey());

  double _height = 250;
  double scaleItemHeight = 20.0; // Height of each scale item
  double scaleTopOffset = 175;
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    OnboardingDataModel.height = _height;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollController.jumpTo((_height) * 20);
    // });
  }

  void toggleChoce(index) {
    setState(() {
      _scrollController.jumpTo(0);
      _toggleSelected[0] = false;
      _toggleSelected[1] = false;
      _toggleSelected[index] = true;
      isCm = index == 0 ? false : true;
      scaleTopOffset =  isCm ? 175 : 0;
      _height = isCm ? 250 : 80;
    });
  }

  void _updateHeightFromScroll() {
    final RenderBox? specifiedAreaBox =
        _specifiedAreaKey.currentContext?.findRenderObject() as RenderBox?;
    if (specifiedAreaBox == null) return; // Ensure specifiedAreaBox is not null

    final specifiedAreaPosition = specifiedAreaBox.localToGlobal(Offset.zero);
    final specifiedAreaY = specifiedAreaPosition.dy;

    double minDistance = double.infinity;
    int closestIndex = 0;
    List<GlobalKey> listKeys = isCm ? cmlistKeys : ftlistKeys;
    for (int index = 0; index < listKeys.length; index++) {
      final RenderBox? box =
          listKeys[index].currentContext?.findRenderObject() as RenderBox?;
      if (box == null) continue; // Ensure box is not null

      final position = box.localToGlobal(Offset.zero);
      final y = position.dy;
      final distance = (y - specifiedAreaY).abs();
      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = index;
      }
    }

    setState(() {
      _height = isCm ? (250.0 - closestIndex) : (80.0 - closestIndex);
      OnboardingDataModel.height = _height;
      OnboardingDataModel.isCm = isCm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //Ttile
      Center(
        child: Text(
          'Whats your Body Weight?',
          style: TextStyle(
            fontSize: getProportionateScreenHeight(25),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      //Switch in cm/ft
      ToggleButtons(
        borderWidth: 2,
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        constraints: const BoxConstraints(
          minWidth: 50,
          minHeight: 30,
        ),
        isSelected: _toggleSelected,
        onPressed: (index) => toggleChoce(index),
        fillColor: primaryColor,
        children: [
          Text(
            'ft',
            style: TextStyle(
              color: _toggleSelected[0] ? Colors.white : Colors.black,
            ),
          ),
          Text(
            'cm',
            style: TextStyle(
              color: _toggleSelected[1] ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),

      //Height scale
      Expanded(
        child: Center(
          child: ClipRect(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            top:  (scaleTopOffset -
                                    (_height - 100) * scaleItemHeight / 20),
                            child: Column(
                              children: [
                                Text(
                                  isCm
                                      ? '${_height.toStringAsFixed(1)} cm'
                                      : '${(_height / 10).toStringAsFixed(1)} ft',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(24),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  key: _specifiedAreaKey,
                                  margin: EdgeInsets.only(
                                      left: getProportionateScreenWidth(270)),
                                  color: primaryColor,
                                  height: getProportionateScreenHeight(1),
                                  width: getProportionateScreenWidth(400),
                                ),
                                Image.asset(
                                  imagePath,
                                  height: _imageHeight,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  width: getProportionateScreenWidth(70),
                  height: getProportionateScreenHeight(400),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification) {
                        _updateHeightFromScroll();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: isCm ? 151 : 60,
                      itemBuilder: (context, index) {
                        final heightValue = isCm ? (250 - index) : (80 - index);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 14,
                              alignment: Alignment.center,
                              child: Text(
                                index % 10 == 0
                                    ? '${isCm ? heightValue : (heightValue / 10)}'
                                    : '',
                                style: TextStyle(
                                    fontSize: getProportionateScreenHeight(12)),
                              ),
                            ),
                            Divider(
                              key: isCm ? cmlistKeys[index] : ftlistKeys[index],
                              indent: index % 10 == 0
                                  ? 0
                                  : getProportionateScreenWidth(18),
                              color: Colors.black,
                              thickness: index % 10 == 0
                                  ? getProportionateScreenHeight(2)
                                  : getProportionateScreenHeight(1),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
