import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/data_models.dart';
import 'package:url_launcher/url_launcher.dart';

// ==== COLOR HELPER FUNCTIONS (move these outside the class!) ====

Color cardBg(BuildContext context) => Theme.of(context).brightness == Brightness.dark
    ? Color(0xFF172228)
    : Colors.white;
Color headlineColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark
    ? Color(0xFF81FFD4)
    : AppColors.primary(context);
Color mainTextColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark
    ? Color(0xFFDBFFF2)
    : AppColors.mainText(context);
Color iconColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark
    ? Color(0xFF03DBC3)
    : AppColors.primary(context);
Color accentColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark
    ? Color(0xFF40C4FF)
    : AppColors.accent(context);

// ==== END COLOR HELPER FUNCTIONS ====


class SoftwarePage extends StatelessWidget {
  final List<SoftwareItem> softwares = [
    SoftwareItem(
      name: 'Microsoft Windows',
      version: '10/11',
      description: 'The most popular desktop operating system, supporting a wide range of software, hardware, and enterprise features. Suitable for education, gaming, office work, and more.',
      website: 'https://www.microsoft.com/windows/',
      logoAssetPath: 'assets/images/software/windows_logo.png',
    ),
    SoftwareItem(
      name: 'Visual Studio Code',
      version: '1.80+',
      description: 'A free and powerful code editor from Microsoft, with extensions for debugging, linting, version control, and support for many programming languages.',
      website: 'https://code.visualstudio.com/',
      logoAssetPath: 'assets/images/software/visual_studio_code.png',
    ),
    SoftwareItem(
      name: 'Google Chrome',
      version: 'Latest',
      description: 'A cross-platform web browser that is fast, secure, and supports a wide variety of extensions. Great for daily web browsing and web apps.',
      website: 'https://www.google.com/chrome/',
      logoAssetPath: 'assets/images/software/google_chrome.png',
    ),
    SoftwareItem(
      name: 'Mozilla Firefox',
      version: 'Latest',
      description: 'A privacy-focused, open-source browser with flexible customization and powerful built-in developer tools.',
      website: 'https://www.mozilla.org/firefox/',
      logoAssetPath: 'assets/images/software/mozilla_firefox.png',
    ),
    SoftwareItem(
      name: 'Adobe Photoshop',
      version: '2024',
      description: 'The industry standard for photo editing, graphic design, and digital art creation. Offers advanced layer-based image manipulation tools.',
      website: 'https://www.adobe.com/products/photoshop.html',
      logoAssetPath: 'assets/images/software/adobe_photoshop.png',
    ),
    SoftwareItem(
      name: 'Microsoft Office',
      version: '2021/365',
      description: 'A productivity suite including Word (documents), Excel (spreadsheets), PowerPoint (presentations), Outlook (email), and more.',
      website: 'https://www.microsoft.com/en/microsoft-365',
      logoAssetPath: 'assets/images/software/microsoft_office.png',
    ),
    SoftwareItem(
      name: 'WinRAR',
      version: '6.x',
      description: 'A well-known file archiver utility for compressing and extracting .rar and .zip files. Useful for saving disk space and sending files over the internet.',
      website: 'https://www.rarlab.com/',
      logoAssetPath: 'assets/images/software/winrar.png',
    ),
    SoftwareItem(
      name: 'Notepad++',
      version: '8.x',
      description: 'A lightweight, open-source code and text editor, especially popular for Windows users working with many file formats and coding languages.',
      website: 'https://notepad-plus-plus.org/',
      logoAssetPath: 'assets/images/software/notepad_plus_plus.png',
    ),
    SoftwareItem(
      name: 'VLC Media Player',
      version: '3.x',
      description: 'A free and open-source media player that plays almost any audio/video format, as well as DVDs and streaming protocols.',
      website: 'https://www.videolan.org/vlc/',
      logoAssetPath: 'assets/images/software/vlc_media_player.png',
    ),
    SoftwareItem(
      name: '7-Zip',
      version: '22.x',
      description: 'A free, fast, and open-source file archiver with high compression ratios and support for many formats, including 7z, zip, tar, and rar.',
      website: 'https://www.7-zip.org/',
      logoAssetPath: 'assets/images/software/7zip.png',
    ),
    SoftwareItem(
      name: 'Slack',
      version: 'Latest',
      description: 'A team collaboration tool for messaging, file sharing, and integration with many productivity services. Great for remote and in-office teams.',
      website: 'https://slack.com/',
      logoAssetPath: 'assets/images/software/slack.png',
    ),
    SoftwareItem(
      name: 'Discord',
      version: 'Latest',
      description: 'A voice, video, and text chat app created for gamers, but now used for communities and teams worldwide.',
      website: 'https://discord.com/',
      logoAssetPath: 'assets/images/software/discord.png',
    ),
    SoftwareItem(
      name: 'Microsoft Teams',
      version: 'Latest',
      description: 'A unified communication and collaboration platform for chat, video meetings, and real-time document collaboration, especially for business and education.',
      website: 'https://www.microsoft.com/en/microsoft-teams/group-chat-software',
      logoAssetPath: 'assets/images/software/microsoft_teams.png',
    ),
    SoftwareItem(
      name: 'Zoom',
      version: 'Latest',
      description: 'A leading video conferencing platform suitable for meetings, webinars, and online classes; supports screen sharing and recording.',
      website: 'https://zoom.us/',
      logoAssetPath: 'assets/images/software/zoom.png',
    ),
    SoftwareItem(
      name: 'Skype',
      version: '8.x',
      description: 'A pioneer app for free video calls and instant messaging, also supports low-cost international phone calls.',
      website: 'https://www.skype.com/',
      logoAssetPath: 'assets/images/software/skype.png',
    ),
    SoftwareItem(
      name: 'Audacity',
      version: '3.x',
      description: 'A free, open-source audio editor and recorder used for music, podcasts, and audio editing.',
      website: 'https://www.audacityteam.org/',
      logoAssetPath: 'assets/images/software/audacity.png',
    ),
    SoftwareItem(
      name: 'GIMP',
      version: '2.10.x',
      description: 'A powerful open-source alternative to Photoshop for photo retouching, image composition, and image authoring.',
      website: 'https://www.gimp.org/',
      logoAssetPath: 'assets/images/software/gimp.png',
    ),
    SoftwareItem(
      name: 'Blender',
      version: '3.x',
      description: 'A free and open-source 3D creation suite supporting 3D modeling, animation, rendering, motion tracking, and game creation.',
      website: 'https://www.blender.org/',
      logoAssetPath: 'assets/images/software/blender.png',
    ),
    SoftwareItem(
      name: 'FileZilla',
      version: '3.x',
      description: 'A popular FTP client for fast and secure file transfers between local computers and web servers.',
      website: 'https://filezilla-project.org/',
      logoAssetPath: 'assets/images/software/filezilla.png',
    ),
    SoftwareItem(
      name: 'Git',
      version: '2.x',
      description: 'A distributed version control system that helps developers manage and track code changes efficiently. Essential for teamwork and open-source projects.',
      website: 'https://git-scm.com/',
      logoAssetPath: 'assets/images/software/git.png',
    ),
    SoftwareItem(
      name: 'Sublime Text',
      version: '4.x',
      description: 'A highly customizable, fast, and rich text/code editor popular among programmers and web developers.',
      website: 'https://www.sublimetext.com/',
      logoAssetPath: 'assets/images/software/sublime_text.png',
    ),
    SoftwareItem(
      name: 'PyCharm',
      version: '2023.x',
      description: 'A professional-grade IDE for Python development, supporting advanced code completion, refactoring, and debugging tools.',
      website: 'https://www.jetbrains.com/pycharm/',
      logoAssetPath: 'assets/images/software/pycharm.png',
    ),
    SoftwareItem(
      name: 'Android Studio',
      version: '2023.x',
      description: 'The official IDE for Android app development. Features code editing, debugging, performance tooling, and a flexible build system.',
      website: 'https://developer.android.com/studio',
      logoAssetPath: 'assets/images/software/android_studio.png',
    ),
    SoftwareItem(
      name: 'XAMPP',
      version: '8.x',
      description: 'A free and easy-to-use Apache, MariaDB, PHP, and Perl package for local web development and testing.',
      website: 'https://www.apachefriends.org/',
      logoAssetPath: 'assets/images/software/xampp.png',
    ),
    SoftwareItem(
      name: 'OBS Studio',
      version: '29.x',
      description: 'A free, open-source app for video recording and live streaming with powerful configuration options.',
      website: 'https://obsproject.com/',
      logoAssetPath: 'assets/images/software/obs_studio.png',
    ),
    SoftwareItem(
      name: 'Spotify',
      version: 'Latest',
      description: 'A popular music streaming service with millions of songs and podcasts; available for free and premium users.',
      website: 'https://www.spotify.com/',
      logoAssetPath: 'assets/images/software/spotify.png',
    ),
    SoftwareItem(
      name: 'Dropbox',
      version: 'Latest',
      description: 'A cloud storage and file synchronization service. Easily back up and share files across devices.',
      website: 'https://dropbox.com/',
      logoAssetPath: 'assets/images/software/dropbox.png',
    ),
    SoftwareItem(
      name: 'Google Drive',
      version: 'Latest',
      description: 'A cloud storage platform for storing, sharing, and collaborating on documents, spreadsheets, and presentations.',
      website: 'https://drive.google.com/',
      logoAssetPath: 'assets/images/software/google_drive.png',
    ),
    SoftwareItem(
      name: 'Adobe Acrobat Reader',
      version: '2023.x',
      description: 'A standard tool for viewing, printing, annotating, and signing PDF files.',
      website: 'https://get.adobe.com/reader/',
      logoAssetPath: 'assets/images/software/adobe_acrobat_reader.png',
    ),
    SoftwareItem(
      name: 'Paint.NET',
      version: '5.x',
      description: 'A free image and photo editing software for Windows, simpler than GIMP or Photoshop but more powerful than MS Paint.',
      website: 'https://www.getpaint.net/',
      logoAssetPath: 'assets/images/software/paint_net.png',
    ),
    SoftwareItem(
      name: 'KMPlayer',
      version: '4.x',
      description: 'A versatile media player supporting various video/audio codecs and formats, also offers subtitle and playback speed controls.',
      website: 'https://www.kmplayer.com/',
      logoAssetPath: 'assets/images/software/kmplayer.png',
    ),
    SoftwareItem(
      name: 'Malwarebytes',
      version: '4.x',
      description: 'A trusted anti-malware and antivirus tool that finds and removes malware, ransomware, spyware, and other threats.',
      website: 'https://www.malwarebytes.com/',
      logoAssetPath: 'assets/images/software/malwarebytes.png',
    ),
    SoftwareItem(
      name: 'qBittorrent',
      version: '4.x',
      description: 'An open-source torrent client that is lightweight, ad-free, and easy to use for downloading torrents.',
      website: 'https://www.qbittorrent.org/',
      logoAssetPath: 'assets/images/software/qbittorrent.png',
    ),
    SoftwareItem(
      name: 'Steam',
      version: 'Latest',
      description: 'The largest PC gaming platform and marketplace; install, purchase, and play thousands of games.',
      website: 'https://store.steampowered.com/',
      logoAssetPath: 'assets/images/software/steam.png',
    ),
    SoftwareItem(
      name: 'LibreOffice',
      version: '7.x',
      description: 'A free and open-source office suite for working with documents, spreadsheets, and presentations; compatible with Microsoft Office formats.',
      website: 'https://www.libreoffice.org/',
      logoAssetPath: 'assets/images/software/libreoffice.png',
    ),
    SoftwareItem(
      name: 'TeamViewer',
      version: '15.x',
      description: 'A leading app for remote desktop access, remote support, and online meetings with secure connections.',
      website: 'https://www.teamviewer.com/',
      logoAssetPath: 'assets/images/software/teamviewer.png',
    ),
    SoftwareItem(
      name: 'Recuva',
      version: '1.5.x',
      description: 'A free tool for recovering deleted files from hard drives, memory cards, and external drives.',
      website: 'https://www.ccleaner.com/recuva',
      logoAssetPath: 'assets/images/software/recuva.png',
    ),
    SoftwareItem(
      name: 'CCleaner',
      version: '6.x',
      description: 'A popular utility for cleaning junk files, optimizing system performance, and managing installed programs.',
      website: 'https://www.ccleaner.com/',
      logoAssetPath: 'assets/images/software/ccleaner.png',
    ),
    SoftwareItem(
      name: 'Figma',
      version: 'Latest',
      description: 'A browser-based UI/UX design tool for collaborative interface design, prototyping, and feedback in real-time.',
      website: 'https://www.figma.com/',
      logoAssetPath: 'assets/images/software/figma.png',
    ),
    SoftwareItem(
      name: 'PuTTY',
      version: '0.78',
      description: 'A free SSH, Telnet, and serial console client. Essential for remote server and network management.',
      website: 'https://www.putty.org/',
      logoAssetPath: 'assets/images/software/putty.png',
    ),
    SoftwareItem(
      name: 'MobaXterm',
      version: '23.x',
      description: 'A terminal emulator and SSH client with X11 server for remote computing, tunneling, and advanced networking on Windows.',
      website: 'https://mobaxterm.mobatek.net/',
      logoAssetPath: 'assets/images/software/mobaxterm.png',
    ),
    SoftwareItem(
      name: 'Foxit Reader',
      version: '12.x',
      description: 'A lightweight PDF reader and annotator, offering fast viewing speed and rich features for work and school.',
      website: 'https://www.foxit.com/pdf-reader/',
      logoAssetPath: 'assets/images/software/foxit_reader.png',
    ),
    SoftwareItem(
      name: 'KeePass',
      version: '2.x',
      description: 'A free, open-source password manager for storing, managing, and autofilling passwords securely.',
      website: 'https://keepass.info/',
      logoAssetPath: 'assets/images/software/keepass.png',
    ),
    SoftwareItem(
      name: 'WhatsApp Desktop',
      version: '2.x',
      description: 'Official desktop client for WhatsApp messaging, supporting text, voice, and video calls from your computer.',
      website: 'https://www.whatsapp.com/download/',
      logoAssetPath: 'assets/images/software/whatsapp_desktop.png',
    ),
    SoftwareItem(
      name: 'Adobe XD',
      version: '56.x',
      description: 'A vector-based tool for designing and prototyping user experiences for web and mobile apps.',
      website: 'https://www.adobe.com/products/xd.html',
      logoAssetPath: 'assets/images/software/adobe_xd.png',
    ),
  ];



