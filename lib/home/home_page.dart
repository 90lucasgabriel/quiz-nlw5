import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:quiz/home/home_controller.dart';
import 'package:quiz/home/home_state.dart';
import 'package:quiz/challenge/challenge_page.dart';

import 'package:quiz/home/widgets/appbar/appbar_widget.dart';
import 'package:quiz/home/widgets/level_button/level_button_widget.dart';
import 'package:quiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:quiz/shared/models/question_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.getQuizList();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();

    // final GoogleSignIn googleSignin = GoogleSignIn();
    User _user;

    // Future<User?> _getUser() async {
    //   try {
    //     // if (_user.uid.length > 0) return _user;

    //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //     final GoogleSignInAuthentication googleAuth =
    //         await googleUser!.authentication;

    //     final OAuthCredential credential = GoogleAuthProvider.credential(
    //       accessToken: googleAuth.accessToken,
    //       idToken: googleAuth.idToken,
    //     );

    //     final UserCredential userCredential =
    //         await FirebaseAuth.instance.signInWithCredential(credential);

    //     final User? user = userCredential.user;

    //     return user;
    //   } catch (error) {
    //     return null;
    //   }
    // }

    // void _sendMessage({String value, File file}) async {
    //   final User user = await _getUser();

    //   if (user == null) {
    //     Widget snackbar = SnackBar(
    //       content: Text('Não foi possível realizar o login. Tente novamente.'),
    //       backgroundColor: Colors.red,
    //     );

    //     ScaffoldMessenger.of(context).removeCurrentSnackBar();
    //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
    //   }

    //   Map<String, dynamic> data = {
    //     'senderUid': user.uid,
    //     'senderName': user.displayName,
    //     'senderPhotoUrl': user.photoURL,
    //   };

    //   if (file != null) {
    //     UploadTask task = FirebaseStorage.instance
    //         .ref()
    //         .child(DateTime.now().millisecondsSinceEpoch.toString())
    //         .putFile(file);
    //     TaskSnapshot taskSnapshot = await task.whenComplete(() {});
    //     String url = await taskSnapshot.ref.getDownloadURL();
    //     data['imageUrl'] = url;
    //   }
    //   if (value != null) {
    //     data['value'] = value;
    //   }
    //   FirebaseFirestore.instance.collection('messages').add(data);
    // }
    //

    @override
    void initState() {
      super.initState();

      // FirebaseAuth.instance.authStateChanges().listen((user) {
      //   _user = user ?? {} as User;
      // });
    }

    return FutureBuilder(
      future: _firebaseInit,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done ||
            controller.state == HomeState.success) {
          return Scaffold(
            appBar: AppbarWidget(
                user: controller.user,
                loginAction: controller.getUser,
                logoutAction: controller.logout),
            body: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LevelButtonWidget(label: 'Fácil'),
                      LevelButtonWidget(label: 'Médio'),
                      LevelButtonWidget(label: 'Difícil'),
                      LevelButtonWidget(label: 'Perito'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('quiz')
                          .snapshots(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          default:
                            List<DocumentSnapshot> documentList =
                                snapshot.data?.docs.toList() ?? [];

                            return GridView.builder(
                              itemCount: documentList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemBuilder: (context, index) {
                                return QuizCardWidget(
                                  title: documentList[index].data()?['title'],
                                  quantityAnswered: 1,
                                  totalQuestions: documentList[index]
                                      .data()?['questions']
                                      .length,
                                  onPressed: () {
                                    if (controller.user == null) {
                                      controller.getUser();
                                      return;
                                    }

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChallengePage(
                                          title: documentList[index]
                                              .data()?['title'],
                                          questions: documentList[index]
                                              .data()?['questions']
                                              .map<QuestionModel>((item) =>
                                                  QuestionModel.fromMap(item))
                                              .toList(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
