//service untuk splash

class SplashService {
  Future<void> execute() async {
    const int lastNimDigit = 9;

    await Future.delayed(Duration(seconds: lastNimDigit));
  }
}