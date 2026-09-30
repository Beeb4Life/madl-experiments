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
      title: 'Common Flutter Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  bool isChecked = false;
  bool isSwitched = false;
  String selectedValue = 'Flutter';
  String gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Common Flutter Widgets'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Text Widget
            const Text(
              'Welcome to Flutter',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 15),

            // TextField Widget
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter your name',
                hintText: 'Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 15),

            // ElevatedButton Widget
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Button Pressed!'),
                    ),
                  );
                },
                child: const Text('Submit'),
              ),
            ),

            // Checkbox Widget
            CheckboxListTile(
              title: const Text('Accept Terms and Conditions'),
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),

            // Switch Widget
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),

            const Text(
              'Select Gender:',
              style: TextStyle(fontSize: 18),
            ),

            // Radio Widgets
            RadioListTile<String>(
              title: const Text('Male'),
              value: 'Male',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Female'),
              value: 'Female',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),

            // DropdownButton Widget
            DropdownButtonFormField<String>(
              value: selectedValue,
              decoration: const InputDecoration(
                labelText: 'Select Technology',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Flutter',
                  child: Text('Flutter'),
                ),
                DropdownMenuItem(
                  value: 'Android',
                  child: Text('Android'),
                ),
                DropdownMenuItem(
                  value: 'React Native',
                  child: Text('React Native'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            // ListView using ListTile
            const Text(
              'List of Widgets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                subtitle: Text('Home Screen'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                subtitle: Text('Application Settings'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),

          ],
        ),
      ),

      // FloatingActionButton Widget
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
