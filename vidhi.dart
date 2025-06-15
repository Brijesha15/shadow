import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VidhiContent extends StatefulWidget {
  const VidhiContent({super.key});

  @override
  State<VidhiContent> createState() => _VidhiContentState();
}

class _VidhiContentState extends State<VidhiContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late YoutubePlayerController _youtubeController;

  final List<Tab> tabs = const [
    Tab(text: 'Listen'),
    Tab(text: 'Watch'),
    Tab(text: 'Read'),
  ];

  final List<Map<String, dynamic>> _readLinks = [
    {"lang": "Gujarati", "pages": 47, "download": "https://www.dadabhagwan.org/download/gujarati.pdf"},
    {"lang": "Hindi", "pages": 47, "download": "https://www.dadabhagwan.org/download/hindi.pdf"},
    {"lang": "English", "pages": 35, "download": "https://www.dadabhagwan.org/download/english.pdf"},
    {"lang": "German", "pages": 39, "download": "https://www.dadabhagwan.org/download/german.pdf"},
    {"lang": "Spanish", "pages": 34, "download": "https://www.dadabhagwan.org/download/spanish.pdf"},
    {"lang": "Portuguese", "pages": 34, "download": "https://www.dadabhagwan.org/download/portuguese.pdf"},
    {"lang": "Marathi", "pages": 45, "download": "https://www.dadabhagwan.org/download/marathi.pdf"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'fKnRh3Do5U8',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<List<_VidhiMusicItem>> fetchMusicList() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const [
      _VidhiMusicItem(
        title: '01 Trimantra',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/01+Trimantra',
        downloadUrl: 'https://hearthis.at/dadabhagwan/trimantra/download/',
        duration: '00:00:48',
      ),
      _VidhiMusicItem(
        title: '02 Pratah Vidhi',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/02+Pratah+Vidhi',
        downloadUrl: 'https://hearthis.at/dadabhagwan/pratah-vidhi/download/',
        duration: '00:04:51',
      ),
      _VidhiMusicItem(
        title: '03 Namaskar Vidhi',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/03+Namaskar+Vidhi',
        downloadUrl: 'https://hearthis.at/dadabhagwan/namaskar-vidhi/download/',
        duration: '00:04:10',
      ),
      _VidhiMusicItem(
        title: '04 Nav Kalamo',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/04+Nav+Kalamo',
        downloadUrl: 'https://hearthis.at/dadabhagwan/nav-kalamo/download/',
        duration: '00:04:06',
      ),
      _VidhiMusicItem(
        title: '05 Shuddhatma Pratye Prathna',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/05+Shuddhatma+Pratye+Prathna',
        downloadUrl: 'https://hearthis.at/dadabhagwan/shuddhatma-pratye-prathna/download/',
        duration: '00:01:26',
      ),
      _VidhiMusicItem(
        title: '06 Simandhar Swami Prathna',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/06+Simandhar+Swami+Prathna',
        downloadUrl: 'https://hearthis.at/dadabhagwan/simandhar-swami-prathna/download/',
        duration: '00:03:42',
      ),
      _VidhiMusicItem(
        title: '08 Aho Swami Simandhar',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/08+Aho+Swami+Simandhar',
        downloadUrl: 'https://hearthis.at/dadabhagwan/aho-swami-simandhar/download/',
        duration: '00:00:26',
      ),
      _VidhiMusicItem(
        title: '09 Aho Dada Bhagwan',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/09+Aho+Dada+Bhagwan',
        downloadUrl: 'https://hearthis.at/dadabhagwan/aho-dada-bhagwan/download/',
        duration: '00:00:25',
      ),
      _VidhiMusicItem(
        title: '11 Dada Stuti',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/11+Dada+Stuti',
        downloadUrl: 'https://hearthis.at/dadabhagwan/dada-stuti/download/',
        duration: '00:03:27',
      ),
      _VidhiMusicItem(
        title: '12 Rajipo',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/12+Rajipo',
        downloadUrl: 'https://hearthis.at/dadabhagwan/rajipo/download/',
        duration: '00:01:21',
      ),
      _VidhiMusicItem(
        title: '13 Sarwaswa Amaru Arpan',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/13+Sarwaswa+Amaru+Arpan',
        downloadUrl: 'https://hearthis.at/dadabhagwan/sarwaswa-amaru-arpan/download/',
        duration: '00:06:32',
      ),
      _VidhiMusicItem(
        title: '14 Devo Ne Avahan',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/14+Devo+Ne+Avahan',
        downloadUrl: 'https://hearthis.at/dadabhagwan/devo-ne-avahan/download/',
        duration: '00:03:42',
      ),
      _VidhiMusicItem(
        title: '15 Dada Bhagwan Na Asim Jay Jay Kaar Ho',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/15+Dada+Bhagwan+Na+Asim+Jay+Jay+Kaar+Ho',
        downloadUrl: 'https://hearthis.at/dadabhagwan/dada-bhagwan-na-asim-jay-jay-kaar-ho/download/',
        duration: '00:08:05',
      ),
      _VidhiMusicItem(
        title: '16 Jagat Kalyan ni Bhavna',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/16+Jagat+Kalyan+ni+Bhavna',
        downloadUrl: 'https://hearthis.at/dadabhagwan/jagat-kalyanni-bhavna/download/',
        duration: '00:02:50',
      ),
      _VidhiMusicItem(
        title: '17 All Vidhis',
        url: 'https://www.dadabhagwan.fm/Home/SpiritualSongs/Nirumana+Shrimukhe+Aarti-Vidhi/17+All+Vidhis',
        downloadUrl: 'https://hearthis.at/dadabhagwan/all-vidhis/download/',
        duration: '00:42:52',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const satsangOrange = Color(0xffE35925);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DefaultTabController(
        length: tabs.length,
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
                  Text('Vidhi', style: TextStyle(color: Colors.black, fontSize: 14)),
                ],
              ),
            ),
            // Title
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14, bottom: 8),
                child: Text(
                  "Vidhi",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                      letterSpacing: 0.4),
                ),
              ),
            ),
            // Tabs: Listen / Watch / Read
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: satsangOrange,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: satsangOrange,
                  unselectedLabelColor: Colors.black45,
                  labelStyle: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  tabs: tabs,
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Color(0xffeeeeee)),
            // Give TabBarView a fixed height for no overflow
            LayoutBuilder(
                builder: (context, constraints) {
                  double tabViewHeight = 0.0;
                  double screenHeight = MediaQuery.of(context).size.height;
                  tabViewHeight = screenHeight * 0.66;
                  if (tabViewHeight < 400) tabViewHeight = 400;
                  if (tabViewHeight > 700) tabViewHeight = 700;
                  return SizedBox(
                    height: tabViewHeight,
                    child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        FutureBuilder<List<_VidhiMusicItem>>(
                          future: fetchMusicList(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            final musicList = snapshot.data!;
                            // Responsive: Use LayoutBuilder to switch between list/grid
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth < 600) {
                                  // Mobile: single column
                                  return ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemCount: musicList.length,
                                    separatorBuilder: (_, __) =>
                                    const Divider(height: 1, color: Color(0xfff0f0f0)),
                                    itemBuilder: (context, index) => _MusicRow(
                                      item: musicList[index],
                                      highlight: false,
                                    ),
                                  );
                                } else if (constraints.maxWidth < 1000) {
                                  // Tablet: two columns
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: musicList.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 72,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 0,
                                    ),
                                    itemBuilder: (context, index) => _MusicRow(
                                      item: musicList[index],
                                      highlight: false,
                                    ),
                                  );
                                } else {
                                  // Desktop: three columns
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: musicList.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: 72,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 0,
                                    ),
                                    itemBuilder: (context, index) => _MusicRow(
                                      item: musicList[index],
                                      highlight: false,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 640),
                              child: Card(
                                color: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // YouTube Player
                                      AspectRatio(
                                        aspectRatio: 20 / 9,
                                        child: YoutubePlayer(
                                          controller: _youtubeController,
                                          showVideoProgressIndicator: true,
                                        ),
                                      ),
                                      // Title
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          "Vidhi",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      // Duration and Download
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.access_time, size: 16, color: Colors.black54),
                                                const SizedBox(width: 4),
                                                Text(
                                                  "00:19:21",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              icon: SvgPicture.network(
                                                'https://satsangtest.dadabhagwan.org/assets/images/icons/download.svg',
                                                width: 20,
                                                height: 20,
                                                color: Colors.black87,
                                              ),
                                              onPressed: () {
                                                // TODO: Implement download functionality
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // READ TAB
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              bool twoCols = constraints.maxWidth > 900;
                              List left = [];
                              List right = [];

                              for (int i = 0; i < _readLinks.length; i++) {
                                if (twoCols) {
                                  if (i.isEven) {
                                    left.add(_readLinks[i]);
                                  } else {
                                    right.add(_readLinks[i]);
                                  }
                                } else {
                                  left.add(_readLinks[i]);
                                }
                              }

                              Widget buildCol(List col) => Column(
                                children: List.generate(col.length, (idx) {
                                  final item = col[idx];
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 8),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Charan Vidhi",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.black87,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: " (${item['lang']})",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "${item['pages']} Pages",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffF5F6F7),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(10),
                                            onTap: () => _launchReadUrl(item['download']),
                                            child: Container(
                                              width: 38,
                                              height: 38,
                                              alignment: Alignment.center,
                                              child: SvgPicture.network(
                                                'https://satsangtest.dadabhagwan.org/assets/images/icons/download.svg',
                                                width: 20,
                                                height: 20,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );

                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    twoCols
                                        ? Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: buildCol(left)),
                                        Expanded(child: buildCol(right)),
                                      ],
                                    )
                                        : buildCol(left),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}

void _launchReadUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    // handle error
  }
}

