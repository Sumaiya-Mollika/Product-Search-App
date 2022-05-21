import 'package:flutter/material.dart';
import 'package:q_tech_app/model/product_detail_model.dart';
import '../http_request/http_reqest.dart';

class ProductDetailsProvider extends ChangeNotifier {
  ProductDetails? productDetails;
  bool isLoading = false;
  bool showCartButtonStatus = false;

  int cartItemValue = 0;

  cartItemIncrement() {
    if (cartItemValue < 10) {
      cartItemValue++;
      notifyListeners();
    }
  }

  cartItemDecrement() {
    if (cartItemValue > 0) {
      cartItemValue--;
      notifyListeners();
    }
  }

  showCartButton() {
    showCartButtonStatus = true;
    notifyListeners();
  }

  resetCartButton() {
    showCartButtonStatus = false;
    cartItemValue = 0;
    notifyListeners();
  }

  getProductDetails(String slugName) async {
    isLoading = true;
    productDetails = (await getProductDetail(slugName))!;
    isLoading = false;
    notifyListeners();
  }
}
