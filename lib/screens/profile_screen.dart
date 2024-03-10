import 'dart:async';
import 'dart:math';

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ProfileBody(),
      ),
    );
  }
}


class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with TickerProviderStateMixin {
  bool isImageTapped = false;
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  int chasersCount = 1000;
  int followersCount = 500;
  double rating = 4.5;

  List<RoomHistory> roomHistories = [
    RoomHistory('Room 1', 'Location 1', DateTime(2022, 3, 9), 100),
    RoomHistory('Room 2', 'Location 2', DateTime(2022, 3, 8), 150),
    RoomHistory('Room 3', 'Location 3', DateTime(2022, 3, 7), 120),
  ];

  List<String> skills = [
    'Web Designer',
    'Developer',
    'Investor',
    'Editor',
    'Entrepreneur',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Simulate increase in counts every hour
    Timer.periodic(Duration(hours: 1), (timer) {
      setState(() {
        chasersCount += Random().nextInt(50);
        followersCount += Random().nextInt(20);
        rating = max(0.0, min(5.0, rating + (Random().nextDouble() - 0.5)));
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF36393E),
      body: Stack(
        children: [
          WaveCurve(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isImageTapped = !isImageTapped;
                      });
                    },
                    child: Hero(
                      tag: 'userImage',
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            margin: EdgeInsets.only(top: 20),
                            height: isImageTapped ? 120 : 80,
                            width: isImageTapped ? 120 : 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4.0,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://example.com/your_image_url.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: FadeTransition(
                              opacity: _fadeInAnimation,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Follow button and rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Followers: $followersCount',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Rating: ${rating.toStringAsFixed(1)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Left side details
                  ElevatedContainer(
                    color: Color.fromARGB(131, 54, 54, 54),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailRow('Email', 'john.doe@example.com'),
                        DetailRow('Followers', '$followersCount'),
                        DetailRow('Job', 'Software Developer'),
                      ],
                    ),
                  ),

                  // Right side details
                  ElevatedContainer(
                    color: Color.fromARGB(131, 54, 54, 54),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DetailRow('Chasers', '$chasersCount'),
                            AnimateIcon(
                              key: UniqueKey(),
                              onTap: () {
                                // Handle icon tap
                              },
                              iconType: IconType.continueAnimation,
                              height: 70,
                              width: 70,
                              color: Color.fromRGBO(
                                  Random.secure().nextInt(255),
                                  Random.secure().nextInt(255),
                                  Random.secure().nextInt(255),
                                  1),
                              animateIcon: AnimateIcons.bell,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Skills section
                  SizedBox(height: 20),
                  GlassContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Skills',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: skills.length,
                          itemBuilder: (context, index) {
                            return Chip(
                              label: Text(
                                skills[index],
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor:
                                  Color.fromARGB(50, 255, 255, 255),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Profile details section
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Text(
                      'Created rooms as an author 5 times for full-stack developers.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  // Room histories section
                  SizedBox(height: 20),
                  Text(
                    'Room Histories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  RoomHistoryList(roomHistories, _controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveCurve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: CustomPaint(
        painter: WavePainter(),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFF36393E)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.25, 80, size.width * 0.5, 0);
    path.quadraticBezierTo(size.width * 0.75, -80, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.white,
                size: 18,
              ),
              SizedBox(width: 5),
              Text(
                '$label:',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          Text(value, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class ElevatedContainer extends StatelessWidget {
  final Color color;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  ElevatedContainer({
    required this.color,
    this.margin,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;

  GlassContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5.0,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.grey[200]?.withOpacity(0.3),
      ),
      child: child,
    );
  }
}

class RoomHistory {
  final String roomName;
  final String location;
  final DateTime date;
  final int totalViews;

  RoomHistory(this.roomName, this.location, this.date, this.totalViews);
}

class RoomHistoryList extends StatefulWidget {
  final List<RoomHistory> roomHistories;
  final AnimationController animationController;

  RoomHistoryList(this.roomHistories, this.animationController);

  @override
  _RoomHistoryListState createState() => _RoomHistoryListState();
}

class _RoomHistoryListState extends State<RoomHistoryList>
    with TickerProviderStateMixin {
  late AnimationController _counterController;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _counterController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..forward();

    _animation = IntTween(
      begin: 0,
      end: widget.roomHistories[0].totalViews,
    ).animate(_counterController);
  }

  @override
  void dispose() {
    _counterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimateIcon(
              key: UniqueKey(),
              onTap: () {
                // Handle icon tap
              },
              iconType: IconType.continueAnimation,
              height: 70,
              width: 70,
              color: Color.fromRGBO(
                  Random.secure().nextInt(255),
                  Random.secure().nextInt(255),
                  Random.secure().nextInt(255),
                  1),
              animateIcon: AnimateIcons.home,
            ),
            SizedBox(width: 5),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Text(
                  'Total Views: ${_animation.value}',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
        SizedBox(height: 10),
        ...widget.roomHistories
            .map(
              (history) => RoomHistoryItem(
                roomHistory: history,
                animation: widget.animationController,
              ),
            )
            .toList(),
      ],
    );
  }
}

class RoomHistoryItem extends StatelessWidget {
  final RoomHistory roomHistory;
  final AnimationController animation;

  RoomHistoryItem({
    required this.roomHistory,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(141, 56, 56, 56),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AnimateIcon(
                key: UniqueKey(),
                onTap: () {
                  // Handle icon tap
                },
                iconType: IconType.continueAnimation,
                height: 30,
                width: 30,
                color: Colors.blue,
                animateIcon: AnimateIcons.submitProgress,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomHistory.roomName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Date: ${roomHistory.date.toString().split(' ')[0]}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Place: ${roomHistory.location}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Total Views: ${roomHistory.totalViews}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
