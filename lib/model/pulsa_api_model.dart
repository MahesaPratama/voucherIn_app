class PulsaModel {
  String? productAmount;
  String? productPrice;

  PulsaModel({this.productAmount, this.productPrice});

  PulsaModel.fromJson(Map<String, dynamic> json) {
    productAmount = json['productAmount'];
    productPrice = json['productPrice'];
  }

  Map<String, dynamic> toJson() {
    return {
      'productAmount': productAmount,
      'productPrice': productPrice,
    };
  }
}
