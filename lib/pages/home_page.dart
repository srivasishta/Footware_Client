import 'package:clients/controller/home_controller.dart';
import 'package:clients/pages/login_page.dart';
import 'package:clients/widgets/multi_select_drop_down.dart';
import 'package:clients/widgets/product_card.dart';
import 'package:clients/widgets/product_description.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/drop_down_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchproducts();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Footwear Store',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GetStorage box = GetStorage();
                  box.erase();
                  Get.offAll(LoginPage());
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.productCategories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.filterByCategory(ctrl.productCategories[index].name ?? '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Chip(label: Text(ctrl.productCategories[index].name ?? 'Error')),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: DropDownButton(
                        items: ['Rs: Low to High', 'Rs: High to Low'],
                        selectedItemText: 'Sort',
                        Onselected: (selected) {
                          ctrl.sortByPrice(ascending: selected == 'Rs: Low to High');
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: MultiSelectDropDown(
                        items: ['Puma', 'Nike', 'Sketchers', 'Reebok'],
                        onSelectionChanged: (selectedItems) {
                          ctrl.filterByBrand(selectedItems);
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: ctrl.productShowInUi.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: ctrl.productShowInUi[index].name ?? 'No Name',
                        price: ctrl.productShowInUi[index].price ?? 0,
                        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoNxyewP33D-h9nBz9kLEJ9moeq6Fhk1qrlg&s',
                        offerTag: '30% off',
                        onTap: () {
                          Get.to(ProductDescription(),arguments: {'data':ctrl.productShowInUi[index]});
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}