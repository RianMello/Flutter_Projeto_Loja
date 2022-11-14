import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping/components/drawer.dart';
import 'package:shopping/components/order.dart';
import 'package:shopping/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Finished Orders"),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (ctx, i) => OrderDetail(order: orders.items[i])),
    );
  }
}
