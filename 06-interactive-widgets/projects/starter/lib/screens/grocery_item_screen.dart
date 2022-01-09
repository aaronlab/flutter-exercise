import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';
import '../models/grocery_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/grocery_item.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;

  final Function(GroceryItem) onUpdate;

  final GroceryItem? originalItem;

  final bool isUpdating;

  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _GroceryItemScreen createState() => _GroceryItemScreen();
}

class _GroceryItemScreen extends State<GroceryItemScreen> {
  final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColour = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();

    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColour = originalItem.color;

      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColour,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );

              if (widget.isUpdating) {
                widget.onUpdate(groceryItem);
              } else {
                widget.onCreate(groceryItem);
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
        elevation: 0.0,
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(context),
            buildImportanceField(context),
            buildDateField(context),
            buildTimeField(context),
            buildColorPicker(context),
            const SizedBox(
              height: 10.0,
            ),
            buildQuantityField(context),
            GroceryTile(
              item: GroceryItem(
                id: 'previewMode',
                name: _name,
                color: _currentColour,
                importance: _importance,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: GoogleFonts.lato(
            fontSize: 28.0,
          ),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColour,
          decoration: InputDecoration(
            hintText: 'E.g. Apples, Banana, 1 Bag of salt',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColour),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColour),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImportanceField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'low',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              selected: _importance == Importance.low,
              onSelected: (selected) {
                setState(() => _importance = Importance.low);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'medium',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              selected: _importance == Importance.medium,
              onSelected: (selected) {
                setState(() => _importance = Importance.medium);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              label: const Text(
                'high',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              selected: _importance == Importance.high,
              onSelected: (selected) {
                setState(() => _importance = Importance.high);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
              child: const Text(
                'Select',
              ),
              onPressed: () async {
                _showDatePicker(context);
              },
            ),
          ],
        ),
        Text(
          '${DateFormat('yyyy-MM-dd').format(_dueDate)}',
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) async {
    final currentDate = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(currentDate.year + 5),
    );

    setState(() {
      if (selectedDate != null) {
        _dueDate = selectedDate;
      }
    });
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
              onPressed: () async {
                _showTimePicker(context);
              },
              child: const Text(
                'Select',
              ),
            ),
          ],
        ),
        Text(
          '${_timeOfDay.format(context)}',
        ),
      ],
    );
  }

  void _showTimePicker(BuildContext context) async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    setState(() {
      if (timeOfDay != null) {
        _timeOfDay = timeOfDay;
      }
    });
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50.0,
              width: 10.0,
              color: _currentColour,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              'Color',
              style: GoogleFonts.lato(
                fontSize: 28.0,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () async {
            _showColorPicker(context);
          },
          child: const Text(
            'Select',
          ),
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: BlockPicker(
            pickerColor: Colors.white,
            onColorChanged: (colour) {
              setState(() => _currentColour = colour);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildQuantityField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        Slider(
          inactiveColor: _currentColour.withOpacity(0.5),
          activeColor: _currentColour,
          value: _currentSliderValue.toDouble(),
          min: 0.0,
          max: 100.0,
          divisions: 100,
          label: _currentSliderValue.toInt().toString(),
          onChanged: _sliderValueChanged,
        ),
      ],
    );
  }

  void _sliderValueChanged(double value) {
    setState(() {
      _currentSliderValue = value.toInt();
    });
  }
}
