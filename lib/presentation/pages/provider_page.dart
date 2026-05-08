import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/counter_viewmodel.dart';

class ProviderPage extends StatelessWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Provider Counter")),
      body: Center(
        child: Text(
          "${counter.value}",
          style: const TextStyle(fontSize: 40),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "inc",
            onPressed: counter.increment,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "dec",
            onPressed: counter.decrement,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
