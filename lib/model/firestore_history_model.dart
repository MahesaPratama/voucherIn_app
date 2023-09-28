class History {
  String number = '';
  String date = '';
  String product = '';
  String price = '';
  String paymentMethod = '';

  History({
    required this.number,
    required this.date,
    required this.product,
    required this.price,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() => {
        'number': number,
        'date': date,
        'product': product,
        'price': price,
        'payment' : paymentMethod
      };

  static History fromJson(Map<String, dynamic> json) => History(
      number: json['number'],
      date: json['date'],
      product: json['product'],
      price: json['price'],
      paymentMethod: json['payment']);
}
