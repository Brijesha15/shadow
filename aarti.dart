import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AartiContent extends StatefulWidget {
  const AartiContent({super.key});

  @override
  State<AartiContent> createState() => _AartiContentState();
}

class _AartiContentState extends State<AartiContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> tabs = const [
    Tab(text: 'Listen'),
    Tab(text: 'Watch'),
    Tab(text: 'Read'),
  ];

  final List<Map<String, String>> aartiList = [
    {
      "title": "01 Trimantra Dadashri",
      "duration": "00:00:47",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/01+Trimantra+Dadashri",
      "download": "https://hearthis.at/dadabhagwan/01-trimantra-dadashri-Dm6/download/"
    },
    {
      "title": "02 Simandhar Swami Divo",
      "duration": "00:04:14",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/02+Simandhar+Swami+Divo",
      "download": "https://hearthis.at/dadabhagwan/02-simandhar-swami-divo/download/"
    },
    {
      "title": "03 Simandhar Swami Aarti",
      "duration": "00:05:26",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/03+Simandhar+Swami+Aarti",
      "download": "https://hearthis.at/dadabhagwan/03-simandhar-swami-aarti/download/"
    },
    {
      "title": "04 Aho Swami Simandhar",
      "duration": "00:00:34",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/04+Aho+Swami+Simandhar",
      "download": "https://hearthis.at/dadabhagwan/04-aho-swami-simandhar/download/"
    },
    {
      "title": "05 Aho Dada Bhagwan",
      "duration": "00:00:34",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/05+Aho+Dada+Bhagwan",
      "download": "https://hearthis.at/dadabhagwan/05-aho-dada-bhagwan/download/"
    },
    {
      "title": "06 Dada Bhagwan Aarti",
      "duration": "00:04:56",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/06+Dada+Bhagwan+Aarti",
      "download": "https://hearthis.at/dadabhagwan/06-dada-bhagwan-aarti/download/"
    },
    {
      "title": "07 Dadashri Stuti",
      "duration": "00:02:25",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/07+Dadashri+Stuti",
      "download": "https://hearthis.at/dadabhagwan/07-dadashri-stuti/download/"
    },
    {
      "title": "08 Rajipo",
      "duration": "00:01:25",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/08+Rajipo",
      "download": "https://hearthis.at/dadabhagwan/08-rajipo/download/"
    },
    {
      "title": "09 Dada Divo 1",
      "duration": "00:02:31",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/09+Dada+Divo+1",
      "download": "https://hearthis.at/dadabhagwan/09-dada-divo-1/download/"
    },
    {
      "title": "10 Dada Divo 2",
      "duration": "00:03:29",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/10+Dada+Divo+2",
      "download": "https://hearthis.at/dadabhagwan/10-dada-divo-2/download/"
    },
    {
      "title": "11 Gokul Thi Somnath",
      "duration": "00:01:00",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/11+Gokul+Thi+Somnath",
      "download": "https://hearthis.at/dadabhagwan/11-gokul-thi-somnath/download/"
    },
    {
      "title": "12 Shri Krishna Aarti",
      "duration": "00:03:13",
      "url": "https://www.dadabhagwan.fm/Home/SpiritualSongs/Aarti/12+Shri+Krishna+Aarti",
      "download": "https://hearthis.at/dadabhagwan/12-shri-krishna-aarti/download/"
    },
    // Add more as needed...
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final satsangOrange = const Color(0xffE35925);

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
                children: [
                  Text('Home', style: TextStyle(color: satsangOrange, fontSize: 14)),
                  const Text(' / ', style: TextStyle(color: Colors.black45, fontSize: 14)),
                  const Text('Aarti', style: TextStyle(color: Colors.black, fontSize: 14)),
                ],
              ),
            ),
            // Title
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14, bottom: 8),
                child: Text(
                  "Aarti",
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
            // Expanded for proper layout in desktop
            LayoutBuilder(
              builder: (context, constraints) {
                double tabViewHeight = MediaQuery.of(context).size.height * 0.66;
                if (tabViewHeight < 400) tabViewHeight = 400;
                if (tabViewHeight > 700) tabViewHeight = 700;
                return SizedBox(
                  height: tabViewHeight,
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // LISTEN TAB
                      _AartiListenList(aartiList: aartiList),
                      // WATCH TAB
                      _AartiWatch(),
                      // READ TAB
                      _AartiRead(aartiList: aartiList),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AartiListenList extends StatelessWidget {
  final List<Map<String, String>> aartiList;
  const _AartiListenList({required this.aartiList});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final columns = isWide ? 3 : 1;
    // Split list into columns for desktop, keep as single for mobile
    List<List<Map<String, String>>> colLists = List.generate(columns, (_) => []);
    for (var i = 0; i < aartiList.length; i++) {
      colLists[i % columns].add(aartiList[i]);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
      child: columns == 1
          ? ListView.builder(
        itemCount: aartiList.length,
        itemBuilder: (context, index) => _AartiListenRow(item: aartiList[index]),
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          columns,
              (col) => Expanded(
            child: ListView.builder(
              itemCount: colLists[col].length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => _AartiListenRow(item: colLists[col][index]),
            ),
          ),
        ),
      ),
    );
  }
}

class _AartiListenRow extends StatelessWidget {
  final Map<String, String> item;
  const _AartiListenRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11.5, horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item['title']!,
              style: const TextStyle(fontSize: 17, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              SvgPicture.network(
                'https://satsangtest.dadabhagwan.org/assets/images/icons/clock.svg',
                width: 16,
                height: 16,
                color: Colors.black54,
              ),
              const SizedBox(width: 3),
              Text(
                item['duration']!,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(width: 9),
          _ActionButton(
            iconUrl: "https://satsangtest.dadabhagwan.org/assets/images/icons/download.svg",
            onTap: () => _launchUrl(item['download']!),
          ),
          const SizedBox(width: 6),
          _ActionButton(
            iconUrl: "https://satsangtest.dadabhagwan.org/assets/images/icons/share.svg",
            onTap: () {
              // TODO: implement share
            },
          ),
        ],
      ),
    );
  }

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // handle error
    }
  }
}

