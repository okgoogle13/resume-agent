import 'package:flutter/material.dart';
import 'core/api_client.dart';

void main() {
  runApp(const ResumeAgentApp());
}

class ResumeAgentApp extends StatelessWidget {
  const ResumeAgentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Agent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Enhanced Resume Agent'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _connectionStatus = 'Checking connection...';

  @override
  void initState() {
    super.initState();
    _checkBackendConnection();
  }

  Future<void> _checkBackendConnection() async {
    final health = await ApiClient.healthCheck();
    setState(() {
      if (health != null) {
        _connectionStatus = 'Connected to backend ✅';
      } else {
        _connectionStatus = 'Backend connection failed ❌';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Enhanced Resume Agent!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(_connectionStatus),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkBackendConnection,
              child: const Text('Test Backend Connection'),
            ),
          ],
        ),
      ),
    );
  }
}
