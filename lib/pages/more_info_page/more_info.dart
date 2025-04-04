// Settings page.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../custom_widgets/default_card.dart';

class MoreInfoPage extends ConsumerStatefulWidget {
  const MoreInfoPage({super.key});

  @override
  ConsumerState<MoreInfoPage> createState() => _MoreInfoPageState();
}

var moreInfoOptions = [
  [
    "App Version:",
    "Loading...",
    null,
  ],
  [
    "Collaborators",
    "See the team behind this app",
    "/collaborators",
  ],
  [
    "Privacy Policy",
    "Read more",
    "/privacy-policy",
  ],
];

class _MoreInfoPageState extends ConsumerState<MoreInfoPage> {
  @override

  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      moreInfoOptions[0][1] = packageInfo.version;
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('App Info'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        physics: const BouncingScrollPhysics(),
        itemCount: moreInfoOptions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, i) {
          List option = moreInfoOptions[i];
          return DefaultCard(
            onTap: () {
              if (option[2] != null) {
                Navigator.of(context).pushNamed(option[2] as String);
              }
            },
            child: Row(
              children: [
                const SizedBox(width: 12.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option[0].toString(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      option[1].toString(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
