import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(title: 'Riverpod Spinner Demo',
      theme: ThemeData(primarySwatch: Colors.blue), home: MyHomePage());
}

class MyHomePage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
      appBar: AppBar(title: const Text('Riverpod Spinner Question'),),
      body: ref.watch(futureProvider).when(data: (data) => Column(
        children: [
          ElevatedButton(onPressed: () => ref.read(paramProvider.notifier).state = 'new value',
              child: const Text('pretend update')),
          Text(data)],
      ),
          error: (_,__) => const Text('something went wrong'),
          loading: () => const CircularProgressIndicator())
  );
}

final paramProvider = StateProvider((ref) => 'Initial value');

final futureProvider = FutureProvider.autoDispose<String>((ref) async {
  String parameter = ref.watch(paramProvider);
  return pretendApiCall(parameter);
});
Future<String> pretendApiCall(String parameter) async {
  await Future.delayed(const Duration(seconds: 3));
  return parameter;
}
