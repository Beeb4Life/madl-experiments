import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Handling App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FilePage(),
    );
  }
}

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  final TextEditingController controller = TextEditingController();
  String fileContent = '';
  String message = '';
  final String filePath = 'sample.txt';

  Future<void> writeFile() async {
    try {
      final file = File(filePath);
      await file.writeAsString(controller.text);

      setState(() {
        message = 'File written successfully!';
      });
    } catch (e) {
      setState(() {
        message = 'Error writing file: $e';
      });
    }
  }

  Future<void> readFile() async {
    try {
      final file = File(filePath);

      if (await file.exists()) {
        final content = await file.readAsString();

        setState(() {
          fileContent = content;
          message = 'File read successfully!';
        });
      } else {
        setState(() {
          message = 'File does not exist.';
          fileContent = '';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error reading file: $e';
      });
    }
  }

  Future<void> deleteFile() async {
    try {
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();

        setState(() {
          fileContent = '';
          message = 'File deleted successfully!';
        });
      } else {
        setState(() {
          message = 'File does not exist.';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error deleting file: $e';
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Handling'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Text',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter text to save',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: writeFile,
                  child: const Text('Write'),
                ),
                ElevatedButton(
                  onPressed: readFile,
                  child: const Text('Read'),
                ),
                ElevatedButton(
                  onPressed: deleteFile,
                  child: const Text('Delete'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'File Content:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    fileContent.isEmpty
                        ? 'No content available.'
                        : fileContent,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}