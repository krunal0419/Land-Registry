import 'package:flutter/material.dart';

class MenuItemTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final double titleSize;
  final double iconSize;
  final bool isSelected;
  final onTap;

  const MenuItemTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.titleSize, // Added title size property
    required this.iconSize, // Added icon size property
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  _MenuItemTileState createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<MenuItemTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(10),
          ),
          color: widget.isSelected ? Color(0xFF760E00) : Color(0xFFE3341C),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: 40,
        height:100, //_animation.value,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 28), // Add padding here
              child: Icon(
                widget.icon,
                color: widget.isSelected ? Colors.white : Colors.white60,
                size: 50, // Use iconSize property for icon size
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Text(
                widget.title,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: widget.isSelected ? Colors.white : Colors.white70,
                  fontSize: 40, // Use titleSize property for title size
                  fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w300,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
