import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickservice/Navigation/ChatScreen.dart';

class ProviderProfilePage extends StatelessWidget {
  final Map<String, dynamic> providerData;

  const ProviderProfilePage({super.key, required this.providerData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(providerData['fullName'] ?? "Provider")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: providerData['profileImageUrl'] != null
                  ? NetworkImage(providerData['profileImageUrl'])
                  : null,
              child: providerData['profileImageUrl'] == null
                  ? Icon(Icons.person, size: 60)
                  : null,
            ),
            SizedBox(height: 16),
            Text(
              providerData['fullName'] ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(
              providerData['category'] ?? '',
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(height: 8),
            Text(
              providerData['bio'] ?? 'No bio provided.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.phone, size: 20),
                SizedBox(width: 8),
                Text(providerData['phone'] ?? 'No phone'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.timer, size: 20),
                SizedBox(width: 8),
                Text('${providerData['experience'] ?? '0'} years experience'),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                final providerId = providerData['uid'];
                print("Message button clicked");
                print("User: ${user?.uid}");
                print("Provider: ${providerId}");

                if (user != null && providerId != null) {
                  final chatId = '${user.uid}_$providerId';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        chatId: chatId,
                        userId: user.uid,
                        providerData: providerData,
                      ),
                    ),
                  );
                }
              },
              icon: Icon(Icons.message),
              label: Text("Message"),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Theme.of(context).colorScheme.tertiary),
            )
          ],
        ),
      ),
    );
  }
}
