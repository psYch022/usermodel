import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thaartransport/modal/usermodal.dart';
import 'package:thaartransport/services/services.dart';
import 'package:thaartransport/utils/firebase.dart';

class LoadService extends Service {
  static uploadload(String? sourcelocation, String? destinationlocation,
      String? material, String? priceunit) async {
    DocumentSnapshot doc =
        await usersRef.doc(firebaseAuth.currentUser!.uid).get();
    var user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    var ref = postRef.doc();

    ref.set({
      "id": ref.id,
      "postid": ref.id,
      "ownerId": user.id,
      "dp": user.photourl,
      "breadth": "",
      "expectedprice": "",
      "height": "",
      "postexpiretime": "",
      "length": "",
      "paymentoption": "",
      "quantity": "",
      "destinationlocation": destinationlocation,
      "priceunit": priceunit,
      "material": material,
      "sourcelocation": sourcelocation,
      "loadposttime": "",
      "usernumber": user.usernumber
    }).catchError((e) {
      print(e);
    });
  }
}
