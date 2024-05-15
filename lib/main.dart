import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_domiciliario/controller/provider/authProvider/MobileAuthProvider.dart';
import 'package:food_delievery_domiciliario/controller/provider/profileProvider/profileProvider.dart';
import 'package:food_delievery_domiciliario/firebase_options.dart';
import 'package:food_delievery_domiciliario/view/driverRegistrationScreen/driverRegistrationScreen.dart';
//import 'package:food_delievery_domiciliario/view/signInLogicScreen/signInLoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FoodDelievery());
}

class FoodDelievery extends StatelessWidget {
  const FoodDelievery({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<MobileAuthProvider>(
            create: (_) => MobileAuthProvider(),
          ),
          ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider(),
          ),
          
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          //home: const SignInLogicScreen(),
          home: DriverRegistrationScreen(),
        ),
      );
    });
  }
}
