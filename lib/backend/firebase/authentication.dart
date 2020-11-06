import 'package:firebase_auth/firebase_auth.dart';
import 'package:mate_op/backend/firebase/data.dart';
import 'package:mate_op/models/user.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

User currentUser() {
  return _auth.currentUser;
}

Future<MOUser> signIn(email, password) async {
  UserCredential userCredential;
  try {
    userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  } catch (error) {
    return null;
  }
  MOUser user = MOUser.fromJson(await getUserMetadata(userCredential.user.uid));
  user.firebaseUser = userCredential.user;
  return user;
}

Future<MOUser> getUserObject(User firebaseUser) async {
  MOUser user = MOUser.fromJson(await getUserMetadata(firebaseUser.uid));
  user.firebaseUser = firebaseUser;
  return user;
}

Future<bool> recover(email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
    return true;
  } catch (error) {
    return false;
  }
}

Future<bool> signOut() async {
  await _auth.signOut();
  return true;
}
