import 'package:flutter/material.dart';
import 'package:quickservice/Components/appBar.dart';
import 'package:quickservice/Components/drawer.dart';
import 'package:quickservice/Components/location_picker.dart';
import 'package:quickservice/Components/serviceCard.dart';
import 'package:quickservice/auth/auth.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final List<Map<String, dynamic>> services = [
    {'title': 'Cleaning', 'icon': Icons.cleaning_services},
    {'title': 'Handyman', 'icon': Icons.engineering},
    {'title': 'House Shifting', 'icon': Icons.local_shipping},
    {'title': 'Assembly', 'icon': Icons.build},
    {'title': 'Delivery', 'icon': Icons.delivery_dining},
    {'title': 'Business', 'icon': Icons.business_center},
    {'title': 'Events', 'icon': Icons.event},
    {'title': 'Gardening', 'icon': Icons.grass},
    {'title': 'Maid', 'icon': Icons.person},
  ];

  final ValueNotifier<String?> _locationText = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        textValue: '',
      ),
      drawer: drawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(width: 3, color: Colors.grey),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.all(16),
              child: DefaultTextStyle(
                style: TextStyle(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi,",
                        style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.primary)),
                    Text(
                      getCurrentUser()!.displayName.toString(),
                      style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final location = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LocationPickerPage(),
                              ),
                            );

                            if (location != null) {
                              _locationText.value = location['address'];
                            }
                          },
                          icon: const Icon(
                            Icons.location_on,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: ValueListenableBuilder<String?>(
                            valueListenable: _locationText,
                            builder: (context, value, _) {
                              return Text(
                                value ?? "Select your \nlocation",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Service Category",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
              children: services.map((service) {
                return ServiceCard(
                  icon: service['icon'],
                  label: service['title'],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