  SoftwarePage({Key? key}) : super(key: key);

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final cardPadding = deviceWidth * 0.04;
    final horizontalPadding = deviceWidth * 0.05;
    final iconSize = deviceWidth * 0.09 + 18;

    return Scaffold(
      appBar: AppBar(
        title: Text('PC Software',
            style: AppTextStyles.appBar(context).copyWith(color: headlineColor(context))),
        centerTitle: true,
        backgroundColor: AppColors.background(context),
        elevation: 0,
        iconTheme: IconThemeData(color: headlineColor(context)),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            color: headlineColor(context),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SoftwareSearchDelegate(
                  allSoftwares: softwares,
                  launchUrl: (url) => _launchUrl(context, url),
                  parentContext: context,
                ),
              );
            },
          )
        ],
      ),
      backgroundColor: AppColors.background(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
        child: softwares.isEmpty
            ? Center(
          child: Text("No software items found.",
              style: AppTextStyles.headline(context).copyWith(
                color: headlineColor(context),
              )),
        )
            : ListView.builder(
          itemCount: softwares.length,
          itemBuilder: (context, index) {
            final s = softwares[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: cardPadding / 2),
              child: Material(
                color: cardBg(context),
                elevation: 2,
                shadowColor: Colors.black12,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(cardPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: iconSize,
                          height: iconSize,
                          child: Image.asset(
                            s.logoAssetPath,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.desktop_windows,
                                size: iconSize,
                                color: iconColor(context),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: cardPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.name,
                                style: AppTextStyles.headline(context).copyWith(
                                  fontSize: deviceWidth < 400 ? 15 : 18,
                                  color: headlineColor(context),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${s.description}\nVersion: ${s.version}",
                                style: AppTextStyles.body(context).copyWith(
                                  fontSize: deviceWidth < 400 ? 13 : 15,
                                  color: mainTextColor(context),
                                ),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if (s.website != null)
                          IconButton(
                            icon: Icon(Icons.open_in_new, color: accentColor(context)),
                            iconSize: iconSize * 0.8,
                            onPressed: () => _launchUrl(context, s.website!),
                            tooltip: 'Open website',
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// -----------------------------------
//        SEARCH DELEGATE BELOW
// -----------------------------------

class SoftwareSearchDelegate extends SearchDelegate<SoftwareItem?> {
  final List<SoftwareItem> allSoftwares;
  final void Function(String url) launchUrl;
  final BuildContext parentContext;

  SoftwareSearchDelegate({
    required this.allSoftwares,
    required this.launchUrl,
    required this.parentContext,
  }) : super(
    searchFieldLabel: "Search software, version, or description",
  );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final dark = Theme.of(parentContext).brightness == Brightness.dark;
    return Theme.of(parentContext).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? Color(0xFF193943) : Colors.grey[50],
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background(parentContext),
        iconTheme: IconThemeData(color: headlineColor(parentContext)),
        titleTextStyle: AppTextStyles.appBar(parentContext).copyWith(color: headlineColor(parentContext)),
      ),
      textTheme: TextTheme(
        titleLarge: AppTextStyles.appBar(parentContext),
        titleMedium: AppTextStyles.body(parentContext).copyWith(
          color: dark ? Color(0xFFDBFFF2) : AppColors.mainText(parentContext),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: dark ? Colors.cyan.withOpacity(0.25) : Colors.blue.withOpacity(.18),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      IconButton(
        icon: const Icon(Icons.clear),
        tooltip: "Clear search",
        onPressed: () => query = '',
      ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => _buildList(parentContext);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(parentContext);

  Widget _buildList(BuildContext context) {
    final List<SoftwareItem> filtered = query.isEmpty
        ? []
        : allSoftwares
        .where((s) =>
    s.name.toLowerCase().contains(query.toLowerCase()) ||
        s.version.toLowerCase().contains(query.toLowerCase()) ||
        (s.description.toLowerCase().contains(query.toLowerCase())))
        .toList();

    final deviceWidth = MediaQuery.of(context).size.width;
    final cardPadding = deviceWidth * 0.04;
    final iconSize = deviceWidth * 0.09 + 18;

    if (query.isEmpty) {
      return Center(
        child: Text(
          "Type to search software.",
          style: AppTextStyles.body(context).copyWith(
            color: mainTextColor(context),
          ),
        ),
      );
    }

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          "No result found.",
          style: AppTextStyles.body(context).copyWith(
            color: mainTextColor(context),
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final s = filtered[index];
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: cardPadding / 2, horizontal: deviceWidth * 0.05),
          child: Material(
            color: cardBg(context),
            elevation: 2,
            shadowColor: Colors.black12,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                if (s.website != null) {
                  launchUrl(s.website!);
                }
              },
              child: Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.desktop_windows,
                      size: iconSize,
                      color: iconColor(context),
                    ),
                    SizedBox(width: cardPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.name,
                            style: AppTextStyles.headline(context).copyWith(
                              fontSize: deviceWidth < 400 ? 15 : 18,
                              color: headlineColor(context),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${s.description}\nVersion: ${s.version}",
                            style: AppTextStyles.body(context).copyWith(
                              fontSize: deviceWidth < 400 ? 13 : 15,
                              color: mainTextColor(context),
                            ),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (s.website != null)
                      IconButton(
                        icon: Icon(Icons.open_in_new, color: accentColor(context)),
                        iconSize: iconSize * 0.8,
                        onPressed: () => launchUrl(s.website!),
                        tooltip: 'Open website',
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
