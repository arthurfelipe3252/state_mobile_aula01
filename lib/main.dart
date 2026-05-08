import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart' as provider;

import 'data/datasources/api_product_remote_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/viewmodels/api_product_viewmodel.dart';
import 'presentation/viewmodels/counter_viewmodel.dart';
import 'presentation/viewmodels/product_viewmodel.dart';

void main() {
  final httpClient = http.Client();
  final apiProductDatasource =
      ApiProductRemoteDatasource(client: httpClient);
  final productRepository =
      ProductRepositoryImpl(datasource: apiProductDatasource);

  runApp(
    ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(
            create: (_) => CounterViewModel(),
          ),
          provider.ChangeNotifierProvider(
            create: (_) => ProductViewModel(),
          ),
          provider.ChangeNotifierProvider(
            create: (_) => ApiProductViewModel(repository: productRepository),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Patterns',
      home: const HomePage(),
    );
  }
}
