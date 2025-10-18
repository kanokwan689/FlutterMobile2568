import 'package:flutter/material.dart';
import 'dart:async'; // Import Timer for the animation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Widget ProfileCard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Widget ProfileCard'),
        ),
        body: const Center(
          // Use the corrected FadeIn widget
          child: FadeIn(
            duration: Duration(seconds: 2),
            child: ProfileCard(
              name: 'Kanokwan Noppun',
              position: 'Programmer Rookie',
              email: 'Noppun_k@silpakorn.edu',
              phoneNumber: '0935252481',
              // Using a placeholder image for stability, you can replace it with your URL
              imageUrl: 'https://scontent.fbkk17-1.fna.fbcdn.net/v/t39.30808-6/534717511_2216662415428745_4001422181947491038_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=vnOwvxrWl9cQ7kNvwHjgB3n&_nc_oc=AdnU9gVPHdJtLVfiaY-FEf-b1IY4K97YCube0hQSZ9jtb9UId4Dyj2GuMlMIuI-VymY&_nc_zt=23&_nc_ht=scontent.fbkk17-1.fna&_nc_gid=a-AGWomXycTnT5BY7Rszkg&oh=00_Afc5K98ACt8znD9e2Fr8m1gOxpdmxXs6lMUdRgNoXB4ceg&oe=68F8FD20',
            ),
          ),
        ),
      ),
    );
  }
}

// --- The ProfileCard Widget is now in the same file ---
// No need to import another file.
class ProfileCard extends StatelessWidget {
  final String name;
  final String position;
  final String email;
  final String phoneNumber;
  final String imageUrl;

  const ProfileCard({
    super.key,
    required this.name,
    required this.position,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Using ClipOval for a perfect circle
            ClipOval(
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                // Add error handling for the image
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.person,
                      color: Colors.grey[800],
                      size: 50,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            // Name and Position
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              position,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurple.withOpacity(0.8), fontSize: 16),
            ),
            const SizedBox(height: 15),
            // Divider for better separation
            const Divider(
              color: Colors.black12,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 15),
            // Email and Phone Number Info
            _buildContactInfo(Icons.email, email, Colors.blue),
            const SizedBox(height: 8),
            _buildContactInfo(Icons.phone, phoneNumber, Colors.green),
          ],
        ),
      ),
    );
  }

  // Helper widget to reduce code duplication
  Widget _buildContactInfo(IconData icon, String text, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

// --- Corrected FadeIn Widget ---
// Changed to StatefulWidget to manage the animation state.
class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeIn({super.key, required this.child, required this.duration});

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the animation after the widget is built
    Timer(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity, // Use the state variable here
      duration: widget.duration,
      curve: Curves.easeIn, // Add a nice curve to the animation
      child: widget.child,
    );
  }
}
