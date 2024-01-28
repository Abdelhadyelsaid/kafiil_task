
import 'package:flutter/material.dart';
import 'package:kafiil_hiring_app/helper/cache_helper.dart';

String? token = CacheHelper.getData(key: "token");
bool? firstTime = CacheHelper.getData(key: "firstTime");
double? lat = CacheHelper.getData(key: "lat");
double? long = CacheHelper.getData(key: "long");

void onSuccess({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.green,
  ));
}

void onError({
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    content: Text("Something went wrong!"),
    backgroundColor: Colors.red,
  ));
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void replaceTo(context, widget) =>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);


