import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Data Model for User/Event
class UserModel {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String city;
  final String skillLevel;
  final DateTime dateTime;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.city,
    required this.skillLevel,
    required this.dateTime,
  });
}

// Main Home Screen Widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample data - replace with your actual data source
  List<UserModel> events = [
    UserModel(
      id: '1',
      name: 'John Doe',
      age: 25,
      gender: 'Male',
      city: 'New York',
      skillLevel: 'Intermediate',
      dateTime: DateTime.now(),
    ),
    UserModel(
      id: '2',
      name: 'Jane Smith',
      age: 28,
      gender: 'Female',
      city: 'Los Angeles',
      skillLevel: 'Expert',
      dateTime: DateTime.now().add(Duration(hours: 2)),
    ),
    UserModel(
      id: '3',
      name: 'Mike Johnson',
      age: 22,
      gender: 'Male',
      city: 'Chicago',
      skillLevel: 'Beginner',
      dateTime: DateTime.now().add(Duration(days: 1)),
    ),
    UserModel(
      id: '4',
      name: 'Sarah Wilson',
      age: 30,
      gender: 'Female',
      city: 'Miami',
      skillLevel: 'Advanced',
      dateTime: DateTime.now().add(Duration(days: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // Custom App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      title: Text(
        'Events',
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      actions: [
        // Add action buttons here if needed
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black54,
            size: 24.w,
          ),
          onPressed: () {
            // Add search functionality
          },
        ),
        IconButton(
          icon: Icon(
            Icons.filter_list,
            color: Colors.black54,
            size: 24.w,
          ),
          onPressed: () {
            // Add filter functionality
          },
        ),
      ],
    );
  }

  // Main body content
  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          _buildHeader(),
          
          SizedBox(height: 20.h),
          
          // Events list
          Expanded(
            child: _buildEventsList(),
          ),
        ],
      ),
    );
  }

  // Header with event count and subtitle
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Events',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '${events.length} events available',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // Events list view
  Widget _buildEventsList() {
    return ListView.builder(
      itemCount: events.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: EventCard(
            event: events[index],
            onTap: () => _handleEventTap(events[index]),
          ),
        );
      },
    );
  }

  // Handle event card tap
  void _handleEventTap(UserModel event) {
    // Navigate to event details or show modal
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => EventDetailsModal(event: event),
    );
  }
}

// Customizable Event Card Widget
class EventCard extends StatelessWidget {
  final UserModel event;
  final VoidCallback? onTap;
  
  // Customization properties - easily modifiable
  final double? cardHeight;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? borderRadius;
  final double? elevation;

