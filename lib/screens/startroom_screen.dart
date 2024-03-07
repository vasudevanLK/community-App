import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartRoomPage(),
    );
  }
}

class StartRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community App'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.green],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                'Your Room',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Community Room',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  buildRoomDetails(
                    roomName: 'Digital Enthusiasts',
                    roomId: '123456',
                    address: '123 Main Street, Cityville',
                    paid: true,
                    authorNumbers: 3,
                    dateTime: 'March 7, 2024 10:00 AM',
                  ),
                  SizedBox(height: 16),
                  // Add input fields for user input
                  InputFields(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle form submission
        },
        child: Icon(Icons.save),
      ),
    );
  }

  Widget buildRoomDetails({
    required String roomName,
    required String roomId,
    required String address,
    required bool paid,
    required int authorNumbers,
    required String dateTime,
  }) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              roomName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Room ID: $roomId'),
            Text('Address: $address'),
            Text('Paid: ${paid ? 'Yes' : 'No'}'),
            Text('Author Numbers: $authorNumbers'),
            Text('Date Time: $dateTime'),
          ],
        ),
      ),
    );
  }
}

class InputFields extends StatefulWidget {
  @override
  _InputFieldsState createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomIdController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController authorNumbersController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return _buildDatePicker(context);
      },
    );

    // ignore: unnecessary_null_comparison
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return _buildTimePicker(context);
      },
    );

    // ignore: unnecessary_null_comparison
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Widget _buildDatePicker(BuildContext context) {
    return Container(
      height: 200,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: selectedDate,
        onDateTimeChanged: (DateTime newDate) {
          setState(() {
            selectedDate = newDate;
          });
        },
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return Container(
      height: 200,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        ),
        onDateTimeChanged: (DateTime newDate) {
          setState(() {
            selectedTime = TimeOfDay(
              hour: newDate.hour,
              minute: newDate.minute,
            );
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: roomNameController,
          decoration: InputDecoration(labelText: 'Room Name'),
        ),
        TextField(
          controller: roomIdController,
          decoration: InputDecoration(labelText: 'Room ID'),
        ),
        TextField(
          controller: addressController,
          decoration: InputDecoration(labelText: 'Address'),
        ),
        TextField(
          controller: authorNumbersController,
          decoration: InputDecoration(labelText: 'Author Numbers'),
          keyboardType: TextInputType.number,
        ),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextField(
              controller: dateTimeController,
              decoration: InputDecoration(labelText: 'Date Time'),
            ),
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectTime(context),
          child: AbsorbPointer(
            child: TextField(
              controller: dateTimeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
          ),
        ),
      ],
    );
  }
}
