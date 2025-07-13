import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        physics: BouncingScrollPhysics(),
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
            Padding(
              padding: sectionPadding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Home Repairs & Maintenance",
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
                  ServiceCard(icon: Icons.plumbing, label: 'Plumbing'),
                  ServiceCard(
                      icon: Icons.electrical_services, label: 'Electrical'),
                  ServiceCard(icon: Icons.build, label: 'Appliance Repair'),
                  ServiceCard(icon: Icons.settings, label: 'Furniture Repair'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                  ServiceCard(icon: FontAwesomeIcons.shirt, label: 'Laundary'),
                  ServiceCard(
                      icon: Icons.home_repair_service, label: 'Exterior Home'),
                  ServiceCard(icon: Icons.weekend, label: 'Interior Home'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: sectionPadding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Interior & Design",
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
                  ServiceCard(icon: Icons.brush, label: 'Painting'),
                  ServiceCard(icon: Icons.window, label: 'Curtain/Blind Setup'),
                  ServiceCard(icon: Icons.wallpaper, label: 'Wall Panels'),
                  ServiceCard(icon: Icons.carpenter, label: 'Carpentary'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                  ServiceCard(icon: Icons.bathroom, label: 'Bathroom'),
                  ServiceCard(icon: Icons.foundation, label: 'Basement'),
                  ServiceCard(icon: Icons.kitchen, label: 'Kitchen'),
                  ServiceCard(icon: Icons.garage, label: 'Garage'),
                  ServiceCard(
                      icon: Icons.local_shipping, label: 'House Shifting'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: sectionPadding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Landscaping & Outdoor",
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
                  ServiceCard(icon: Icons.park, label: 'Lawn Maintenance'),
                  ServiceCard(icon: Icons.eco, label: 'Garden Setup'),
                  ServiceCard(
                      icon: Icons.agriculture, label: 'Planting & Soil Prep'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: sectionPadding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Miscellaneous",
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
                      icon: FontAwesomeIcons.treeCity, label: 'Coconut'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
