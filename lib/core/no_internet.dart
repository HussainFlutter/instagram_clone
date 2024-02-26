import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void onNoInternet() {
  Connectivity connectivity = Connectivity();
   connectivity.onConnectivityChanged.listen((connection) {
    if (connection == ConnectionState.none) {
      NoInternetScreen();
    }
  });
}

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Center(
          child: Text("No Internet Connection"),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () async {
            setState(() {
              loading = true;
            });
            await Future.delayed(const Duration(seconds: 5));
            setState(() {
              loading = false;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: loading == true
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : const Center(
              child: Text(
                "Retry",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}