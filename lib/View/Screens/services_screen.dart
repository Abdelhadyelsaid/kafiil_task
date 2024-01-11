import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafiil_hiring_app/View/Widgets/services.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:  Text(
          "Services",
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: .05.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ServicesList(),
            Text(
              'Popular Services',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25.sp),
            ),
            const ServicesList(),
          ],
        ),
      ),
    );
  }
}
