import 'package:flutter/material.dart';
import 'package:shopping/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Welcome User!"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: const Text(
              "Store",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed(
              AppRoutes.home,
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: const Text(
              "Orders",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed(
              AppRoutes.orders,
            ),
          ),
        ],
      ),
    );
  }
}
