import 'package:flutter/material.dart';
import 'common_variables.dart';

const genderSelection = 'Gender';
const nationalitySelection = 'Nationality';
const codeSelection = 'Codes';

// ignore: must_be_immutable
class DropDownSelector extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  late List<String> options = ['Select'];
  late String type = 'Unkown';
  DropDownSelector({Key? key, required this.options, required this.type})
      : super(key: key);

  @override
  State<DropDownSelector> createState() =>
      // ignore: no_logic_in_create_state
      _DropDownSelectorState(options, type);
}

class _DropDownSelectorState extends State<DropDownSelector> {
  List<String> options = [];
  String type = '';
  _DropDownSelectorState(this.options, this.type);
  String dropdownValue = 'Select';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: Colors.deepPurple,
      ),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          if (type == genderSelection) {
            selectedGender = dropdownValue;
          } else if (type == nationalitySelection) {
            selectedNationality = dropdownValue;
          } else if (type == codeSelection) {
            selectedCode = dropdownValue;
          }
        });
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
              width: 180,
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(fontSize: 13),
              ),
            ));
      }).toList(),
    );
  }
}

class DateSelectButton extends StatefulWidget {
  const DateSelectButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DateSelectButtonState();
}

class DateSelectButtonState extends State<DateSelectButton> {
  void callSelector() {}
  void _onSelectionChanged(DateTime args) {
    selectedDate = args.toString();
  }

  void showSelector(BuildContext context) async {
    showDialog(
        context: context,
        builder: (constext) {
          return AlertDialog(
            title: const Text("Select Date of Birth"),
            content: SizedBox(
              child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.parse('1900-01-01'),
                  lastDate: DateTime.now(),
                  onDateChanged: _onSelectionChanged),
              width: MediaQuery.of(context).size.width,
              height: 200,
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => showSelector(context),
        child: const Icon(
          Icons.date_range_rounded,
          color: Colors.deepPurple,
        ));
  }
}
