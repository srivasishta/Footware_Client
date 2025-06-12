import 'package:clients/model/product_category/product_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product/product.dart';

class HomeController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  List<Product> products = [];
  List<Product> productShowInUi = [];
  List<ProductCategory> productCategories = [];


  @override
  void onInit() async{
    // TODO: implement onInit
    productCollection=firestore.collection('products');
    categoryCollection=firestore.collection('category');
    await fetchCategory();
    await fetchproducts();
    super.onInit();
  }

  fetchproducts() async{
    try {
      QuerySnapshot productSnapshot = await  productCollection.get();
      final Iterable<Product> retrievedProducts=productSnapshot.docs.map((doc)=> Product.fromJson(doc.data() as Map<String,dynamic>)).toList();
      products.clear();
      products.assignAll(retrievedProducts);
      productShowInUi.assignAll(products);
      Get.snackbar('Sucess', 'Product Fetched sucessfully',colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', 'Product Fetched sucessfully',colorText: Colors.green);
      print(e);
    }finally{
      update();
    }

  }

   fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();

      // Correctly map to a list of ProductCategory objects
      final List<ProductCategory> retrievedCategories = categorySnapshot.docs
          .map((doc) => ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Clear the old categories and add the new ones
      productCategories.clear();
      productCategories.assignAll(retrievedCategories);

      //Get.snackbar('Success', 'Categories fetched successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories: $e', colorText: Colors.red);
      print(e);
    } finally {
      update(); // Notify the UI of state changes
    }
  }

  filterByCategory(String category) {
    productShowInUi=products.where((product) => product.category == category).toList();
    update();
  }

  filterByBrand(List<String> brands){
    if(brands.isEmpty) {
      productShowInUi=products;
    }
    else{
      List<String> lowerCaseBrands = brands.map((brands)=> brands.toLowerCase()).toList();
      productShowInUi=products.where((products)=>lowerCaseBrands.contains(products.brand?.toLowerCase() ?? '')).toList();

    }
    update();
  }

  sortByPrice({required bool ascending}) {
    List<Product> sortedProduct = List<Product>.from(productShowInUi);
    sortedProduct.sort((a,b)=>ascending ? a.price!.compareTo(b.price!): b.price!.compareTo(a.price!));
    productShowInUi=sortedProduct;
    update();
  }

}

