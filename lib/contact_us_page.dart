import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

// ======= Team Member Model =======
class TeamMember {
  final String name;
  final String role;
  final String phone;
  final String email;
  final String whatsapp;
  final String facebookUrl;
  final String profilePic;
  final List<EducationItem> education;

  const TeamMember({
    required this.name,
    required this.role,
    required this.phone,
    required this.email,
    required this.whatsapp,
    required this.facebookUrl,
    required this.profilePic,
    required this.education,
  });
}

// ======= Education Data =======
class EducationItem {
  final String label;
  final String value;
  final IconData icon;
  const EducationItem(this.label, this.value, this.icon);
}

// ======= Team Data with Education =======
const List<TeamMember> teamMembers = [
  TeamMember(
    name: "Md Tahsan Islam",
    role: "Lead Developer & Designer",
    phone: "+8801877078962",
    email: "tahsanislam303@gmail.com",
    whatsapp: "+8801402061830",
    facebookUrl: "https://www.facebook.com/share/1AsXKDLwAu/",
    profilePic: 'assets/images/my_photo.jpg',
    education: [
      EducationItem("School", "Mymensingh Zilla School, Mymensingh", Icons.school),
      EducationItem("College", "Ananda Mohan College, Mymensingh", Icons.cast_for_education),
      EducationItem("University", "University of Frontier Technology, Bangladesh (UFTB)", Icons.account_balance),
      EducationItem("Subject", "Educational Technology and Engineering", Icons.computer),
      EducationItem("Skills", "HTML, CSS, JS, Java, C, C++, Python, Game Development, App development, Animator(Whiteboard), Sound Designer, Video Editor", Icons.code),
    ],
  ),
  TeamMember(
    name: "Mufrid Johanee",
    role: "Backend Developer",
    phone: "+8801643782525",
    email: "mufridjohanee@gmail.com",
    whatsapp: "+8801643782525",
    facebookUrl: "https://www.facebook.com/share/15XrHnWWmNu/",
    profilePic: 'assets/images/Mufrid.jpg',
    education: [
      EducationItem("University","University of Frontier Technology, Bangladesh (UFTB)", Icons.account_balance),
      EducationItem("Subject", "Educational Technology and Engineering", Icons.computer),
      EducationItem("Skills", "Laravel, HTML, C++, CSS, JS", Icons.code),
    ],
  ),
  TeamMember(
    name: "Shadiya Zaman Tanha",
    role: "Idea Generator",
    phone: "+8801747239526",
    email: "shadiyazamantanha@gmail.com",
    whatsapp: "+8801747239526",
    facebookUrl: "https://www.facebook.com/share/17dB9wCCCa/",
    profilePic: 'assets/images/Tanha.jpg',
    education: [
      EducationItem("University", "University of Frontier Technology, Bangladesh (UFTB)", Icons.account_balance),
      EducationItem("Subject", "Educational Technology and Engineering", Icons.video_collection),
      EducationItem("Skills", "Idea Generation, Flutter", Icons.lightbulb),
    ],
  ),
];

// ======= Team Section with Responsive Design =======
class TeamSection extends StatelessWidget {
  const TeamSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = AppColors.primary(context);
    final textColor = AppColors.mainText(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          'Meet the Team',
          style: AppTextStyles.headline(context).copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: teamMembers.map((member) {
            return SizedBox(
              width: screenWidth < 600 ? screenWidth * 0.95 : (screenWidth / 2) - 30,
              child: _buildTeamCard(context, member, color, textColor),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTeamCard(BuildContext context, TeamMember member, Color color, Color textColor) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile + Name + Role Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: color.withOpacity(0.1),
                  backgroundImage: AssetImage(member.profilePic),
                  child: ClipOval(
                    child: Image.asset(
                      member.profilePic,
                      fit: BoxFit.cover,
                      width: 64,
                      height: 64,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.person, size: 35, color: color),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Clickable Name with FB icon
                      GestureDetector(
                        onTap: () => _launchUrl(context, member.facebookUrl),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                member.name,
                                style: AppTextStyles.headline(context).copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.facebook, size: 18, color: const Color(0xFF1877F2)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          member.role,
                          style: AppTextStyles.body(context).copyWith(
                            fontSize: 14,
                            color: color,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Contact Row
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildContactTile(context, Icons.phone, member.phone, () => _launchUrl(context, 'tel:${member.phone}')),
                _buildContactTile(context, Icons.email, member.email, () => _launchUrl(context, 'mailto:${member.email}')),
                _buildContactTile(context, Icons.chat, 'WhatsApp', () => _launchUrl(context, 'https://wa.me/${member.whatsapp.replaceAll('+', '')}')),
              ],
            ),
            const SizedBox(height: 20),
            // Individual Education Section
            Text(
              'Education',
              style: AppTextStyles.headline(context).copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...member.education.map((edu) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.15),
                    child: Icon(edu.icon, color: color, size: 18),
                    radius: 14,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${edu.label}:",
                          style: AppTextStyles.body(context).copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Flexible(
                          child: Text(
                            edu.value,
                            style: AppTextStyles.body(context).copyWith(
                              fontSize: 14,
                              color: textColor.withOpacity(0.85),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile(BuildContext context, IconData icon, String text, VoidCallback onTap) {
    final color = AppColors.primary(context);
    return SizedBox(
      width: 120,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.background(context).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: AppTextStyles.body(context).copyWith(
                    fontSize: 13,
                    color: AppColors.mainText(context),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch URL')),
        );
      }
    }
  }
}

// ======= Contact Us Page (100% Responsive - FIXED) ===========
class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us', style: AppTextStyles.appBar(context)),
        centerTitle: true,
        backgroundColor: AppColors.background(context),
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primary(context)),
      ),
      backgroundColor: AppColors.background(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenW = constraints.maxWidth;
          final maxWidth = screenW < 540
              ? screenW * 0.95
              : screenW < 900
              ? 520.0
              : 700.0;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenW < 500 ? 16.0 : 32.0,
              vertical: screenW < 500 ? 24.0 : 32.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Card(
                color: AppColors.background(context),
                elevation: 8,
                shadowColor: AppColors.cardShadow(context).withOpacity(0.15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenW < 500 ? 20.0 : 24.0,
                    vertical: screenW < 500 ? 24.0 : 32.0,
                  ),
                  child: const TeamSection(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
