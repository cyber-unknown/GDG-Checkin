import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:vibration/vibration.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:animated_background/animated_background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const QRCheckInApp());
}

class QRCheckInApp extends StatelessWidget {
  const QRCheckInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GDG Events Check-In',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,  // Enable Material 3
        textTheme: TextTheme(
          displayLarge: GoogleFonts.spaceMono(color: Colors.white),
          bodyLarge: GoogleFonts.spaceMono(color: Colors.white),
          bodyMedium: GoogleFonts.spaceMono(color: Colors.white),
        ),
      ),
      home: const EventListScreen(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
        scrollbars: false,
      ),
    );
  }
}

class Event {
  final String name;
  final String sheetId;
  final String gid;
  final Color color;

  Event({
    required this.name, 
    required this.sheetId, 
    required this.gid,
    required this.color
  });
}

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  double _scrollOffset = 0;

  static final List<Event> events = [
    Event(
      name: 'Designathon',
      sheetId: 'designathon',
      gid: '1001097286',
      color: Colors.blue
    ),
    Event(
      name: 'Paper Presentation',
      sheetId: 'paper',
      gid: '1641912367',
      color: Colors.green
    ),
    Event(
      name: 'Code Combat',
      sheetId: 'code',
      gid: '223125523',
      color: Colors.red
    ),
    Event(
      name: 'Circuit Board',
      sheetId: 'circuit',
      gid: '1667877536',
      color: Colors.orange
    ),
    Event(
      name: 'Graphic Design',
      sheetId: 'graphic',
      gid: '244105420',
      color: Colors.purple
    ),
    Event(
      name: 'Free Fire',
      sheetId: 'freefire',
      gid: '523643525',
      color: Colors.amber
    ),
    Event(
      name: 'Capture The Flag (CTF)',
      sheetId: 'ctf',
      gid: '1531328687',
      color: Colors.indigo
    ),
    Event(
      name: 'Connections',
      sheetId: 'connections',
      gid: '1068472169',
      color: Colors.teal
    ),
    Event(
      name: 'Anime Quiz',
      sheetId: 'anime',
      gid: '858289153',
      color: Colors.pink
    ),
    Event(
      name: 'Lunch',
      sheetId: 'lunch',
      gid: '177718058',
      color: Colors.brown
    ),
    Event(
      name: 'Brunch',
      sheetId: 'brunch',
      gid: '1090751708',
      color: Colors.cyan
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize scroll controller
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Custom Particle Effect
          Positioned.fill(
            child: AnimatedBackground(
              behaviour: RandomParticleBehaviour(
                options: ParticleOptions(
                  baseColor: Colors.blue,
                  spawnOpacity: 0.0,
                  opacityChangeRate: 0.25,
                  minOpacity: 0.1,
                  maxOpacity: 0.4,
                  particleCount: 70,
                  spawnMaxRadius: 4.0,
                  spawnMinRadius: 2.0,
                  spawnMaxSpeed: 100.0,
                  spawnMinSpeed: 30.0,
                ),
                paint: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 1.0,
              ),
              vsync: this,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.black.withOpacity(max(0, min(1, _scrollOffset / 200))),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: const EdgeInsets.only(bottom: 24),
                      title: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          'GDG Events Check-In',
                          style: GoogleFonts.spaceMono(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.blue.withOpacity(0.5),
                                offset: const Offset(0, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Lottie.asset(
                            'assets/animations/qr_scan.json',
                            fit: BoxFit.cover,
                          ),
                          // Add a darker gradient overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.9),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Updated Event List with Hero animations
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final event = events[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Hero(
                              tag: 'event_${event.sheetId}',
                              child: EventCard(
                                event: event,
                                index: index,
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(
                            duration: 200.ms,
                            delay: (25 * index).ms,
                            curve: Curves.easeOut,
                          )
                          .slideY(
                            begin: 0.1,
                            end: 0,
                            curve: Curves.easeOut,
                            duration: 200.ms,
                            delay: (25 * index).ms,
                          );
                        },
                        childCount: events.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Add floating particles in foreground
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: ParticlePainter(
                  color: Theme.of(context).primaryColor,
                  particleCount: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatefulWidget {
  final Event event;
  final int index;

  const EventCard({
    super.key,
    required this.event,
    required this.index,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -10.0 : 0.0, 0.0)
          ..scale(isHovered ? 1.05 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: widget.event.color.withOpacity(isHovered ? 0.4 : 0.1),
                blurRadius: isHovered ? 30 : 10,
                spreadRadius: isHovered ? 5 : 0,
                offset: isHovered ? const Offset(0, 10) : const Offset(0, 0),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    childCurrent: widget,
                    duration: const Duration(milliseconds: 600),
                    reverseDuration: const Duration(milliseconds: 600),
                    child: CheckInScreen(event: widget.event),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: widget.event.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.qr_code_scanner,
                        color: widget.event.color,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.event.name,
                            style: GoogleFonts.spaceMono(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Tap to scan QR',
                            style: GoogleFonts.spaceMono(
                              color: Colors.grey[300],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: widget.event.color.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    )
    .animate()
    .fadeIn(duration: 400.ms)
    .slideY(
      begin: 0.2,
      duration: 400.ms,
      curve: Curves.easeOutCubic,
    );
  }
}

class CheckInScreen extends StatefulWidget {
  final Event event;

  const CheckInScreen({super.key, required this.event});

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _idController = TextEditingController();
  String message = '';
  bool isLoading = false;
  bool isScanning = true;
  MobileScannerController scannerController = MobileScannerController();
  late AnimationController _animationController;

  static const String BASE_API_URL =
      'https://script.google.com/macros/s/AKfycbyXqmnZUYxli9RLbEjCeNlVTZF9108uMVmGwl_Tc5qbdU1EeDvupolnMHih6aCiFrs9nw/exec';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _idController.dispose();
    scannerController.dispose();
    super.dispose();
  }

  Future<void> checkIn(String id) async {
    if (id.isEmpty) return;

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      final url = Uri.parse(
        '$BASE_API_URL?gid=${widget.event.gid}&id=$id'
      );
      final response = await http.get(url).timeout(
            const Duration(seconds: 10),
          );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          isLoading = false;
          if (data['status'] == 'success') {
            message = "Checked In: ${data['name']}";
            _triggerFeedback(success: true);
          } else if (data['status'] == 'already_validated') {
            message = "⏳ Already Checked In: ${data['name']}";
            _triggerFeedback(success: false);
          } else {
            message = "❌ Invalid ID!";
            _triggerFeedback(success: false);
          }
        });
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        message = "⚠️ Error: Unable to connect";
        _triggerFeedback(success: false);
      });
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isScanning = true;
        });
      }
    });
  }

  void _triggerFeedback({required bool success}) async {
    if (await Vibration.hasVibrator() ?? false) {
      if (success) {
        Vibration.vibrate(duration: 200);
      } else {
        Vibration.vibrate(pattern: [0, 200, 100, 200]);
      }
    }
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    if (!isScanning) return;

    final scannedCode = capture.barcodes.first.rawValue;
    if (scannedCode != null) {
      setState(() {
        isScanning = false;
      });
      checkIn(scannedCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background particles
          Positioned.fill(
            child: CircularParticle(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              particleColor: widget.event.color.withOpacity(0.1),
              numberOfParticles: 30,
              speedOfParticles: 0.3,
              maxParticleSize: 2,
              awayRadius: 100,
              onTapAnimation: true,
              isRandomColor: false,
              isRandSize: true,
            ),
          ),
          
          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Scanner container with 3D effect
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(0.1),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: Hero(
                          tag: 'gdg_logo',
                          child: Image.asset(
                            'assets/logos/gdg_logo.png',
                            fit: BoxFit.contain,
                            color: widget.event.color,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.event.color
                                .withOpacity(0.3 + _animationController.value * 0.7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              MobileScanner(
                                controller: scannerController,
                                onDetect: _onBarcodeDetected,
                              ),
                              if (isScanning)
                                Center(
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: widget.event.color.withOpacity(
                                            0.3 + _animationController.value * 0.7),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2.seconds, color: widget.event.color.withOpacity(0.3))
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                  duration: 1.seconds,
                  curve: Curves.easeInOut,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _idController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    labelText: "Enter ID",
                    labelStyle: TextStyle(
                      color: widget.event.color.withOpacity(0.9),
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: widget.event.color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: widget.event.color.withOpacity(0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: widget.event.color,
                        width: 2,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.badge,
                      color: widget.event.color.withOpacity(0.9),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : () => checkIn(_idController.text.trim()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.event.color,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: widget.event.color.withOpacity(0.4),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ).copyWith(
                      overlayColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white.withOpacity(0.1);
                        }
                        return null;
                      }),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: isLoading
                              ? WaveLoadingAnimation(color: widget.event.color)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.qr_code_scanner,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Check In",
                                      style: GoogleFonts.spaceMono(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                if (message.isNotEmpty)
                  SuccessAnimation(
                    message: message,
                    isSuccess: message.startsWith("Checked In:"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveLoadingAnimation extends StatefulWidget {
  final Color color;
  
  const WaveLoadingAnimation({
    super.key,
    required this.color,
  });

  @override
  State<WaveLoadingAnimation> createState() => _WaveLoadingAnimationState();
}

class _WaveLoadingAnimationState extends State<WaveLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,  // Reduced width for 3 dots
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          3,  // Changed to 3 dots
          (index) => AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final sinValue = sin((_controller.value * 2 * pi) + (index * pi / 2));
              return Transform.translate(
                offset: Offset(0, sinValue * 8),  // Increased amplitude
                child: Container(
                  width: 10,  // Slightly larger dots
                  height: 10,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withOpacity(0.4),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SuccessAnimation extends StatefulWidget {
  final String message;
  final bool isSuccess;
  
  const SuccessAnimation({
    super.key,
    required this.message,
    required this.isSuccess,
  });

  @override
  State<SuccessAnimation> createState() => _SuccessAnimationState();
}

class _SuccessAnimationState extends State<SuccessAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.isSuccess
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isSuccess ? Colors.green : Colors.red,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: (widget.isSuccess ? Colors.green : Colors.red)
                    .withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (widget.isSuccess ? Colors.green : Colors.red)
                      .withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.isSuccess ? Icons.check_circle : Icons.error,
                  color: widget.isSuccess ? Colors.green : Colors.red,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.message,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        widget.isSuccess ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final Color color;
  final int particleCount;
  final Random random = Random();
  final List<Offset> particles = [];
  final List<double> speeds = [];
  
  ParticlePainter({
    required this.color,
    this.particleCount = 20,
  }) {
    // Initialize particles
    for (int i = 0; i < particleCount; i++) {
      particles.add(Offset(
        random.nextDouble() * 400,
        random.nextDouble() * 800,
      ));
      speeds.add(1 + random.nextDouble() * 4);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Update and draw particles
    for (int i = 0; i < particles.length; i++) {
      particles[i] = Offset(
        particles[i].dx,
        (particles[i].dy + speeds[i]) % size.height,
      );
      
      canvas.drawCircle(particles[i], 2, paint);
      
      // Draw connections between nearby particles
      for (int j = i + 1; j < particles.length; j++) {
        final distance = (particles[i] - particles[j]).distance;
        if (distance < 100) {
          canvas.drawLine(
            particles[i],
            particles[j],
            paint..color = color.withOpacity(0.1 * (1 - distance / 100)),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}
