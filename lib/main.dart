import 'package:flutter/material.dart';
import 'package:future_builder/provider/user_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserApp(),
      child: const MaterialApp(
        home: Scaffold(
          body: WidgetFutureBuilder(title: 'Future Builder demo'),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class WidgetFutureBuilder extends StatefulWidget {
  final String title;
  const WidgetFutureBuilder({super.key, required this.title});
  @override
  State<WidgetFutureBuilder> createState() => _WidgetFutureBuilderState();
}

class _WidgetFutureBuilderState extends State<WidgetFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserApp>(context, listen: false);
    print(data.fetchUsers());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: data.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // Pour les erreurs
              return Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 60,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Card(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(snapshot.data![index].name),
                                      subtitle: Text(
                                        snapshot.data![index].email,
                                      ),
                                      leading: Text(
                                        snapshot.data![index].username,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Aucune donnée disponible.');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}
