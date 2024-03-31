import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_map_example/data/models/place_model.dart';
import 'package:google_map_example/utils/constants/app_constants.dart';

class FireBaseViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<PlaceModel> places = [];

  Stream<List<PlaceModel>> listenProducts() {
    var temp = FirebaseFirestore.instance
        .collection(AppConstants.nameCollection)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((doc) => PlaceModel.fromJson(doc.data())).toList(),
        );

    return temp;
  }

  insertProducts(PlaceModel productModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.nameCollection)
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.nameCollection)
          .doc(cf.id)
          .update({"doc_id": cf.id});
      if (!context.mounted) return;

      Navigator.pop(context);
      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      debugPrint(error.message);
    }
  }

  updatePlace(PlaceModel productModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.nameCollection)
          .doc(productModel.docId)
          .update(productModel.toJsonForUpdate());
      if (!context.mounted) return;
      Navigator.pop(context);

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      debugPrint(error.message);
    }
  }

  deletePlace(String docId, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.nameCollection)
          .doc(docId)
          .delete();

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      debugPrint(error.message);
    }
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
