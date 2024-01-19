import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training/controller/notifications.dart';

class NotificationPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(notificationProvider);

    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Show Notification'),
          onPressed: viewModel.showNotification,
        ),
      ),
    );
  }
}
