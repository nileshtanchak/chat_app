// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class BannerListener implements AdListener {
//   BannerAd? _bannerAd;
//   final BannerAdListener _bannerAdListener = const BannerAdListener();
//
//   void loadBannerAd() {
//     _bannerAd = BannerAd(
//       adUnitId: 'your_banner_ad_unit_id',
//       size: AdSize.banner,
//       listener: AdListener(
//         onAdLoaded: onAdLoaded,
//         onAdFailedToLoad: onAdFailedToLoad,
//         onAdOpened: onAdOpened,
//       ),
//       request: const AdRequest(), // Attach the listener to the ad.
//     );
//
//     _bannerAd?.load();
//   }
//
//   void onAdLoaded() {
//     // Handle the ad loaded event.
//   }
//
//   void onAdFailedToLoad(LoadAdError error) {
//     // Handle the ad failed to load event.
//   }
//
//   void onAdOpened() {
//     // Handle the ad opened event (e.g., when a user clicks on the ad).
//   }
// }
