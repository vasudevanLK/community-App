import 'package:VASZ_Club/screens/home_screen.dart';
import 'package:VASZ_Club/screens/profile_screen.dart';
import 'package:VASZ_Club/screens/startroom_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.75);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height * 0.75);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height / 2, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Modern curved design resembling waves
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 102, 186, 255), // Container background color
                ),
                child: Center(
                  child: Text(
                    'Rolling Round Events',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Events near your city
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Events near your city Madurai, Tamil Nadu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
            ),
            // List of curved items with event details
            Container(
              padding: EdgeInsets.only(left: 05), // Add left padding
              child: Column(
                children: [
                  _buildEventItem(
                    'Dec 14',
                    'Thursday',
                    'Generative AI Event',
                    '123 Main St, Madurai',
                    true,
                    generateRandomNumber(),
                    generateRandomNumber(),
                  ),
                  _buildEventItem(
                    'Dec 15',
                    'Friday',
                    'New Trends of Web development',
                    '456 Elm St, Madurai',
                    false,
                    generateRandomNumber(),
                    generateRandomNumber(),
                  ),
                  _buildEventItem(
                    'Dec 06',
                    'Monday',
                    'Business Ideas',
                    '456 Elm St, Madurai',
                    false,
                    generateRandomNumber(),
                    generateRandomNumber(),
                  ),
                  // Add more items using ListView.builder for dynamic details
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return _buildEventItem(
                        'Dec ${index + 16}',
                        'Day ${index + 3}',
                        'Event Details ${index + 3}',
                        '789 Oak St, Madurai',
                        true,
                        generateRandomNumber(),
                        generateRandomNumber(),
                      );
                    },
                  ),
                  // Add more items as needed
                ],
              ),
            ),
            // Bold text "ALL EVENTS"
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'ALL EVENTS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // List of curved items with event details for different states and cities
            Container(
              padding: EdgeInsets.only(left: 05), // Add left padding
              child: Column(
                children: [
                  _buildEventItem(
                    'Dec 14',
                    'Thursday',
                    'Event in Another City',
                    '123 Main St, Another City',
                    true,
                    generateRandomNumber(),
                    generateRandomNumber(),
                  ),
                  _buildEventItem(
                    'Dec 15',
                    'Friday',
                    'Tech Conference in Different State',
                    '456 Elm St, Different State',
                    false,
                    generateRandomNumber(),
                    generateRandomNumber(),
                  ),
                  _buildEventItem(
                    'Dec 06',
                    'Monday',
                    'Startup Meetup in Another State',
                    '789 Oak St, Another State',
                    false,
                    generateRandomNumber(),
                    generateRandomNumber(),
                  ),
                  // Add more items using ListView.builder for dynamic details
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return _buildEventItem(
                        'Dec ${index + 16}',
                        'Day ${index + 3}',
                        'Event Details ${index + 3}',
                        '123 Elm St, Different City',
                        true,
                        generateRandomNumber(),
                        generateRandomNumber(),
                      );
                    },
                  ),
                  // Add more items as needed
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Color.fromARGB(255, 37, 37, 37),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  navigateToPage(index);
                });
              },
              items: [
                _buildNavItem(
                  icon: Icons.home,
                  label: 'Home',
                  index: 1,
                ),
                _buildNavItem(
                  icon: Icons.calendar_today,
                  label: 'Events',
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.person,
                  label: 'Profile',
                  index: 2,
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final selectedColor = Colors.green; // Customize selected color
    final unselectedColor = Colors.blue; // Customize unselected color

    return BottomNavigationBarItem(
      icon: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
            navigateToPage(index); // Call the navigate function
          });
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: _currentIndex == index
                ? selectedColor.withOpacity(0.2)
                : Colors.transparent,
          ),
          child: Icon(
            icon,
            color: _currentIndex == index ? selectedColor : unselectedColor,
          ),
        ),
      ),
      label: label,
    );
  }

  int generateRandomNumber() {
    return Random().nextInt(100) + 1;
  }

  Widget _buildEventItem(
    String date,
    String day,
    String details,
    String address,
    bool isPaid,
    int membersCount,
    int authorsNumber,
  ) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: 10, horizontal: 5), // Adjust margin
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: .5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      isPaid ? 'Paid Event' : 'Free Event',
                      style: TextStyle(
                        fontSize: 14,
                        color: isPaid ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$membersCount members',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Author: $authorsNumber',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Address: $address',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        // event screen is the current screen, no need to navigate
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profilePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StartRoomPage()),
        );
        break;
    }
  }
}
