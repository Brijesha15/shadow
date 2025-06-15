import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SamayikOfTheDayContent extends StatefulWidget {
  const SamayikOfTheDayContent({super.key});

  @override
  State<SamayikOfTheDayContent> createState() => _SamayikOfTheDayContentState();
}

class _SamayikOfTheDayContentState extends State<SamayikOfTheDayContent> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'igR-xa7G4tU', // video id from your HTML
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const satsangOrange = Color(0xffE35925);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 22),
            child: Row(
              children: const [
                Text('Home', style: TextStyle(color: satsangOrange, fontSize: 14)),
                Text(' / ', style: TextStyle(color: Colors.black45, fontSize: 14)),
                Text('Samayik Of The Day', style: TextStyle(color: Colors.black, fontSize: 14)),
              ],
            ),
          ),
          // Title
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 14, bottom: 8),
              child: Text(
                "Samayik Of The Day",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    letterSpacing: 0.4),
              ),
            ),
          ),
          // Video and Details
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Card(
                color: Colors.white,
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Title below video
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          "પાછલા અવતારના માલ સામે આજના જ્ઞાને કરીને પ્રતિક્રમણ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Duration and Share row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.network(
                                'https://satsangtest.dadabhagwan.org/assets/images/icons/clock.svg',
                                width: 16,
                                height: 16,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                "00:13:48",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          // Share Row
                          Row(
                            children: [
                              _ShareFab(
                                iconUrl: 'https://satsangtest.dadabhagwan.org/assets/images/icons/share.svg',
                                menuIcons: [
                                  'https://satsangtest.dadabhagwan.org/assets/images/icons/facebook.svg',
                                  'https://satsangtest.dadabhagwan.org/assets/images/icons/whatsapp.svg',
                                  'https://satsangtest.dadabhagwan.org/assets/images/icons/twitter.svg',
                                  'https://satsangtest.dadabhagwan.org/assets/images/icons/mail.svg',
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareFab extends StatefulWidget {
  final String iconUrl;
  final List<String> menuIcons;
  const _ShareFab({
    required this.iconUrl,
    required this.menuIcons,
  });

  @override
  State<_ShareFab> createState() => _ShareFabState();
}

class _ShareFabState extends State<_ShareFab> {
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (_) {
        setState(() => _showMenu = false);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () {
              setState(() => _showMenu = !_showMenu);
            },
            child: SvgPicture.network(
              widget.iconUrl,
              width: 22,
              height: 22,
              color: Colors.black87,
            ),
          ),
          if (_showMenu)
            Positioned(
              right: 0,
              top: 30,
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(9),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.menuIcons
                        .map(
                          (icon) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () {
                            // TODO: implement sharing logic
                            setState(() => _showMenu = false);
                          },
                          child: SvgPicture.network(
                            icon,
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}