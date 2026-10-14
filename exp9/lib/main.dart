import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Experiment 9',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final String databaseUrl = 'https://YOUR-DATABASE-URL';

  Map<String, dynamic> records = {};
  bool loading = false;
  bool saving = false;

  Future<void> readData() async {
    if (mounted) {
      setState(() => loading = true);
    }

    try {
      final url = Uri.parse('$databaseUrl/students.json');
      final response = await http.get(url);

      debugPrint('READ URL: $url');
      debugPrint('READ STATUS: ${response.statusCode}');
      debugPrint('READ RESPONSE: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception(
          'HTTP ${response.statusCode}: ${response.body}',
        );
      }

      final decoded = jsonDecode(response.body);

      final Map<String, dynamic> fetchedRecords =
          decoded == null
              ? {}
              : Map<String, dynamic>.from(decoded as Map);

      if (mounted) {
        setState(() => records = fetchedRecords);
      }
    } catch (e) {
      debugPrint('READ ERROR: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Read failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  Future<void> saveData() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter name and email'),
        ),
      );
      return;
    }

    setState(() => saving = true);

    try {
      final url = Uri.parse('$databaseUrl/students.json');

      debugPrint('SAVE URL: $url');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
        }),
      );

      debugPrint('SAVE STATUS: ${response.statusCode}');
      debugPrint('SAVE RESPONSE: ${response.body}');

      if (response.statusCode == 200) {
        nameController.clear();
        emailController.clear();

        await readData();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data saved successfully!'),
            ),
          );
        }
      } else {
        throw Exception(
          'HTTP ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('SAVE ERROR: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Save failed: $e'),
            duration: const Duration(seconds: 10),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => saving = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment 9 – Firebase'),
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Enter Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saving ? null : saveData,
                child: Text(saving ? 'Saving…' : 'Submit'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: loading ? null : readData,
                child: const Text('Refresh Records'),
              ),
            ),
            const Divider(height: 32),
            const Text(
              'Saved Student Records',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : records.isEmpty
                      ? const Center(
                          child: Text('No records found'),
                        )
                      : ListView(
                          children: records.entries.map((entry) {
                            final student =
                                Map<String, dynamic>.from(
                              entry.value as Map,
                            );

                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(
                                  '${student['name'] ?? 'No name'}',
                                ),
                                subtitle: Text(
                                  '${student['email'] ?? 'No email'}',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}