class _VidhiMusicItem {
  final String title;
  final String url;
  final String downloadUrl;
  final String duration;

  const _VidhiMusicItem({
    required this.title,
    required this.url,
    required this.downloadUrl,
    required this.duration,
  });
}

class _MusicRow extends StatelessWidget {
  final _VidhiMusicItem item;
  final bool highlight;
  static const Color satsangOrange = Color(0xffE39525);

  const _MusicRow({required this.item, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.width < 600
        ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
        : const EdgeInsets.symmetric(horizontal: 18, vertical: 8);

    return Material(
      color: highlight ? const Color(0xffF6F7F8) : Colors.transparent,
      child: InkWell(
        onTap: () => _launchUrl(item.url),
        child: Padding(
          padding: padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 15, color: Colors.black45),
                        const SizedBox(width: 5),
                        Text(
                          item.duration,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _SquareButton(
                svgUrl: 'https://satsangtest.dadabhagwan.org/assets/images/icons/download.svg',
                onTap: () => _launchUrl(item.downloadUrl),
              ),
              const SizedBox(width: 7),
              _SquareButton(
                svgUrl: 'https://satsangtest.dadabhagwan.org/assets/images/icons/share.svg',
                onTap: () {
                  // TODO: implement share logic using share_plus
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print('Could not launch $url');
    }
  }
}

class _SquareButton extends StatelessWidget {
  final String svgUrl;
  final VoidCallback onTap;
  const _SquareButton({required this.svgUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF5F6F7),
      borderRadius: BorderRadius.circular(12),
      elevation: 0.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          child: SvgPicture.network(
            svgUrl,
            width: 20,
            height: 20,
            color: Colors.black87,
            placeholderBuilder: (context) => const SizedBox(
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }
}