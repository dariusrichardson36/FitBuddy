import 'package:flutter/material.dart';

class CreateWorkoutPage extends StatefulWidget {
  const CreateWorkoutPage({Key? key}) : super(key: key);

  @override
  _CreateWorkoutPageState createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("log workout"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Publish'),
                SizedBox(width: 8.0),
                Icon(Icons.check, color: Colors.white)
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Workout description',
                border: OutlineInputBorder(),
                suffixText: '0/60',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                // Handle Add exercise action here
              },
              icon: Icon(Icons.add),
              label: Text("Add exercise"),
            )
          ],
        ),
      ),
    );
  }
}
