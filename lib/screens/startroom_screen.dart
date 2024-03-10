import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StartRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Community App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Add Room',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
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
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3366FF),
                          ),
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
          ),
        ),
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

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedInputField(
          controller: roomNameController,
          label: 'Room Name',
        ),
        SizedBox(height: 8),
        OutlinedInputField(
          controller: roomIdController,
          label: 'Room ID',
        ),
        SizedBox(height: 8),
        OutlinedInputField(
          controller: addressController,
          label: 'Address',
        ),
        SizedBox(height: 8),
        OutlinedInputField(
          controller: authorNumbersController,
          label: 'Author Numbers',
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: OutlinedInputField(
              controller: TextEditingController(
                text: selectedDate.toString().split(' ')[0],
              ),
              label: 'Date',
            ),
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectTime(context),
          child: AbsorbPointer(
            child: OutlinedInputField(
              controller: TextEditingController(
                text: selectedTime.format(context),
              ),
              label: 'Time',
            ),
          ),
        ),
      ],
    );
  }
}

class OutlinedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;

  const OutlinedInputField({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StartRoomPage(),
  ));
}