class _ActionButton extends StatelessWidget {
  final String iconUrl;
  final VoidCallback onTap;
  const _ActionButton({required this.iconUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF6FAF7),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: SvgPicture.network(
            iconUrl,
            width: 18,
            height: 18,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}



class _AartiWatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videoId = '2sgwUMv2uws'; // YouTube video id
    final controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: YoutubePlayer(
                  controller: controller,
                  showVideoProgressIndicator: true,
                  width: double.infinity,
                  aspectRatio: 16 / 9,
                ),
              ),
              const SizedBox(height: 12),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Aarti',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
              const SizedBox(height: 6),
              Row(
                children: [
                  SvgPicture.network(
                    'https://satsangtest.dadabhagwan.org/assets/images/icons/clock.svg',
                    width: 15,
                    height: 15,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  const Text('00:14:24', style: TextStyle(fontSize: 14, color: Colors.black54)),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      _launchDownload('https://player.vimeo.com/external/261118174.sd.mp4?s=e86fc2679cb22c36b4cf1dfa0513f722296654d5&profile_id=164&oauth2_token_id=1116354050&download=1');
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SvgPicture.network(
                        "https://satsangtest.dadabhagwan.org/assets/images/icons/download.svg",
                        width: 19,
                        height: 19,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _launchDownload(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Handle error
    }
  }
}
// This widget just renders an iframe placeholder for the video
class _YoutubeVideoIframe extends StatelessWidget {
  const _YoutubeVideoIframe();
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Text(
            'YouTube Video\n(see web for real embed)',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// ... (other code above remains unchanged)

class _AartiRead extends StatelessWidget {
  const _AartiRead({super.key, required List<Map<String, String>> aartiList});

  // The downloadable PDFs (add more as needed)
  static final List<_AartiReadItem> _readList = [
    _AartiReadItem(
      lang: "Gujarati",
      pages: 9,
      title: "Aarti",
      downloadUrl: "https://download.dadabhagwan.org/Bhakti_pad/Lyrics/Aarti/Arti.pdf",
    ),
    // Example: add more languages as needed
    // _AartiReadItem(
    //   lang: "Hindi",
    //   pages: 8,
    //   title: "Aarti (Hindi)",
    //   downloadUrl: "...",
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    final columns = isWide ? 2 : 1;
    List<List<_AartiReadItem>> colLists = List.generate(columns, (_) => []);
    for (var i = 0; i < _readList.length; i++) {
      colLists[i % columns].add(_readList[i]);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
      child: columns == 1
          ? ListView.builder(
        itemCount: _readList.length,
        itemBuilder: (context, index) => _AartiReadRow(item: _readList[index]),
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          columns,
              (col) => Expanded(
            child: ListView.builder(
              itemCount: colLists[col].length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => _AartiReadRow(item: colLists[col][index]),
            ),
          ),
        ),
      ),
    );
  }
}

class _AartiReadItem {
  final String lang;
  final int pages;
  final String title;
  final String downloadUrl;
  const _AartiReadItem({
    required this.lang,
    required this.pages,
    required this.title,
    required this.downloadUrl,
  });
}

class _AartiReadRow extends StatelessWidget {
  final _AartiReadItem item;
  const _AartiReadRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11.5, horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _launchUrl(item.downloadUrl),
                  child: Row(
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "('${item.lang}')",
                        style: const TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.5),
                  child: Text(
                    "${item.pages} Pages",
                    style: const TextStyle(fontSize: 13, color: Colors.black45),
                  ),
                ),
              ],
            ),
          ),
          // Download button styled same as Listen tab
          _ActionButton(
            iconUrl: "https://satsangtest.dadabhagwan.org/assets/images/icons/download.svg",
            onTap: () => _launchUrl(item.downloadUrl),
          ),
        ],
      ),
    );
  }

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // handle error
    }
  }
}