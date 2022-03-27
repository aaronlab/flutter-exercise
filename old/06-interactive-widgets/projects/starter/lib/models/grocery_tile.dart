import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'grocery_item.dart';

class GroceryTile extends StatelessWidget {
  final GroceryItem item;
  final Function(bool?)? onComplete;
  final TextDecoration textDecoration;

  GroceryTile({
    Key? key,
    required this.item,
    this.onComplete,
  })  : textDecoration =
            item.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO 21: Change this widget
    return Container(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 5.0,
                color: item.color,
              ),
              const SizedBox(
                width: 16.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.lato(
                      decoration: textDecoration,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  buildDate(),
                  const SizedBox(
                    height: 4.0,
                  ),
                  buildImportance(),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                item.quantity.toString(),
                style: GoogleFonts.lato(
                  decoration: textDecoration,
                  fontSize: 21.0,
                ),
              ),
              buildCheckbox(),
            ],
          )
        ],
      ),
    );
  }

  Widget buildImportance() {
    final importance = item.importance;
    final description =
        StringUtils.capitalize(importance.toString().split('.').last);

    return Text(
      description,
      style: importance == Importance.low
          ? GoogleFonts.lato(
              decoration: textDecoration,
            )
          : importance == Importance.medium
              ? GoogleFonts.lato(
                  fontWeight: FontWeight.w800,
                  decoration: textDecoration,
                )
              : GoogleFonts.lato(
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                  decoration: textDecoration,
                ),
    );
  }

  Widget buildDate() {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(item.date);
    return Text(
      dateString,
      style: TextStyle(
        decoration: textDecoration,
      ),
    );
  }

  Widget buildCheckbox() {
    return Checkbox(
      value: item.isComplete,
      onChanged: onComplete,
    );
  }
}
