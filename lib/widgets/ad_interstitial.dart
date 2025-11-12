import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdInterstitial {
  static int _conversionCount = 0;
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoading = false;

  static const String _adUnitId = 'ca-app-pub-7716352626622549/2759073040';

  /// Call this method after each conversion
  static void handleConversion(BuildContext context) {
    _conversionCount++;
    if (_conversionCount % 5 == 0) {
      _loadAndShowAd(context);
    }
  }

  static void _loadAndShowAd(BuildContext context) {
    if (_isAdLoading) return; // prevent multiple simultaneous loads
    _isAdLoading = true;

    // Show loading indicator dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoading = false;
          Navigator.of(context).pop(); // remove loading dialog

          _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
            },
          );

          _interstitialAd?.show();
        },
        onAdFailedToLoad: (error) {
          _isAdLoading = false;
          Navigator.of(context).pop(); // remove loading dialog
          _interstitialAd = null;
        },
      ),
    );
  }
}
