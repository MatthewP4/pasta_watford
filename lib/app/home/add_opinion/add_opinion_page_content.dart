import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    super.key,
    required this.onSave,
  });

  final Function onSave;
  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  var restaurantName = '';
  var pastaName = '';
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Podaj nazwe restauracji',
              ),
              onChanged: (newValue) {
                setState(() {
                  restaurantName = newValue;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Podaj nazwę Pasty',
              ),
              onChanged: (newValue) {
                setState(() {
                  pastaName = newValue;
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Slider(
              value: rating,
              min: 1.0,
              max: 6.0,
              divisions: 10,
              label: rating.toString(),
              onChanged: (newValue) {
                setState(() {
                  rating = newValue;
                });
              },
            ),
            ElevatedButton(
              onPressed: restaurantName.isEmpty || pastaName.isEmpty
                  ? null
                  : () {
                      FirebaseFirestore.instance.collection('restaurants').add({
                        'name': restaurantName,
                        'pasta': pastaName,
                        'rating': rating,
                      });
                      widget.onSave;
                    },
              child: const Text(
                'Dodaj',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
