import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickservice/Components/appBar.dart';
import 'package:quickservice/Components/drawer.dart';
import 'package:quickservice/Provider/providerProfile.dart';

class Servicelist extends StatelessWidget {
  final String serviceLabel;
  const Servicelist({super.key, required this.serviceLabel});

  @override
  Widget build(BuildContext context) {
    final categoryId = serviceLabel.toLowerCase();

    return Scaffold(
      drawer: drawer(),
      appBar: CustomAppBar(textValue: serviceLabel),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId)
            .collection('providers')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No $serviceLabel providers available.",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final refs = snapshot.data!.docs
              .map((doc) => doc['ref'] as DocumentReference)
              .toList();

          return FutureBuilder<List<DocumentSnapshot>>(
            future: Future.wait(refs.map((ref) => ref.get())),
            builder: (context, futureSnapshot) {
              if (!futureSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final providers = futureSnapshot.data!;
              return ListView.builder(
                itemCount: providers.length,
                itemBuilder: (context, index) {
                  final data = providers[index].data() as Map<String, dynamic>;

                  return Card(
                    color: Theme.of(context).colorScheme.tertiary,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: data['profileImageUrl'] != null
                              ? NetworkImage(data['profileImageUrl'])
                              : null,
                          child: data['profileImageUrl'] == null
                              ? Icon(Icons.person)
                              : null,
                          radius: 24,
                        ),
                        title: Text(data['fullName'] ?? 'No Name'),
                        subtitle: Text(data['bio'] ?? 'No bio provided.'),
                        trailing: Text(
                          data['status'] ?? 'Pending',
                          style: TextStyle(
                              color: data['status'] == 'verified'
                                  ? Colors.green
                                  : Colors.orange),
                        ),
                        onTap: () {
                          final doc = providers[index];
                          final data = doc.data() as Map<String, dynamic>;

                          final provider = {
                            'uid': doc.id,
                            ...data,
                          };

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProviderProfilePage(providerData: provider),
                            ),
                          );
                        }),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
