import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/CartModel.dart';

class PaymentController extends GetxController {

  
  final String currentUserId =
      FirebaseAuth.instance.currentUser!.uid;

  var isLoading = false.obs;

  // 🔹 GROUP CART BY SELLER
  Map<String, List<CartModel>> groupCartBySeller(
      List<CartModel> cartItems) {
    Map<String, List<CartModel>> map = {};

    for (var item in cartItems) {
      map.putIfAbsent(item.seller_id, () => []);
      map[item.seller_id]!.add(item);
    }

    return map;
  }
  Future<Map<String, dynamic>> fetchSellerData(
      String sellerId) async {
    final userdoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(sellerId)
        .get();
    final profdoc = await FirebaseFirestore.instance.
    collection('profile').
    doc(sellerId).get();

    final userdata = userdoc.data() ?? {};
    final profdata = profdoc.data() ?? {};

    return {...userdata , ...profdata};
  }

  // 🔹 LAUNCH UPI
  Future<void> launchUPI({
    required String upiId,
    required String sellerName,
    required int amount,
    required Function onSuccess,
  }) async {

    final Uri upiUri = Uri.parse(
        "upi://pay?pa=$upiId&pn=$sellerName&am=$amount.00&cu=INR&tn=StudentSwap Order");

      try {
    final launched = await launchUrl(
      upiUri,
      mode: LaunchMode.externalApplication,
    );
    if (launched) {
      onSuccess();
    } else {
      Get.snackbar("Error", "Could not launch UPI app");
    }
  } catch (e) {
    Get.snackbar("No UPI App", "Please install GPay, PhonePe or Paytm");
  }
  }

  // 🔹 CREATE ORDER FOR ONE SELLER
  Future<void> createOrderForSeller({
    required String sellerId,
    required List<CartModel> sellerItems,
    required int amount,
    required String paymentMethod,
    required String paymentStatus,
  }) async {

    isLoading.value = true;

    List<String> productIds = [];

    for (var item in sellerItems) {
      productIds.add(item.id);

      await FirebaseFirestore.instance
          .collection('products')
          .doc(item.id)
          .update({'status': 'reserved'});
    }

    await FirebaseFirestore.instance
        .collection('orders')
        .add({
      'buyerId': currentUserId,
      'sellerId': sellerId,
      'items': productIds,
      'totalAmount': amount,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'orderStatus': 'placed',
      'timestamp': FieldValue.serverTimestamp(),
    });

    await removeSellerItemsFromCart(sellerItems);

    isLoading.value = false;
  }
  Future<void> removeSellerItemsFromCart(
      List<CartModel> sellerItems) async {
    for (var item in sellerItems) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('cart')
          .doc(item.id)
          .delete();
    }
  }
}