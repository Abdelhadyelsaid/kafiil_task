import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({
    Key? key,
    required this.services,
  }) : super(key: key);
  final List<dynamic> services;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: .03.sh),
      child: SizedBox(
        height: .29.sh,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      color: Colors.white,
                      width: .45.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    '${services[index].mainImage}',
                                    height: .15.sh,
                                    width: .45.sw,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Center(
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/images/product.svg",
                                          width: .45.sw,
                                          height: .15.sh,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: .02.sw,
                                    bottom: .02.sw,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xff1DBF73),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        child: Text(
                                          '\$${services[index].price}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: .02.sw, vertical: 10.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    services[index].title,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset('assets/icons/star.svg'),
                                Text(
                                  ' (${services[index].averageRating})   ',
                                  style: const TextStyle(
                                    color: Colors.yellow,
                                  ),
                                ),
                                const Text('|  ',
                                    style: TextStyle(color: Colors.grey)),
                                SvgPicture.asset('assets/icons/icon.svg'),
                                Text(
                                  ' ${services[index].completedSalesCount}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  width: 10.w,
                ),
            itemCount: services.length),
      ),
    );
  }
}
