// filepath: lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'chat_screen.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp(); // Splash sonrası otomatik geçiş için tekrar aktif edildi
  }

  Future<void> _initializeApp() async {
    try {
      // Firebase başlatma
      
      // 2 saniye bekle
      await Future.delayed(Duration(seconds: 2));
      
      // Ana ekrana geç
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      }
    } catch (e) {
  
      // Hata olsa bile ana ekrana git
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo/Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.restaurant_menu,
                size: 60,
                color: Colors.green,
              ),
            ),
            
            SizedBox(height: 30),
            
            // Uygulama adı
            Text(
              kAppName,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            SizedBox(height: 10),
            
            Text(
              'Yapay Zeka ile Tarif Önerileri',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            
            SizedBox(height: 50),
            
            // Loading animasyonu
            LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 50,
            ),
            
            SizedBox(height: 20),
            
            Text(
              'Hazırlanıyor...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}