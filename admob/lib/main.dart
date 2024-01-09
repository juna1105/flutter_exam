import 'package:admob/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const AdMobExample());
}

class AdMobExample extends StatelessWidget {
  const AdMobExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AdMob Example'),
        ),
        body: Column(
          children: [
            const Expanded(
              child: Center(
                child: BannerExample(),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2.0),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: InterstitialExample(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerExample extends StatelessWidget {
  const BannerExample({super.key});

  @override
  Widget build(BuildContext context) {
    BannerAd? banner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {},
      ),
      request: const AdRequest(),
    )..load();
    return AdWidget(ad: banner);
  }
}

class InterstitialExample extends StatefulWidget {
  const InterstitialExample({super.key});

  @override
  State<InterstitialExample> createState() => _InterstitialExampleState();
}

class _InterstitialExampleState extends State<InterstitialExample> {
  InterstitialAd? interstitialAd;
  void loadAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  void showAdmob() {
    interstitialAd!.show();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          showAdmob();
        },
        child: const Text('전체 광고 띄우기'),
      ),
    );
  }
}
