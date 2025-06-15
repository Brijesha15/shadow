import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'vidhi.dart';
import 'homework.dart';
import 'aarti.dart';
import 'samayik_of_the_day.dart'; // <-- ADD THIS

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Satsang',
      debugShowCheckedModeBanner: false,
      home: const SatsangHomePage(),
    );
  }
}

// Enum to manage page switching
enum SadhanaPage { vidhi, aarti, homework, samayik }

class SatsangHomePage extends StatefulWidget {
  const SatsangHomePage({super.key});
  @override
  State<SatsangHomePage> createState() => _SatsangHomePageState();
}

class _SatsangHomePageState extends State<SatsangHomePage> {
  SadhanaPage _currentPage = SadhanaPage.vidhi;

  void _navigateTo(SadhanaPage page) => setState(() => _currentPage = page);

  @override
  Widget build(BuildContext context) {
    final isDesktop = (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS);

    // Banner logic: Only Homework page has the different banner
    final String bannerUrl = _currentPage == SadhanaPage.homework
        ? 'https://satsangtest.dadabhagwan.org/assets/images/banner/video-banner.jpg'
        : 'https://satsangtest.dadabhagwan.org/assets/images/banner/sadhana-banner.jpg';

    Widget pageContent;
    switch (_currentPage) {
      case SadhanaPage.vidhi:
        pageContent = const VidhiContent();
        break;
      case SadhanaPage.aarti:
        pageContent = const AartiContent();
        break;
      case SadhanaPage.homework:
        pageContent = const HomeworkContent();
        break;
      case SadhanaPage.samayik:
        pageContent = const SamayikOfTheDayContent();
        break;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: !isDesktop,
      body: isDesktop
          ? _WindowsFullPage(
        bannerUrl: bannerUrl,
        pageContent: pageContent,
        onSadhanaNav: _navigateTo,
        currentPage: _currentPage,
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            const _MobileAppBar(),
            _MobileBannerNavBar(
              bannerUrl: bannerUrl,
              selectedPage: _currentPage,
              onNavTap: _navigateTo,
            ),
            pageContent,
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}

/// WINDOWS/DESKTOP FULL PAGE (sticky nav, banner, page, footer)
class _WindowsFullPage extends StatelessWidget {
  final String bannerUrl;
  final Widget pageContent;
  final void Function(SadhanaPage) onSadhanaNav;
  final SadhanaPage currentPage;
  const _WindowsFullPage({
    required this.bannerUrl,
    required this.pageContent,
    required this.onSadhanaNav,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scrollable content below sticky navbar
        Positioned.fill(
          top: 68,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _WindowsBanner(bannerUrl: bannerUrl),
                pageContent,
                const CustomFooter(),
              ],
            ),
          ),
        ),
        // Sticky navbar (always visible, not scrolling)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _WindowsStickyNavBar(
            onSadhanaNav: onSadhanaNav,
            currentPage: currentPage,
          ),
        ),
      ],
    );
  }
}

