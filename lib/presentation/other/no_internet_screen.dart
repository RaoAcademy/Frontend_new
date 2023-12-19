import 'package:flutter/material.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/other/no-wifi.png",height: 200,width: 200,),
            Text("Oops!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 32),),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Please check your internet connection and try again.",textAlign: TextAlign.center,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500,fontSize: 18),),
            ),

          ],
        ),
      ),
    );
  }
}
