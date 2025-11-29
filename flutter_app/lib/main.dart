import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const VideoAnalyzerApp());
}

class VideoAnalyzerApp extends StatelessWidget {
  const VideoAnalyzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Analyzer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E27),
        primaryColor: const Color(0xFF6C63FF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF4ECDC4),
          surface: Color(0xFF1A1E3E),
          background: Color(0xFF0A0E27),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1A1E3E),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF0F1333),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _sharedVideoUrl;
  bool _isProcessing = false;
  String? _result;
  final TextEditingController _urlController = TextEditingController();

  // Backend URL - change this to your backend URL
  // For iOS simulator use: http://localhost:8000
  // For Android emulator use: http://10.0.2.2:8000
  // For physical device use: http://YOUR_COMPUTER_IP:8000
  final String backendUrl = 'http://10.10.131.31:8000';

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _sendVideoToBackend(String videoUrl) async {
    print('\n${'='*60}');
    print('[FLUTTER] Sending video to backend');
    print('[FLUTTER] Video URL: ${videoUrl.substring(0, videoUrl.length > 50 ? 50 : videoUrl.length)}...');
    print('[FLUTTER] Backend URL: $backendUrl/api/video');
    print('${'='*60}');

    setState(() {
      _isProcessing = true;
      _result = null;
    });

    try {
      final requestBody = {'video_url': videoUrl};
      print('[FLUTTER] Request body: $requestBody');
      
      final startTime = DateTime.now();
      final response = await http.post(
        Uri.parse('$backendUrl/api/video'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );
      final duration = DateTime.now().difference(startTime);

      print('[FLUTTER] Response received in ${duration.inMilliseconds}ms');
      print('[FLUTTER] Status code: ${response.statusCode}');
      print('[FLUTTER] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          print('[FLUTTER] ✓ Video received successfully');
          print('[FLUTTER] Video ID: ${data['video_id']}');
          setState(() {
            _isProcessing = false;
          });
          print('[FLUTTER] Showing action overlay...');
          _showActionOverlay();
        }
      } else {
        print('[FLUTTER] ✗ Error: Unexpected status code ${response.statusCode}');
      }
    } catch (e) {
      print('[FLUTTER] ✗ Exception occurred: $e');
      setState(() {
        _isProcessing = false;
      });
      _showErrorDialog('Failed to connect to backend: $e');
    }
    print('${'-'*60}\n');
  }

  void _showActionOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ActionOverlay(
        videoUrl: _sharedVideoUrl!,
        backendUrl: backendUrl,
        onResult: (result) {
          setState(() {
            _result = result;
          });
        },
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleSubmitUrl() {
    if (_urlController.text.trim().isNotEmpty) {
      setState(() {
        _sharedVideoUrl = _urlController.text.trim();
      });
      _sendVideoToBackend(_sharedVideoUrl!);
      _urlController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0E27),
              Color(0xFF1A1E3E),
              Color(0xFF0A0E27),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Icon/Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF4ECDC4)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.video_library_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // App Title
                  Text(
                    'Video Analyzer',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Analyze videos with AI',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  
                  // URL Input Section
                  if (_sharedVideoUrl == null && !_isProcessing)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Icon(
                              Icons.link_rounded,
                              size: 48,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Enter Video URL',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Paste a video link from Instagram, TikTok, or YouTube',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[400],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller: _urlController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'https://...',
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                prefixIcon: const Icon(Icons.link, color: Color(0xFF6C63FF)),
                              ),
                              onSubmitted: (_) => _handleSubmitUrl(),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _handleSubmitUrl,
                                icon: const Icon(Icons.send_rounded),
                                label: const Text('Analyze Video'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  if (_isProcessing)
                    Column(
                      children: [
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Processing video...',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ],
                    )
                  else if (_sharedVideoUrl != null)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Video Received',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F1333),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _sharedVideoUrl!,
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.refresh, color: Color(0xFF6C63FF)),
                                    onPressed: () {
                                      setState(() {
                                        _sharedVideoUrl = null;
                                        _result = null;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            if (_result != null) ...[
                              const SizedBox(height: 20),
                              const Divider(),
                              const SizedBox(height: 20),
                              Text(
                                'Result:',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F1333),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFF6C63FF).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  _result!,
                                  style: TextStyle(
                                    color: Colors.grey[200],
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  
                  // Test Button (for development)
                  if (_sharedVideoUrl == null && !_isProcessing) ...[
                    const SizedBox(height: 24),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _sharedVideoUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
                        });
                        _sendVideoToBackend(_sharedVideoUrl!);
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Quick Test with Sample'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[400],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ActionOverlay extends StatefulWidget {
  final String videoUrl;
  final String backendUrl;
  final Function(String) onResult;

  const ActionOverlay({
    super.key,
    required this.videoUrl,
    required this.backendUrl,
    required this.onResult,
  });

  @override
  State<ActionOverlay> createState() => _ActionOverlayState();
}

class _ActionOverlayState extends State<ActionOverlay> {
  final TextEditingController _customQuestionController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _sendAction(String action, {String? customQuestion}) async {
    print('\n${'='*60}');
    print('[FLUTTER] Sending analysis request');
    print('[FLUTTER] Action: $action');
    if (customQuestion != null) {
      print('[FLUTTER] Custom Question: $customQuestion');
    }
    print('${'='*60}');

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final requestBody = {
        'video_url': widget.videoUrl,
        'action': action,
        'custom_question': customQuestion,
      };
      print('[FLUTTER] Request body: $requestBody');
      
      final startTime = DateTime.now();
      print('[FLUTTER] Waiting for backend response...');
      
      final response = await http.post(
        Uri.parse('${widget.backendUrl}/api/analyze'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );
      
      final duration = DateTime.now().difference(startTime);
      print('[FLUTTER] Response received in ${duration.inMilliseconds}ms');
      print('[FLUTTER] Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('[FLUTTER] ✓ Analysis successful');
        print('[FLUTTER] Response length: ${data['response'].length} characters');
        
        setState(() {
          _isLoading = false;
        });
        
        widget.onResult(data['response']);
        
        if (mounted) {
          print('[FLUTTER] Closing overlay and showing results');
          Navigator.pop(context);
        }
      } else {
        print('[FLUTTER] ✗ Error: Status code ${response.statusCode}');
        print('[FLUTTER] Response: ${response.body}');
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to get response from server';
        });
      }
    } catch (e) {
      print('[FLUTTER] ✗ Exception occurred: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: $e';
      });
    }
    print('${'-'*60}\n');
  }

  Widget _buildActionButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: const Color(0xFF1A1E3E),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: _isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0A0E27),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Title
              Text(
                'Analyze Video',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose an analysis option',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),

              if (_isLoading)
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Analyzing video...',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                )
              else ...[
                // Action Buttons
                _buildActionButton(
                  title: 'Hoax Check',
                  subtitle: 'Verify the authenticity of this content',
                  icon: Icons.verified_user_rounded,
                  onTap: () => _sendAction('hoax_check'),
                  color: const Color(0xFFFF6B6B),
                ),
                _buildActionButton(
                  title: 'Explain This',
                  subtitle: 'Get a detailed explanation of the content',
                  icon: Icons.lightbulb_rounded,
                  onTap: () => _sendAction('explain_this'),
                  color: const Color(0xFFFFD93D),
                ),
                _buildActionButton(
                  title: 'Expand This Idea',
                  subtitle: 'Explore related concepts and ideas',
                  icon: Icons.explore_rounded,
                  onTap: () => _sendAction('expand_idea'),
                  color: const Color(0xFF4ECDC4),
                ),
                
                // Custom Question Section
                const SizedBox(height: 8),
                Text(
                  'Or ask your own question',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _customQuestionController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Type your question here...',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Color(0xFF6C63FF)),
                      onPressed: () {
                        if (_customQuestionController.text.trim().isNotEmpty) {
                          _sendAction('custom_question', customQuestion: _customQuestionController.text.trim());
                        }
                      },
                    ),
                  ),
                ),
              ],

              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _customQuestionController.dispose();
    super.dispose();
  }
}
