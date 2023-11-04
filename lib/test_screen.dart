// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});
//
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   late BannerAd _bannerAd;
//   bool _isBannerAdReady = false;
//   @override
//   void initState() {
//     super.initState();
//     _loadBannerAd();
//   }
//
//   void _loadBannerAd() {
//     _bannerAd = BannerAd(
//       adUnitId: "ca-app-pub-8553620056564402/4531369463",
//       request: const AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         onAdLoaded: (_) {
//           setState(() {
//             _isBannerAdReady = true;
//           });
//         },
//         onAdFailedToLoad: (ad, err) {
//           _isBannerAdReady = false;
//           ad.dispose();
//         },
//       ),
//     );
//
//     _bannerAd.load();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
//         title: const Text("Second Screen"),
//       ),
//       // app_id:- ca-app-pub-8553620056564402~1550779067
//       // unit_id:- ca-app-pub-8553620056564402/4531369463
//       bottomNavigationBar: _isBannerAdReady
//           ? AdWidget(
//               ad: BannerAd(
//                 adUnitId: 'ca-app-pub-8553620056564402/4531369463',
//                 size: AdSize.banner,
//                 listener: const BannerAdListener(),
//                 request: const AdRequest(contentUrl: "https://google.com"),
//               ),
//             )
//           : const SizedBox(),
//       body: const Center(
//         child: Text("Second Screen"),
//       ),
//     );
//   }
// }
