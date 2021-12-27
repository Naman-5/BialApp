import 'package:flutter/material.dart';

class BarItem {
  BarItem({
    required this.label,
    required this.iconData,
    required this.page,
    this.color = Colors.grey,
    this.navigateToPage = true,
  });

  String label;
  IconData iconData;
  Color? color;
  bool navigateToPage;
  Widget page;
}

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.barItems,
    required this.onTap,
    this.animationDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  final List<BarItem> barItems;
  final Duration animationDuration;
  final Curve curve;
  final void Function(int) onTap;

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with TickerProviderStateMixin {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildBarItems(),
      ),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> _barItemWidgets = [];

    for (var i = 0; i < widget.barItems.length; i++) {
      var item = widget.barItems[i];
      bool isSelected = (selectedIndex == i);

      _barItemWidgets.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          if (item.navigateToPage) {
            setState(() {
              selectedIndex = i;
              widget.onTap(selectedIndex);
            });
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => item.page));
          }
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.symmetric(vertical: 5),
          duration: widget.animationDuration,
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
              color: isSelected
                  ? item.color?.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          child: Row(
            children: [
              Icon(
                item.iconData,
                size: 30,
                color: item.color,
              ),
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    item.label,
                    style: TextStyle(
                        color: item.color,
                        fontWeight: FontWeight.w900,
                        fontSize: 17),
                  ),
                ),
            ],
          ),
        ),
      ));
    }
    return _barItemWidgets;
  }
}