  const EventCard({
    Key? key,
    required this.event,
    this.onTap,
    this.cardHeight,
    this.backgroundColor,
    this.shadowColor,
    this.borderRadius,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: cardHeight ?? 120.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Profile Avatar Section
              _buildProfileAvatar(),
              
              SizedBox(width: 16.w),
              
              // Event Details Section
              Expanded(
                child: _buildEventDetails(),
              ),
              
              // Action/Status Section
              _buildActionSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Profile avatar with initials
  Widget _buildProfileAvatar() {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: _getAvatarColor(),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          _getInitials(event.name),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Event details column
  Widget _buildEventDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Name
        Text(
          event.name,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        
        SizedBox(height: 4.h),
        
        // Age and Gender
        Row(
          children: [
            Icon(
              event.gender == 'Male' ? Icons.male : Icons.female,
              size: 14.w,
              color: Colors.grey[600],
            ),
            SizedBox(width: 4.w),
            Text(
              '${event.age} years • ${event.gender}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        
        SizedBox(height: 4.h),
        
        // City and Skill Level
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 14.w,
              color: Colors.grey[600],
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                '${event.city} • ${event.skillLevel}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Action section with time and arrow
  Widget _buildActionSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Time
        Text(
          _formatTime(event.dateTime),
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        
        SizedBox(height: 4.h),
        
        // Arrow icon
        Icon(
          Icons.arrow_forward_ios,
          size: 16.w,
          color: Colors.grey[400],
        ),
      ],
    );
  }

  // Helper methods
  String _getInitials(String name) {
    List<String> names = name.split(' ');
    String initials = names.isNotEmpty ? names[0][0] : '';
    if (names.length > 1) {
      initials += names[1][0];
    }
    return initials.toUpperCase();
  }

  Color _getAvatarColor() {
    // Generate color based on name hash for consistency
    int hash = event.name.hashCode;
    List<Color> colors = [
      Colors.blue[400]!,
      Colors.green[400]!,
      Colors.orange[400]!,
      Colors.purple[400]!,
      Colors.red[400]!,
      Colors.teal[400]!,
    ];
    return colors[hash.abs() % colors.length];
  }

  String _formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    String minuteStr = minute.toString().padLeft(2, '0');
    return '$hour:$minuteStr $period';
  }
}

// Event Details Screen
class EventDetailsScreen extends StatefulWidget {
  final UserModel event;

  const EventDetailsScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool isJoined = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Hero Animation
          _buildSliverAppBar(),
          
          // Content
          SliverToBoxAdapter(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  // Custom Sliver App Bar
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.h,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _getAvatarColor().withAlpha(51), // 20% opacity
                _getAvatarColor().withAlpha(25), // 10% opacity
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h), // Account for status bar
                
                // Large Profile Avatar
                Hero(
                  tag: 'avatar_${widget.event.id}',
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: _getAvatarColor(),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x26000000), // 15% opacity black
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(widget.event.name),
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 12.h),
                
                // Name
                Text(
                  widget.event.name,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                
                SizedBox(height: 4.h),
                
                // Skill Level Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getSkillLevelColor(),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    widget.event.skillLevel,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Main content
  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Information Card
          _buildInfoCard(),
          
          SizedBox(height: 24.h),
          
          // Event Stats
          _buildStatsSection(),
          
          SizedBox(height: 24.h),
          
          // Event Description
          _buildDescriptionSection(),
          
          SizedBox(height: 24.h),
          
          // Location Section
          _buildLocationSection(),
          
          SizedBox(height: 32.h),
          
          // Action Buttons
          _buildActionButtons(),
          
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  // Event Information Card
  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000), // 6% opacity black
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            Icons.calendar_today_outlined,
            'Date & Time',
            _formatDateTime(widget.event.dateTime),
            Colors.blue[600]!,
          ),
          
          Divider(height: 24.h, color: Colors.grey[200]),
          
          _buildInfoRow(
            widget.event.gender == 'Male' ? Icons.male : Icons.female,
            'Profile',
            '${widget.event.age} years • ${widget.event.gender}',
            widget.event.gender == 'Male' ? Colors.blue[600]! : Colors.pink[600]!,
          ),
          
          Divider(height: 24.h, color: Colors.grey[200]),
          
          _buildInfoRow(
            Icons.location_on_outlined,
            'Location',
            widget.event.city,
            Colors.green[600]!,
          ),
        ],
      ),
    );
  }

  // Info row widget
  Widget _buildInfoRow(IconData icon, String label, String value, Color iconColor) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: iconColor.withAlpha(25), // 10% opacity
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20.w,
          ),
        ),
        
        SizedBox(width: 16.w),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Stats Section
  Widget _buildStatsSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000), // 6% opacity black
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem('24', 'Participants', Icons.group_outlined),
          ),
          
          Container(
            width: 1,
            height: 40.h,
            color: Colors.grey[200],
          ),
          
          Expanded(
            child: _buildStatItem('4.8', 'Rating', Icons.star_outline),
          ),
          
          Container(
            width: 1,
            height: 40.h,
            color: Colors.grey[200],
          ),
          
          Expanded(
            child: _buildStatItem('2h', 'Duration', Icons.schedule_outlined),
          ),
        ],
      ),
    );
  }

  // Individual stat item
  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24.w,
          color: Colors.grey[600],
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Description Section
  Widget _buildDescriptionSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000), // 6% opacity black
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About this Event',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          
          SizedBox(height: 12.h),
          
          Text(
            'Join ${widget.event.name} for an exciting event in ${widget.event.city}. This is perfect for ${widget.event.skillLevel.toLowerCase()} level participants. Come and connect with like-minded people in your area!',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Tags
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildTag(widget.event.skillLevel),
              _buildTag(widget.event.gender),
              _buildTag('${widget.event.age}+ years'),
            ],
          ),
        ],
      ),
    );
  }

  // Tag widget
  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Location Section
  Widget _buildLocationSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000), // 6% opacity black
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red[500],
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 12.h),
          
          Text(
            widget.event.city,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          SizedBox(height: 8.h),
          
          Text(
            'Exact location will be shared after joining the event.',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // View on Map button
          OutlinedButton.icon(
            onPressed: () {
              // Add map functionality
            },
            icon: Icon(Icons.map_outlined, size: 16.w),
            label: Text('View on Map'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black87,
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Action Buttons
  Widget _buildActionButtons() {
    return Column(
      children: [
        // Join Event Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isJoined = !isJoined;
              });
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isJoined ? 'Successfully joined the event!' : 'Left the event',
                  ),
                  backgroundColor: isJoined ? Colors.green : Colors.orange,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isJoined ? Colors.green[600] : Colors.black87,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              isJoined ? 'Joined ✓' : 'Join Event',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        SizedBox(height: 12.h),
        
        // Secondary Actions Row
        Row(
          children: [
            // Share Button
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Add share functionality
                },
                icon: Icon(Icons.share_outlined, size: 16.w),
                label: Text('Share'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: BorderSide(color: Colors.grey[300]!),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // Save Button
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Add save functionality
                },
                icon: Icon(Icons.bookmark_outline, size: 16.w),
                label: Text('Save'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: BorderSide(color: Colors.grey[300]!),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper methods
  String _getInitials(String name) {
    List<String> names = name.split(' ');
    String initials = names.isNotEmpty ? names[0][0] : '';
    if (names.length > 1) {
      initials += names[1][0];
    }
    return initials.toUpperCase();
  }

  Color _getAvatarColor() {
    int hash = widget.event.name.hashCode;
    List<Color> colors = [
      Colors.blue[600]!,
      Colors.green[600]!,
      Colors.orange[600]!,
      Colors.purple[600]!,
      Colors.red[600]!,
      Colors.teal[600]!,
    ];
    return colors[hash.abs() % colors.length];
  }

  Color _getSkillLevelColor() {
    switch (widget.event.skillLevel.toLowerCase()) {
      case 'beginner':
        return Colors.green[600]!;
      case 'intermediate':
        return Colors.orange[600]!;
      case 'advanced':
        return Colors.red[600]!;
      case 'expert':
        return Colors.purple[600]!;
      default:
        return Colors.blue[600]!;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    String month = months[dateTime.month - 1];
    String day = dateTime.day.toString();
    String year = dateTime.year.toString();
    String time = _formatTime(dateTime);
    
    return '$month $day, $year at $time';
  }

  String _formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    String minuteStr = minute.toString().padLeft(2, '0');
    return '$hour:$minuteStr $period';
  }
}

// Create Event Screen
class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();
  
  String _selectedGender = 'Male';
  String _selectedSkillLevel = 'Beginner';
  DateTime _selectedDateTime = DateTime.now().add(Duration(hours: 1));
  bool _isLoading = false;

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _skillLevels = ['Beginner', 'Intermediate', 'Advanced', 'Expert'];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // Custom App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black87,
          size: 20.w,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Create Event',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : _saveAsDraft,
          child: Text(
            'Save Draft',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: _isLoading ? Colors.grey : Colors.blue[600],
            ),
          ),
        ),
      ],
    );
  }

  // Main body content
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            
            SizedBox(height: 32.h),
            
            // Basic Information Section
            _buildSection(
              'Basic Information',
              Icons.person_outline,
              [
                _buildNameField(),
                SizedBox(height: 20.h),
                _buildAgeField(),
                SizedBox(height: 20.h),
                _buildGenderSelector(),
              ],
            ),
            
            SizedBox(height: 32.h),
            
            // Event Details Section
            _buildSection(
              'Event Details',
              Icons.event_outlined,
              [
                _buildSkillLevelSelector(),
                SizedBox(height: 20.h),
                _buildDateTimeSelector(),
              ],
            ),
            
            SizedBox(height: 32.h),
            
            // Location Section
            _buildSection(
              'Location',
              Icons.location_on_outlined,
              [
                _buildCityField(),
              ],
            ),
            
            SizedBox(height: 100.h), // Space for bottom bar
          ],
        ),
      ),
    );
  }

  // Header with description
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create New Event',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Fill in the details below to create your event and connect with people in your area.',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // Section builder with icon and title
  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0A000000), // 4% opacity black
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.blue[600],
                  size: 16.w,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Section Content
          ...children,
        ],
      ),
    );
  }

  // Name input field
  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Name *',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Enter your full name',
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red[600]!),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your name';
            }
            if (value.trim().length < 2) {
              return 'Name must be at least 2 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Age input field
  Widget _buildAgeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age *',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _ageController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter your age',
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red[600]!),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your age';
            }
            int? age = int.tryParse(value);
            if (age == null || age < 13 || age > 100) {
              return 'Please enter a valid age (13-100)';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Gender selector
  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender *',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: _genderOptions.map((gender) {
            bool isSelected = _selectedGender == gender;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: gender != _genderOptions.last ? 12.w : 0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGender = gender;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[600] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
                      ),
                    ),
                    child: Text(
                      gender,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Skill level selector
  Widget _buildSkillLevelSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skill Level *',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: _skillLevels.map((skill) {
            bool isSelected = _selectedSkillLevel == skill;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSkillLevel = skill;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? _getSkillLevelColor(skill) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? _getSkillLevelColor(skill) : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  skill,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Date and time selector
  Widget _buildDateTimeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date & Time *',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: _selectDateTime,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey[600],
                  size: 20.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _formatDateTime(_selectedDateTime),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[600],
                  size: 20.w,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // City input field
  Widget _buildCityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'City *',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _cityController,
          decoration: InputDecoration(
            hintText: 'Enter your city',
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red[600]!),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            filled: true,
            fillColor: Colors.grey[50],
            prefixIcon: Icon(
              Icons.location_on_outlined,
              color: Colors.grey[600],
              size: 20.w,
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your city';
            }
            return null;
          },
        ),
      ],
    );
  }

  // Bottom bar with create button
  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x14000000), // 8% opacity black
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _createEvent,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isLoading ? Colors.grey[400] : Colors.black87,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Create Event',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  // Select date and time
  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[600]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.blue[600]!,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black87,
              ),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  // Create event function
  Future<void> _createEvent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Create new event
      UserModel newEvent = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text),
        gender: _selectedGender,
        city: _cityController.text.trim(),
        skillLevel: _selectedSkillLevel,
        dateTime: _selectedDateTime,
      );

      setState(() {
        _isLoading = false;
      });

      // Show success and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Event created successfully!'),
          backgroundColor: Colors.green[600],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );

      Navigator.pop(context, newEvent);
    }
  }

  // Save as draft function
  void _saveAsDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Draft saved successfully!'),
        backgroundColor: Colors.orange[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  // Helper methods
  Color _getSkillLevelColor(String skillLevel) {
    switch (skillLevel.toLowerCase()) {
      case 'beginner':
        return Colors.green[600]!;
      case 'intermediate':
        return Colors.orange[600]!;
      case 'advanced':
        return Colors.red[600]!;
      case 'expert':
        return Colors.purple[600]!;
      default:
        return Colors.blue[600]!;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    String month = months[dateTime.month - 1];
    String day = dateTime.day.toString();
    String year = dateTime.year.toString();
    String time = _formatTime(dateTime);
    
    return '$month $day, $year at $time';
  }

  String _formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    String minuteStr = minute.toString().padLeft(2, '0');
    return '$hour:$minuteStr $period';
  }
}

// Event Details Modal (Bottom Sheet) - Kept for backward compatibility
class EventDetailsModal extends StatelessWidget {
  final UserModel event;

  const EventDetailsModal({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          
          SizedBox(height: 20.h),
          
          // Title
          Text(
            'Event Details',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Event details
          _buildDetailRow('Name', event.name),
          _buildDetailRow('Age', '${event.age} years'),
          _buildDetailRow('Gender', event.gender),
          _buildDetailRow('City', event.city),
          _buildDetailRow('Skill Level', event.skillLevel),
          _buildDetailRow('Date & Time', _formatDateTime(event.dateTime)),
          
          SizedBox(height: 24.h),
          
          // Action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${_formatTime(dateTime)}';
  }

  String _formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    String minuteStr = minute.toString().padLeft(2, '0');
    return '$hour:$minuteStr $period';
  }
}
