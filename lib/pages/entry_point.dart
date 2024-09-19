import 'package:core_dashboard/Screens/inventory_grid.dart';
import 'package:core_dashboard/pages/customerPage.dart';
import 'package:core_dashboard/pages/inventoryPage.dart';
import 'package:core_dashboard/pages/productPage.dart';
import 'package:core_dashboard/responsive.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/widgets/sidemenu/sidebar.dart';
import 'package:core_dashboard/shared/widgets/sidemenu/tab_sidebar.dart';
import 'package:flutter/material.dart';

import '../shared/widgets/header.dart';
import 'dashboard/dashboard_page.dart';

final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  String selectedMenu = "Home"; // Default selected page

  void handleMenuSelection(String menu) {
    setState(() {
      selectedMenu = menu; // Update the selected menu
    });
  }

  Widget getSelectedPage() {
    switch (selectedMenu) {
      case "Home":
        return DashboardPage(); // Your Home/Dashboard page
      case "Products":
        return InventoryPage(); // Replace with your Products page
      case "Customers":
        return Inventory_Grid(); // Replace with your Customers page
      // case "Shop":
      //   return ShopPage(); // Replace with your Shop page
      default:
        return DashboardPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Responsive.isMobile(context)
          ? Sidebar(onMenuItemSelected: handleMenuSelection, selectedMenu: selectedMenu)
          : null,
      body: Row(
        children: [
          if (Responsive.isDesktop(context))
            Sidebar(onMenuItemSelected: handleMenuSelection, selectedMenu: selectedMenu),
          Expanded(
            child: Column(
              children: [
                Header(drawerKey: _drawerKey),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1360),
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDefaults.padding *
                                (Responsive.isMobile(context) ? 1 : 1.5),
                          ),
                          child: SafeArea(child: getSelectedPage()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
