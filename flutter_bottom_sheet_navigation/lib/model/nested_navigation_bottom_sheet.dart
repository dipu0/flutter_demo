import 'package:flutter/material.dart';

import '../main.dart';

class NestedNavigationBottomSheet extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); // key is necessary to access the NavigatorState

  NestedNavigationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          final NavigatorState? childNavigator = navigatorKey.currentState; // manage physical back button
          if (childNavigator != null && childNavigator.canPop()) {
            childNavigator.pop();
          } else {
            Navigator.of(context).pop();
          }
        },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            AppBar(
              title: const Text('Nested Navigation'),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  if (navigatorKey.currentState?.canPop() ?? false) {
                    navigatorKey.currentState?.pop();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
            Expanded(
              child: Navigator(
                key: navigatorKey, // key is necessary to access the NavigatorState
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => const Page1(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