class _WindowsStickyNavBar extends StatelessWidget {
  final void Function(SadhanaPage) onSadhanaNav;
  final SadhanaPage currentPage;
  const _WindowsStickyNavBar({
    required this.onSadhanaNav,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      color: Colors.white,
      child: Container(
        height: 68,
        alignment: Alignment.center,
        child: Row(
          children: [
            const SizedBox(width: 18),
            SvgPicture.network(
              'https://satsangtest.dadabhagwan.org/assets/images/satsang_logo.svg',
              height: 40,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
              placeholderBuilder: (_) => const SizedBox(height: 40, width: 120),
            ),
            const Spacer(),
            _WindowsNavItems(onSadhanaNav: onSadhanaNav, currentPage: currentPage),
            const Spacer(flex: 2),
            Row(
              children: [
                _HeaderIcon(url: 'https://satsangtest.dadabhagwan.org/assets/images/icons/search.svg'),
                _HeaderIcon(url: 'https://satsangtest.dadabhagwan.org/assets/images/icons/dark.svg'),
                _HeaderIcon(url: 'https://satsangtest.dadabhagwan.org/assets/images/icons/share.svg'),
                _HeaderIcon(url: 'https://satsangtest.dadabhagwan.org/assets/images/icons/more-menu.svg'),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFFE39525),
                  child: Icon(Icons.person, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Windows nav row with sticky dropdown on Sadhana
class _WindowsNavItems extends StatelessWidget {
  final void Function(SadhanaPage) onSadhanaNav;
  final SadhanaPage currentPage;
  const _WindowsNavItems({
    required this.onSadhanaNav,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavTopItem(title: "Schedule"),
        _NavTopItem(title: "Books"),
        _NavTopItem(title: "Videos"),
        _NavTopItem(title: "Gallery"),
        _NavTopItem(title: "Audios"),
        _NavTopItem(title: "Contact"),
        _NavTopItem(title: "Magazines"),
        _NavDropdownSadhana(
          onSadhanaNav: onSadhanaNav,
          currentPage: currentPage,
        ),
      ],
    );
  }
}

class _NavTopItem extends StatelessWidget {
  final String title;
  const _NavTopItem({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {},
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _NavDropdownSadhana extends StatefulWidget {
  final void Function(SadhanaPage) onSadhanaNav;
  final SadhanaPage currentPage;
  const _NavDropdownSadhana({
    required this.onSadhanaNav,
    required this.currentPage,
  });

  @override
  State<_NavDropdownSadhana> createState() => _NavDropdownSadhanaState();
}

class _NavDropdownSadhanaState extends State<_NavDropdownSadhana> {
  bool _showMenu = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _dropdownOverlay;

  void _openMenu() {
    if (_showMenu) return;
    setState(() => _showMenu = true);
    _dropdownOverlay = _createOverlay();
    Overlay.of(context, debugRequiredFor: widget)?.insert(_dropdownOverlay!);
  }

  void _closeMenu() {
    if (_dropdownOverlay != null) {
      _dropdownOverlay!.remove();
      _dropdownOverlay = null;
    }
    if (_showMenu) setState(() => _showMenu = false);
  }

  OverlayEntry _createOverlay() {
    RenderBox box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + box.size.height,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, 0),
          child: MouseRegion(
            onExit: (_) => _closeMenu(),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 180,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NavDropdownItem(
                      title: "Vidhi",
                      onTap: () {
                        _closeMenu();
                        widget.onSadhanaNav(SadhanaPage.vidhi);
                      },
                    ),
                    _NavDropdownItem(
                      title: "Aarti",
                      onTap: () {
                        _closeMenu();
                        widget.onSadhanaNav(SadhanaPage.aarti);
                      },
                    ),
                    _NavDropdownItem(
                      title: "Homework",
                      onTap: () {
                        _closeMenu();
                        widget.onSadhanaNav(SadhanaPage.homework);
                      },
                    ),
                    _NavDropdownItem(
                      title: "Samayik Of The Day",
                      onTap: () {
                        _closeMenu();
                        widget.onSadhanaNav(SadhanaPage.samayik);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _closeMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _openMenu,
        child: Row(
          children: [
            const Text(
              "Sadhana",
              style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w400),
            ),
            const Icon(Icons.arrow_drop_down, size: 16, color: Colors.black87),
          ],
        ),
      ),
    );
  }
}

class _NavDropdownItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const _NavDropdownItem({required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  final String url;
  const _HeaderIcon({required this.url});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: SvgPicture.network(
        url,
        height: 20,
        width: 20,
        placeholderBuilder: (_) => const SizedBox(height: 20, width: 20),
      ),
    );
  }
}

// Banner for desktop
class _WindowsBanner extends StatelessWidget {
  final String bannerUrl;
  const _WindowsBanner({required this.bannerUrl});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Image.network(
        bannerUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) =>
            Container(color: Colors.grey[300]),
      ),
    );
  }
}

/// MOBILE/TABLET APPBAR
class _MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MobileAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      toolbarHeight: 60,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: SvgPicture.network(
          'https://satsangtest.dadabhagwan.org/assets/images/satsang_logo.svg',
          height: 32,
          placeholderBuilder: (_) => const SizedBox(
            height: 32,
            width: 120,
          ),
        ),
      ),
      leadingWidth: 140,
      title: const SizedBox.shrink(),
      actions: [
        _AppBarSvgIcon(
          url: 'https://satsangtest.dadabhagwan.org/assets/images/icons/search.svg',
        ),
        _AppBarSvgIcon(
          url: 'https://satsangtest.dadabhagwan.org/assets/images/icons/dark.svg',
        ),
        _AppBarSvgIcon(
          url: 'https://satsangtest.dadabhagwan.org/assets/images/icons/share.svg',
        ),
        _AppBarSvgIcon(
          url: 'https://satsangtest.dadabhagwan.org/assets/images/icons/more-menu.svg',
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _AppBarSvgIcon extends StatelessWidget {
  final String url;
  const _AppBarSvgIcon({required this.url});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SvgPicture.network(
        url,
        height: 16,
        width: 16,
        placeholderBuilder: (_) => const SizedBox(height: 16, width: 16),
      ),
    );
  }
}

/// MOBILE BANNER WITH BLUR AND NAV BUTTONS
class _MobileBannerNavBar extends StatelessWidget {
  final String bannerUrl;
  final SadhanaPage selectedPage;
  final void Function(SadhanaPage) onNavTap;
  const _MobileBannerNavBar({
    required this.bannerUrl,
    required this.selectedPage,
    required this.onNavTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            bannerUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) =>
                Container(color: Colors.grey[300]),
          ),
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Container(
                  color: Colors.black.withOpacity(0.52),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 90,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    _NavButton(
                      svg: 'https://satsangtest.dadabhagwan.org/assets/images/icons/vidhi.svg',
                      text: "Vidhi",
                      selected: selectedPage == SadhanaPage.vidhi,
                      onTap: () => onNavTap(SadhanaPage.vidhi),
                    ),
                    _NavButton(
                      svg: 'https://satsangtest.dadabhagwan.org/assets/images/icons/arti.svg',
                      text: "Aarti",
                      selected: selectedPage == SadhanaPage.aarti,
                      onTap: () => onNavTap(SadhanaPage.aarti),
                    ),
                    _NavButton(
                      svg: 'https://satsangtest.dadabhagwan.org/assets/images/icons/homework.svg',
                      text: "Homework",
                      selected: selectedPage == SadhanaPage.homework,
                      onTap: () => onNavTap(SadhanaPage.homework),
                    ),
                    _NavButton(
                      svg: 'https://satsangtest.dadabhagwan.org/assets/images/icons/samayik.svg',
                      text: "Samayik",
                      selected: selectedPage == SadhanaPage.samayik,
                      onTap: () => onNavTap(SadhanaPage.samayik),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String svg;
  final String text;
  final bool selected;
  final VoidCallback? onTap;

  const _NavButton({
    required this.svg,
    required this.text,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Colors.white : Colors.grey.shade300,
            width: selected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Opacity(
          opacity: selected ? 1.0 : 0.8,
          child: Row(
            children: [
              SvgPicture.network(
                svg,
                width: 30,
                height: 30,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                placeholderBuilder: (_) => const SizedBox(width: 20, height: 20),
              ),
              const SizedBox(width: 6),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- KEEP YOUR CustomFooter BELOW (unchanged) ---

// ... rest of your CustomFooter implementation ...

class CustomFooter extends StatefulWidget {
  const CustomFooter({super.key});
  @override
  State<CustomFooter> createState() => _CustomFooterState();
}

class _CustomFooterState extends State<CustomFooter> {
  int? _activeSocialIndex;

  static const Color bgGray40 = Color(0xffF2F7F5);

  static const List<Map<String, String>> links = [
    {"name": "Main Website", "url": "https://www.dadabhagwan.org/"},
    {"name": "Online Store", "url": "https://store.dadabhagwan.org/"},
    {"name": "Dadabhagwan FM", "url": "https://www.dadabhagwan.fm/"},
    {"name": "Beginners Blog", "url": "https://blog.dadabhagwan.org/"},
    {"name": "Youth Website", "url": "https://youth.dadabhagwan.org/"},
    {"name": "Simandhar City Arrival Form", "url": "https://simcityarrival.dadabhagwan.org/"},
    {"name": "Dadabhagwan TV", "url": "https://www.dadabhagwan.tv/"},
    {"name": "Subscribe to Egroup", "url": "https://egroup.dadabhagwan.org/"},
    {"name": "Website for Kids", "url": "https://kids.dadabhagwan.org/"},
    {"name": "Mobile Apps", "url": "https://www.dadabhagwan.org/books-media/mobile-apps/"},
    {"name": "Donation", "url": "https://donation.dadabhagwan.org/login?redirect-to=/donor/new#login"},
    {"name": "Learn Gujarati", "url": "https://learngujarati.dadabhagwan.org/"},
    {"name": "Trimandir Website", "url": "https://www.trimandir.org/"},
  ];

  static const List<Map<String, dynamic>> socialLinks = [
    {
      "icon": "https://satsangtest.dadabhagwan.org/assets/images/icons/facebook.svg",
      "url": "https://www.facebook.com/DadaBhagwanFoundation",
      "color": Color(0xff1877F3),
      "isPng": false,
    },
    {
      "icon": "https://satsangtest.dadabhagwan.org/assets/images/icons/whatsapp.svg",
      "url": "https://whatsapp.com/channel/0029Va5FOF9HrDZcQvJ3JT2s",
      "color": Color(0xff25D366),
      "isPng": false,
    },
    {
      "icon": "https://satsangtest.dadabhagwan.org/assets/images/icons/instagram.svg",
      "url": "https://www.instagram.com/dadabhagwanfoundation/",
      "color": Color(0xffE4405F),
      "isPng": false,
    },
    {
      "icon": "https://satsangtest.dadabhagwan.org/assets/images/icons/twitter.svg",
      "url": "https://twitter.com/dadabhagwan/",
      "color": Color(0xff000000),
      "isPng": false,
    },
    {
      "icon": "https://satsangtest.dadabhagwan.org/assets/images/icons/youtube.svg",
      "url": "https://www.youtube.com/c/DadaBhagwanFoundation?sub_confirmation=1",
      "color": Color(0xffFF0000),
      "isPng": false,
    },
    {
      "icon": "https://satsangtest.dadabhagwan.org/assets/images/icons/pintrest.svg",
      "url": "https://www.pinterest.com/dadabhagwanfoundation/",
      "color": Color(0xffE60023),
      "isPng": false,
    },
    {
      "icon": "https://satsangtest.dadabhagwan.org/assets/images/icons/youtube-music.svg",
      "url": "https://www.youtube.com/c/dadabhagwanmusic?sub_confirmation=1",
      "color": Color(0xffFF0000),
      "isPng": false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final gridCols = width < 800 ? 2 : 4;
    final gridMaxWidth = 1050.0;

    return Container(
      color: bgGray40,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 2),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: gridMaxWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Footer links grid
              GridView.count(
                crossAxisCount: gridCols,
                mainAxisSpacing: 5,
                crossAxisSpacing: 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 4,
                children: links
                    .map((link) => Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => _launchUrl(link['url']!),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: Text(
                        link['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ))
                    .toList(),
              ),
              const SizedBox(height: 28),
              // Social icons row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  socialLinks.length,
                      (i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      elevation: 1,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          setState(() => _activeSocialIndex = i);
                          await _launchUrl(socialLinks[i]['url']);
                          Future.delayed(const Duration(milliseconds: 350), () {
                            if (mounted) setState(() => _activeSocialIndex = null);
                          });
                        },
                        child: Container(
                          width: 42,
                          height: 42,
                          alignment: Alignment.center,
                          child: socialLinks[i]['isPng'] == true
                              ? Image.network(
                            socialLinks[i]['icon'],
                            width: 22,
                            height: 22,
                            color: _activeSocialIndex == i
                                ? socialLinks[i]['color']
                                : Colors.black,
                          )
                              : SvgPicture.network(
                            socialLinks[i]['icon'],
                            width: 22,
                            height: 22,
                            color: _activeSocialIndex == i
                                ? socialLinks[i]['color']
                                : Colors.black,
                            placeholderBuilder: (context) =>
                            const SizedBox(
                              width: 22,
                              height: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
              // Copyright
              const Text(
                "Copyright © 2000 - 2024 Dada Bhagwan Foundation. All rights reserved.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 7),
              // Terms/Privacy
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 6,
                children: [
                  InkWell(
                    onTap: () => _launchUrl("https://www.dadabhagwan.org/terms-of-use/"),
                    child: const Text(
                      "Terms of Services",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffE39525),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Text('|', style: TextStyle(fontSize: 15, color: Colors.black45)),
                  InkWell(
                    onTap: () => _launchUrl("https://www.dadabhagwan.org/privacy-policy/"),
                    child: const Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffE39525),
                        decoration: TextDecoration.underline,
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

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print('Could not launch $url');
    }
  }
}