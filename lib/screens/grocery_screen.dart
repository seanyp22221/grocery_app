import 'package:flutter/material.dart';
import 'package:grocery_app/services/grocery_service.dart';


class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  final GroceryService groceryService = GroceryService();
  final TextEditingController controller = TextEditingController();

  void addItem() {
    groceryService.addItem(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Grocery List')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: TextField(controller: controller, decoration: InputDecoration(hintText: "Enter item"))),
                IconButton(onPressed: addItem, icon: Icon(Icons.add)),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: groceryService.getItems(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index];
                    return ListTile(
                      title: Text(data['name']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => groceryService.deleteItem(data.id),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
