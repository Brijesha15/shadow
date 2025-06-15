import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeworkItem {
  final String lang;
  final String title;
  final String thumbUrl;
  final String date;
  final String duration;
  final int views;

  HomeworkItem({
    required this.lang,
    required this.title,
    required this.thumbUrl,
    required this.date,
    required this.duration,
    required this.views,
  });
}

// Fill with all 12+ items as needed
final List<HomeworkItem> homeworkList = [
  HomeworkItem(
    lang: "GU",
    title: "Kartapadni Bhranti Same Jagruti Gothavavi (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/IL2gvC7afvo/mqdefault.jpg",
    date: "05 Jun 2025",
    duration: "00:08:18",
    views: 536,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Nirdosh Drashti Gothavavi (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/16CWZ2_KhBQ/mqdefault.jpg",
    date: "20 Mar 2025",
    duration: "00:04:19",
    views: 1797,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Janma Jayanti - 2024 Message (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/HdJ0xAGR_-k/mqdefault.jpg",
    date: "14 Nov 2024",
    duration: "00:10:16",
    views: 2253,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Bestu Varsh - 2024 Message (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/4G4oH3T3Lqk/mqdefault.jpg",
    date: "02 Nov 2024",
    duration: "00:09:28",
    views: 1564,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Gurupurnima - 2024 Message (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/hspNYffCnUs/mqdefault.jpg",
    date: "21 Jul 2024",
    duration: "00:11:53",
    views: 2905,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Mun-Vachan-Kayani Avasthane Judi Jovi (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/6ZEencsw4NU/mqdefault.jpg",
    date: "13 Jun 2024",
    duration: "00:09:05",
    views: 3050,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Premswarup Thavu (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/IGYtXvz0y7M/mqdefault.jpg",
    date: "21 Mar 2024",
    duration: "00:03:38",
    views: 2939,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Janma Jayanti - 2023 Message (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/4NP8Ol3gvlg/mqdefault.jpg",
    date: "26 Nov 2023",
    duration: "00:09:33",
    views: 3062,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Bestu Varsh - 2023 Message (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/ul9ZgivGKmY/mqdefault.jpg",
    date: "14 Nov 2023",
    duration: "00:12:36",
    views: 2436,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Hu Kai J Karto Nathi Evi Jagruti (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/QIlzpywgmNs/mqdefault.jpg",
    date: "21 Sep 2023",
    duration: "00:02:09",
    views: 2938,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Rakshabandhan - 2023 Message (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/YIoL6K0J2ls/mqdefault.jpg",
    date: "30 Aug 2023",
    duration: "00:14:06",
    views: 2451,
  ),
  HomeworkItem(
    lang: "GU",
    title: "Gurupurnima - 2023 Message (Gujarati)",
    thumbUrl: "https://i.ytimg.com/vi/MRE4sziyzoY/mqdefault.jpg",
    date: "03 Jul 2023",
    duration: "00:13:02",
    views: 2454,
  ),
];
class HomeworkContent extends StatefulWidget {
  const HomeworkContent({super.key});

  @override
  State<HomeworkContent> createState() => _HomeworkContentState();
}

class _HomeworkContentState extends State<HomeworkContent> {
  String searchQuery = '';
  String selectedYear = "Year";
  String selectedSort = "New to Old";

  List<HomeworkItem> get filteredList {
    var list = homeworkList.where((item) {
      final query = searchQuery.trim().toLowerCase();
      return query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.lang.toLowerCase().contains(query);
    }).toList();

    if (selectedYear != "Year") {
      list = list.where((item) => item.date.endsWith(selectedYear)).toList();
    }
    switch (selectedSort) {
      case "Old to New":
        list.sort((a, b) => a.date.compareTo(b.date));
        break;
      case "A to Z":
        list.sort((a, b) => a.title.compareTo(b.title));
        break;
      case "Z to A":
        list.sort((a, b) => b.title.compareTo(a.title));
        break;
      default: // "New to Old"
        list.sort((a, b) => b.date.compareTo(a.date));
        break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 700;

    // Responsive columns for desktop
    int crossAxisCount = 1;
    if (!isMobile) {
      if (width >= 1600) {
        crossAxisCount = 4;
      } else if (width >= 1200) {
        crossAxisCount = 3;
      } else if (width >= 900) {
        crossAxisCount = 2;
      }
    }

    final years = ["Year", "2025", "2024", "2023"];
    final sortOptions = ["New to Old", "Old to New", "A to Z", "Z to A"];

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Breadcrumb
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 18, left: 24, right: 24),
            child: Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Home',
                    style: TextStyle(color: Color(0xffE35925), fontSize: 15),
                  ),
                ),
                const Text(' / ', style: TextStyle(color: Colors.black45, fontSize: 15)),
                const Text('Homework', style: TextStyle(color: Colors.black, fontSize: 15)),
              ],
            ),
          ),

          // Heading
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 20),
            child: Center(
              child: Text(
                "Homework",
                style: TextStyle(
                  fontSize: isMobile ? 26 : 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),

          // Filters and Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
            child: isMobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _FilterChip(
                        label: selectedYear,
                        onTap: () => _showYearPicker(context, years),
                        trailingIcon: Icons.keyboard_arrow_down,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _FilterChip(
                        label: selectedSort,
                        onTap: () => _openBottomFilter(context, sortOptions),
                        trailingIcon: Icons.close,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _SearchBar(
                  hint: "Search By Keywords",
                  onChanged: (val) => setState(() => searchQuery = val),
                ),
              ],
            )
                : Row(
              children: [
                Expanded(
                  child: _SearchBar(
                    hint: "Search By Keywords",
                    onChanged: (val) => setState(() => searchQuery = val),
                  ),
                ),
                const SizedBox(width: 16),
                _Dropdown(
                  value: selectedYear,
                  items: years,
                  onChanged: (val) => setState(() => selectedYear = val!),
                  showChevron: true,
                ),
                const SizedBox(width: 8),
                _Dropdown(
                  value: selectedSort,
                  items: sortOptions,
                  onChanged: (val) => setState(() => selectedSort = val!),
                  showChevron: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Homework Cards Grid (desktop: responsive multi-col, mobile: 1 col)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 24),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: isMobile ? 10 : 32,
                mainAxisSpacing: isMobile ? 14 : 32,
                childAspectRatio: isMobile ? 1 : 1.42,
              ),
              itemBuilder: (context, index) => Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 340,
                  ),
                  child: _HomeworkCard(item: filteredList[index], isSquare: isMobile),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _openBottomFilter(BuildContext context, List<String> sortOptions) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: false,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filter By $selectedSort",
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black87),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xffE35925),
                      textStyle: const TextStyle(fontWeight: FontWeight.w500),
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedSort = "New to Old";
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffE35925)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text("Clear", style: TextStyle(fontSize: 14)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...sortOptions.map((option) {
                final bool selected = selectedSort == option;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      setState(() {
                        selectedSort = option;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xffF2F7F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          if (selected)
                            const Icon(Icons.check, color: Colors.black87, size: 20)
                          else
                            const SizedBox(width: 20),
                          const SizedBox(width: 8),
                          Text(
                            option,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showYearPicker(BuildContext context, List<String> years) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: years.map((year) {
              return ListTile(
                title: Text(year),
                leading: selectedYear == year
                    ? const Icon(Icons.check, color: Color(0xffF2F7F5))
                    : const SizedBox(width: 24),
                onTap: () {
                  setState(() {
                    selectedYear = year;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool showChevron;
  const _Dropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.showChevron = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xfffafbfc),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffeeeeee)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<String>(
              value: value,
              items: items
                  .map((e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e, style: const TextStyle(fontSize: 15, color: Colors.black87)),
              ))
                  .toList(),
              onChanged: onChanged,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              icon: showChevron
                  ? SvgPicture.string(
                '''
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#bdbdbd" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                      <path d="M6 9l6 6 6-6"/>
                    </svg>
                  ''',
                width: 16,
                height: 16,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? trailingIcon;

  const _FilterChip({
    required this.label,
    required this.onTap,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 4),
                Icon(trailingIcon, color: Colors.grey, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}


class ThreeDotMenu extends StatefulWidget {
  final double size;
  final VoidCallback? onFavorites;
  final VoidCallback? onWatchlist;
  final VoidCallback? onPlaylist;

  const ThreeDotMenu({
    Key? key,
    this.size = 20,
    this.onFavorites,
    this.onWatchlist,
    this.onPlaylist,
  }) : super(key: key);

  @override
  State<ThreeDotMenu> createState() => _ThreeDotMenuState();
}

class _ThreeDotMenuState extends State<ThreeDotMenu> {
  OverlayEntry? _overlayEntry;
  bool _menuOpen = false;

  void _toggleMenu() {
    if (_menuOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    final overlay = Overlay.of(context);
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeMenu,
        child: Stack(
          children: [
            Positioned(
              left: position.dx,
              top: position.dy + box.size.height,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _MenuItem(
                        icon: Icons.favorite_border,
                        label: "Favorites",
                        onTap: () {
                          _closeMenu();
                          widget.onFavorites?.call();
                        },
                      ),
                      _MenuItem(
                        icon: Icons.access_time,
                        label: "Watchlist",
                        onTap: () {
                          _closeMenu();
                          widget.onWatchlist?.call();
                        },
                      ),
                      _MenuItem(
                        icon: Icons.list,
                        label: "Playlist",
                        onTap: () {
                          _closeMenu();
                          widget.onPlaylist?.call();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
    setState(() {
      _menuOpen = true;
    });
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _menuOpen = false;
    });
  }

  @override
  void dispose() {
    _closeMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_menuOpen ? Icons.close : Icons.more_vert),
      color: Colors.black, // or your preferred color
      iconSize: widget.size,
      onPressed: _toggleMenu,
      splashRadius: widget.size,
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: Colors.black54),
            SizedBox(width: 12),
            Text(label, style: TextStyle(fontSize: 16, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}class _SearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.hint, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: SvgPicture.network(
              'https://satsangtest.dadabhagwan.org/assets/images/icons/search.svg',
              width: 18,
              height: 18,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 16),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}

class _HomeworkCard extends StatelessWidget {
  final HomeworkItem item;
  final bool isSquare;
  const _HomeworkCard({required this.item, required this.isSquare});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: isSquare ? 1 : 1.42,
      child: Card(
        elevation: 2.5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        shadowColor: Colors.black12,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail, icons, language, date
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      item.thumbUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Language Badge (top-left)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xff757575).withOpacity(0.85),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.lang,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
                  // Play/Headphone icons (bottom-right)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Row(
                      children: [
                        _IconButton(
                          iconUrl: 'https://satsangtest.dadabhagwan.org/assets/images/icons/play.svg',
                          onTap: () {},
                          size: 28,
                        ),
                        const SizedBox(width: 3),
                        _IconButton(
                          iconUrl: 'https://satsangtest.dadabhagwan.org/assets/images/icons/headphone-btn.svg',
                          onTap: () {},
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                  // Date badge (bottom-left)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFAFAFA).withOpacity(0.97),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: item.date.substring(0, 2),
                              style: const TextStyle(
                                color: Color(0xfff05536),
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text: ' ${item.date.substring(3)}',
                              style: const TextStyle(
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.5,
                  color: Colors.black,
                ),
              ),
            ),
            // Info row: duration, views, actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: Row(
                children: [
                  _SvgIconWithText(
                    iconUrl: 'https://satsangtest.dadabhagwan.org/assets/images/icons/clock.svg',
                    text: item.duration,
                  ),
                  const SizedBox(width: 10),
                  _SvgIconWithText(
                    iconUrl: 'https://satsangtest.dadabhagwan.org/assets/images/icons/view.svg',
                    text: item.views.toString(),
                  ),
                  const Spacer(),
                  _IconButton(
                    iconUrl: 'https://satsangtest.dadabhagwan.org/assets/images/icons/share.svg',
                    onTap: () {},
                    size: 20,
                  ),
                  const SizedBox(width: 15),
                  ThreeDotMenu(
                    onFavorites: () => print('Favorites pressed'),
                    onWatchlist: () => print('Watchlist pressed'),
                    onPlaylist: () => print('Playlist pressed'),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _SvgIconWithText extends StatelessWidget {
  final String iconUrl;
  final String text;
  const _SvgIconWithText({required this.iconUrl, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.network(iconUrl, width: 14, height: 14, color: Colors.black54),
        const SizedBox(width: 3),
        Text(text, style: const TextStyle(fontSize: 13, color: Colors.black54)),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  final String iconUrl;
  final VoidCallback onTap;
  final double size;
  const _IconButton({required this.iconUrl, required this.onTap, this.size = 24});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.network(
        iconUrl,
        width: size,
        height: size,
      ),
    );
  }
}