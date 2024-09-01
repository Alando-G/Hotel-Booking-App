import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _location = '';
  DateTime _checkInDate = DateTime.now();
  DateTime _checkOutDate = DateTime.now().add(Duration(days: 1));
  int _guests = 1;

  final TextEditingController _locationController = TextEditingController();

  void _search() {
    // Handle the search logic here
    // For example, navigate to a results screen with the search parameters
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLocationField(),
              SizedBox(height: 16),
              _buildDateSelector('Check-in Date', _checkInDate, (selectedDate) {
                if (selectedDate != null) {
                  setState(() {
                    _checkInDate = selectedDate;
                  });
                }
              }),
              SizedBox(height: 16),
              _buildDateSelector('Check-out Date', _checkOutDate, (selectedDate) {
                if (selectedDate != null) {
                  setState(() {
                    _checkOutDate = selectedDate;
                  });
                }
              }),
              SizedBox(height: 16),
              _buildGuestsSelector(),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _search,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 14, 13, 13), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    elevation: 5,
                  ),
                  child: Text('Search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _locationController,
        decoration: InputDecoration(
          labelText: 'Location',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
        ),
        onChanged: (value) {
          setState(() {
            _location = value;
          });
        },
      ),
    );
  }

  Widget _buildDateSelector(String label, DateTime selectedDate, ValueChanged<DateTime?> onDateSelected) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        onDateSelected(pickedDate);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.blueAccent),
              SizedBox(width: 12),
              Text(
                '${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.year}',
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuestsSelector() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select Number of Guests'),
              content: NumberPicker(
                minValue: 1,
                maxValue: 10,
                value: _guests,
                onChanged: (value) {
                  setState(() {
                    _guests = value;
                  });
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Guests',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          child: Row(
            children: [
              Icon(Icons.people, color: Colors.blueAccent),
              SizedBox(width: 12),
              Text('$_guests Guests', style: TextStyle(fontSize: 16)),
              Spacer(),
              Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberPicker extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final ValueChanged<int> onChanged;

  NumberPicker({
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove, color: Colors.deepOrangeAccent),
              onPressed: value > minValue
                  ? () => onChanged(value - 1)
                  : null,
            ),
            Text('$value', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(Icons.add, color: Colors.deepOrangeAccent),
              onPressed: value < maxValue
                  ? () => onChanged(value + 1)
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
