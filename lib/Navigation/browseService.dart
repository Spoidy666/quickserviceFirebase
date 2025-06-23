import 'package:flutter/material.dart';
import 'package:quickservice/Components/appBar.dart';
import 'package:quickservice/Components/drawer.dart';
import 'package:quickservice/Components/serviceCard.dart';

class BrowseCategoryPage extends StatelessWidget {
  BrowseCategoryPage({super.key});
  final _searchController = TextEditingController();

  final EdgeInsets sectionPadding =
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        textValue: 'Browse',
      ),
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),

            // Section 1: Cleaning Services
            Padding(
              padding: sectionPadding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Cleaning Services",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
                children: const [
                  ServiceCard(
                      icon: Icons.cleaning_services, label: 'Maid Service'),
                  ServiceCard(icon: Icons.crop_16_9, label: 'Carpet'),
                  ServiceCard(icon: Icons.window, label: 'Windows'),
                  ServiceCard(
                      icon: Icons.home_repair_service, label: 'Exterior Home'),
                  ServiceCard(icon: Icons.weekend, label: 'Interior Home'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Section 2: Additions & Remodels
            Padding(
              padding: sectionPadding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Additions & Remodels",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
                children: const [
                  ServiceCard(icon: Icons.add_business, label: 'Additions'),
                  ServiceCard(icon: Icons.bathroom, label: 'Bathroom'),
                  ServiceCard(icon: Icons.foundation, label: 'Basement'),
                  ServiceCard(icon: Icons.kitchen, label: 'Kitchen'),
                  ServiceCard(icon: Icons.garage, label: 'Garage'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
