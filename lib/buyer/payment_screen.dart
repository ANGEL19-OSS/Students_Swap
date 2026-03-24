import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentswap/buyer/Order_success_screen.dart';
import 'package:studentswap/buyer/order_screen.dart';
import '../models/CartModel.dart';
import 'payment_controller.dart';

class PaymentScreen extends StatelessWidget {
  final List<CartModel> cartItems;
  final int totalAmount;

  PaymentScreen({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  final PaymentController controller =
      Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    print('paymentwentin');
    print(cartItems.length);
    final grouped =  controller.groupCartBySeller(cartItems);
     print(grouped.length);
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Obx(() =>
          controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      "Cart Total: ₹$totalAmount",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),       
                    const SizedBox(height: 20),
                    ...grouped.entries.map((entry) {
                      String sellerId = entry.key;
                      List<CartModel> sellerItems =
                          entry.value;

                      int sellerTotal = sellerItems.fold(
                          0,
                          (sum, item) =>
                              sum +
                              int.parse(item.price));

                      return FutureBuilder(
                          future: controller.fetchSellerData(sellerId),
                          builder:
                              (context, snapshot) {

                            if (!snapshot.hasData) {
                              return const SizedBox();
                            }

                            final seller =
                                snapshot.data!;
                            String sellerName =
                                seller['name'];
                            String? upiId = seller['upi_id'];
                            print('upiId is ${upiId}');   

                            return Card(
                             color: Color(0xFF4CB6E6),
                              margin:
                                  const EdgeInsets.only(
                                      bottom: 20),
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(
                                        12),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                          children: [
                                      Text(
                                      sellerName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                          fontWeight:
                                              FontWeight
                                                  .bold),
                                    ),
                                    const SizedBox(
                                        height: 6),
                                    Text(
                                        "Total: ₹$sellerTotal",style: TextStyle(color: Colors.white),),
                                    const SizedBox(
                                        height: 10),
                                    if (upiId != null &&
                                        upiId.isNotEmpty)
                                      ElevatedButton(
                                        onPressed: () {
                                          controller
                                              .launchUPI(
                                            upiId:
                                                upiId,
                                            sellerName:
                                                sellerName,
                                            amount:
                                                sellerTotal,
                                            onSuccess:
                                                () {
                                              showDialog(
                                                context:
                                                    context,
                                                builder:
                                                    (_) =>
                                                        AlertDialog(
                                                  title:
                                                      const Text(
                                                          "Payment Completed?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed:
                                                          () =>
                                                              Navigator.pop(
                                                                  context),
                                                      child:
                                                          const Text(
                                                              "No"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed:
                                                          () async {
                                                        Navigator.pop(
                                                            context);

                                                        await controller.createOrderForSeller(
                                                          sellerId:
                                                              sellerId,
                                                          sellerItems:
                                                              sellerItems,
                                                          amount:
                                                              sellerTotal,
                                                          paymentMethod:
                                                              "UPI",
                                                          paymentStatus:
                                                              "paid",
                                                        );

                                                        Get.off(
                                                            () =>
                                                                const OrderSuccessScreen());
                                                      },
                                                      child:
                                                          const Text(
                                                              "Yes"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: const Text(
                                            "Pay via UPI"),
                                      ),

                                    const SizedBox(
                                        height: 6),

                                    ElevatedButton(
                                      onPressed: () async {

                                        await controller.createOrderForSeller(
                                          sellerId:
                                              sellerId,
                                          sellerItems:
                                              sellerItems,
                                          amount:
                                              sellerTotal,
                                          paymentMethod:
                                              "COD",
                                          paymentStatus:
                                              "pending",
                                        );

                                        Get.off(() => OrderScreen() );
                                      },
                                      child: const Text(
                                          "Cash on Delivery"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }).toList(),
                  ],
                )),
    );
  }
}