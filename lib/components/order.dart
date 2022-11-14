import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping/models/order.dart';

class OrderDetail extends StatefulWidget {
  final Order order;
  const OrderDetail({super.key, required this.order});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool _expand = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() => _expand = !_expand);
            },
            title: Text(
              NumberFormat.currency(
                locale: "pt-BR",
                symbol: "R\$",
              ).format(widget.order.total),
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date!),
            ),
            trailing: IconButton(
              icon: Icon(_expand ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() => _expand = !_expand);
              },
            ),
          ),
          if (_expand)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              height: (widget.order.products!.length * 24.0) + 10,
              child: ListView(
                children: widget.order.products!.map(
                  (prod) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          prod.name!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${prod.quantity}x ${NumberFormat.currency(
                            locale: "pt-BR",
                            symbol: "",
                          ).format(prod.price)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            )
        ],
      ),
    );
  }
}
