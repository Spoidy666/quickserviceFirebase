enum ServiceCategory {
  plumber,
  electrician,
  applianceRepair,
  furnitureRepair,
  maidService,
  laundry,
  exteriorHome,
  interiorHome,
  painter,
  blindSetup,
  wallpanels,
  carpenter,
  bathroom,
  basement,
  kitchen,
  garage,
  houseShifting,

  mechanic,
}

extension ServiceCategoryExtension on ServiceCategory {
  String get label {
    switch (this) {
      case ServiceCategory.plumber:
        return "Plumber";
      case ServiceCategory.electrician:
        return "Electrician";
      case ServiceCategory.applianceRepair:
        return "Appliance Repair";
      case ServiceCategory.furnitureRepair:
        return "Furniture Repair";
      case ServiceCategory.mechanic:
        return "Mechanic";
      case ServiceCategory.maidService:
        return "Maid Service";
      case ServiceCategory.laundry:
        return "Laundry";
      case ServiceCategory.exteriorHome:
        return "Exterior Home";
      case ServiceCategory.interiorHome:
        return "Interior Home";
      case ServiceCategory.painter:
        return "Painting";
      case ServiceCategory.blindSetup:
        return "Curtain/Blind Setup";
      case ServiceCategory.wallpanels:
        return "Wall Panels";
      case ServiceCategory.carpenter:
        return "Carpentary";
      case ServiceCategory.bathroom:
        return "Bathroom";
      case ServiceCategory.basement:
        return "Basement";
      case ServiceCategory.kitchen:
        return "Kitchen";
      case ServiceCategory.garage:
        return "Garage";
      case ServiceCategory.houseShifting:
        return "House Shifting";
    }
  }
}
