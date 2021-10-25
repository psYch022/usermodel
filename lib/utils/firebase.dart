import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
User? user = firebaseAuth.currentUser;
final Uuid uuid = Uuid();

// Collection refs
CollectionReference usersRef = firestore.collection('thaarusers');
CollectionReference postRef = firestore.collection("thaarorderdata");
CollectionReference truckRef = firestore.collection("thaartruckdata");

// Storage refs
Reference profilePic = storage.ref().child('profile');
Reference order = storage.ref().child('order');
