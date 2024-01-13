class Services {
  Services({
    required this.status,
    required this.success,
    required this.data,
  });

  late final int status;
  late final bool success;
  late final List<Data> data;

  Services.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }
}

class Data {
  Data({
    required this.id,
    required this.mainImage,
    required this.price,
    required this.priceAfterDiscount,
    required this.title,
    required this.averageRating,
    required this.completedSalesCount,
    required this.recommended,
  });

  late final int id;
  late final String mainImage;
  late final int price;

  late final int priceAfterDiscount;
  late final String title;
  late final int averageRating;
  late final int completedSalesCount;
  late final bool recommended;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainImage = json['main_image'];
    price = json['price'];
    priceAfterDiscount = json['price_after_discount'];
    title = json['title'];
    averageRating = json['average_rating'];
    completedSalesCount = json['completed_sales_count'];
    recommended = json['recommended'];
  }
}
