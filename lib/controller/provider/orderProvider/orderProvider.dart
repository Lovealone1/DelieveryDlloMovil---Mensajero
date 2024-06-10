import 'package:covefood_domiciliario/model/foodOrderModel.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier{
  FoodOrderModel? orderData; 
  updateFoodOrderData(FoodOrderModel data){
    orderData = data;
    notifyListeners();
  }

  emptyOrderData(){
    
  }
}