import 'dart:convert';
import 'dart:developer';

import 'package:covefood_domiciliario/constant/constant.dart';
import 'package:covefood_domiciliario/controller/provider/profileProvider/profileProvider.dart';
import 'package:covefood_domiciliario/model/driverModel/driverModel.dart';
import 'package:covefood_domiciliario/model/foodOrderModel.dart';
import 'package:covefood_domiciliario/widgets/toastService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderServices {
  static fetchOrderDetails(String orderID) async {
    try {
      var snapshot = await realTimeDatabaseRef.child('Orders/$orderID').get();
      FoodOrderModel foodData = FoodOrderModel.fromMap(
          jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>);
      return foodData;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static updateDriverProfileIntoFoodOrderModel(
      String orderID, BuildContext context) async {
    DriverModel delieveryPartnerData =
        context.read<ProfileProvider>().driverProfile!;
    realTimeDatabaseRef
        .child('Orders/$orderID/delieveryPartnerData')
        .set(delieveryPartnerData.toMap());
    realTimeDatabaseRef
        .child('Driver/${auth.currentUser!.uid}/activeDelieveryRequestID')
        .set(orderID);
  }

  static orderStatus(int status) {
    switch (status) {
      case 0:
        return 'PREPARANDO_COMIDA';
      case 1:
        return 'COMIDA_RECOGIDA_POR_DOMICILIARIO';
      case 2:
        return 'COMIDA_ENTREGADA';
    }
  }

  static addOrderDataToHistory(FoodOrderModel foodOrderData, BuildContext context) async{
    FoodOrderModel foodData = FoodOrderModel(
      foodDetails: foodOrderData.foodDetails,
      restaurantDetails: foodOrderData.restaurantDetails,
      userAddress: foodOrderData.userAddress,
      userData: foodOrderData.userData,
      delieveryPartnerData: foodOrderData.delieveryPartnerData,
      orderID: foodOrderData.orderID,
      orderStatus: foodOrderData.orderStatus,
      restaurantUID: foodOrderData.restaurantUID,
      userUID: foodOrderData.userUID,
      delieveryGuyUID: auth.currentUser!.uid,
      addedToCartAt: foodOrderData.addedToCartAt,
      orderPlacedAt: foodOrderData.orderPlacedAt,
      orderDelieveredAt: DateTime.now(),
    );
    String orderHistoryID = uuid.v1();
    realTimeDatabaseRef
        .child('OrderHistory/$orderHistoryID')
        .set(foodData.toMap())
        .then((value) {
      ToastService.sendScaffoldAlert(
        msg: 'La orden se guardó en el historial',
        toastStatus: 'SUCCESS',
        context: context,
      );
    }).onError((error, stackTrace) {
      ToastService.sendScaffoldAlert(
        msg: 'Error al agregar al historial',
        toastStatus: 'ERROR',
        context: context,
      );
    });
  }

static removeOrder(String orderID) {
    realTimeDatabaseRef.child('Orders/$orderID').remove();
  }
}
