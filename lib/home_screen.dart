import 'package:flutter/material.dart';

class SportsHomeScreen extends StatelessWidget {
  const SportsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Sports Activities',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: sportsActivities.length,
        itemBuilder: (context, index) {
          return SportsActivityCard(activity: sportsActivities[index]);
        },
      ),
    );
  }
}

class SportsActivityCard extends StatelessWidget {
  final SportsActivity activity;

  const SportsActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color.alphaBlend(
                      activity.color.withValues(alpha: 0.1),
                      Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    activity.icon,
                    color: activity.color,
                    size: 30,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.sportName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        activity.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color.alphaBlend(
                          Colors.green.withValues(alpha: 0.1),
                          Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${activity.joinedCount} joined',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  activity.date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(width: 24),
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                SizedBox(width: 8),
                Text(
                  activity.time,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${activity.price}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle join activity
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: activity.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  ),
                  child: Text(
                    'Join',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SportsActivity {
  final String sportName;
  final String location;
  final String date;
  final String time;
  final int joinedCount;
  final int price;
  final IconData icon;
  final Color color;

  SportsActivity({
    required this.sportName,
    required this.location,
    required this.date,
    required this.time,
    required this.joinedCount,
    required this.price,
    required this.icon,
    required this.color,
  });
}

// Sample data
List<SportsActivity> sportsActivities = [
  SportsActivity(
    sportName: 'Football Match',
    location: 'Central Park Ground',
    date: 'Today',
    time: '6:00 PM',
    joinedCount: 8,
    price: 100,
    icon: Icons.sports_soccer,
    color: Colors.green,
  ),
  SportsActivity(
    sportName: 'Basketball Game',
    location: 'Sports Complex',
    date: 'Tomorrow',
    time: '7:30 PM',
    joinedCount: 5,
    price: 80,
    icon: Icons.sports_basketball,
    color: Colors.orange,
  ),
  SportsActivity(
    sportName: 'Tennis Match',
    location: 'Tennis Court A',
    date: 'Aug 26',
    time: '5:00 PM',
    joinedCount: 3,
    price: 150,
    icon: Icons.sports_tennis,
    color: Colors.blue,
  ),
  SportsActivity(
    sportName: 'Badminton',
    location: 'Indoor Stadium',
    date: 'Aug 27',
    time: '8:00 AM',
    joinedCount: 12,
    price: 50,
    icon: Icons.sports_tennis,
    color: Colors.red,
  ),
  SportsActivity(
    sportName: 'Cricket Practice',
    location: 'City Ground',
    date: 'Aug 28',
    time: '4:00 PM',
    joinedCount: 15,
    price: 75,
    icon: Icons.sports_cricket,
    color: Colors.purple,
  ),
];
