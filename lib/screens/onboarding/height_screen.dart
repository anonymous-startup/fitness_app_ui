import 'package:fitness_app/constants.dart';
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
  final double _imageHeight  = getProportionateScreenHeight(400);

  List<GlobalKey> listKeys = List<GlobalKey>.generate(150,(index) => GlobalKey());
  final GlobalKey _specifiedAreaKey = GlobalKey();

  double _height = 250;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollController.jumpTo((_height) * 20);
    // });
  }

  void _updateHeightFromScroll() {
    final RenderBox? specifiedAreaBox = _specifiedAreaKey.currentContext?.findRenderObject() as RenderBox?;
    if (specifiedAreaBox == null) return; // Ensure specifiedAreaBox is not null

    final specifiedAreaPosition = specifiedAreaBox.localToGlobal(Offset.zero);
    final specifiedAreaY = specifiedAreaPosition.dy;

    double minDistance = double.infinity;
    int closestIndex = 0;

    for (int index = 0; index < listKeys.length; index++) {
      final RenderBox? box = listKeys[index].currentContext?.findRenderObject() as RenderBox?;
      if (box == null) continue; 
      final position = box.localToGlobal(Offset.zero);
      final y = position.dy;
      final distance = (y - specifiedAreaY).abs();
      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = index;
      }
    }

    setState(() {
      _height = 250.0 - closestIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    double scaleItemHeight = 20.0; // Height of each scale item
    double scaleTopOffset = (_imageHeight / 2.5); 
    return Column(
      children: [
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
          onPressed: (index) {
            setState(() {
              _toggleSelected[0] = false;
              _toggleSelected[1] = false;
              _toggleSelected[index] = true;
              isCm = index == 0 ? false : true;
            });
          },
          fillColor: primaryColor,
          children: [
            Text(
              'cm',
              style: TextStyle(
                color: _toggleSelected[0] ? Colors.white : Colors.black,
              ),
            ),
            Text(
              'ft',
              style: TextStyle(
                color: _toggleSelected[1] ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),

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
                                  top: scaleTopOffset - (_height - 100) * scaleItemHeight / 20,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${_height.toStringAsFixed(1)} cm',
                                        style: TextStyle(
                                          fontSize: getProportionateScreenHeight(24),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        key: _specifiedAreaKey,
                                        margin: EdgeInsets.only(left: getProportionateScreenWidth(270)),
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
                        width: getProportionateScreenWidth(50),
                        height: getProportionateScreenHeight(400),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (scrollNotification is ScrollUpdateNotification) {
                              _updateHeightFromScroll();
                            }
                            return true;
                          },
                          child: ListView.builder(
                            // key: _listViewKey,
                            controller: _scrollController,
                            itemCount: 150, // To create scale from 100 to 200
                            itemBuilder: (context, index) {
                              final heightValue = 250 - index;
                              return Container(
                                key: listKeys[index],
                                height: 20,
                                alignment: Alignment.center,
                                child: Text(
                                  '$heightValue',
                                  style: TextStyle(fontSize: getProportionateScreenHeight(12)),
                                ),
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
    
      ]
    );
  }
}