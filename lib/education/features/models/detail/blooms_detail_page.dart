import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/app_images.dart';
import '../models_data.dart';

class BloomsDetailPage extends StatefulWidget {
  const BloomsDetailPage({super.key});

  @override
  State<BloomsDetailPage> createState() => _BloomsDetailPageState();
}

class _BloomsDetailPageState extends State<BloomsDetailPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const repo = ModelsRepository();
    final model = repo.getModelById('blooms_taxonomy');
    final theme = Theme.of(context);

    if (model == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Bloom's Taxonomy")),
        body: const Center(child: Text('Bloom model not found')),
      );
    }

    final levels = [
      _BloomLevel(
        title: 'Remember',
        subtitle: 'Flashcards, quick facts, definitions.',
        color: Colors.blue,
      ),
      _BloomLevel(
        title: 'Understand',
        subtitle: 'Explain ideas in your own words.',
        color: Colors.green,
      ),
      _BloomLevel(
        title: 'Apply',
        subtitle: 'Solve familiar problems with what you know.',
        color: Colors.orange,
      ),
      _BloomLevel(
        title: 'Analyze',
        subtitle: 'Break things into parts and spot patterns.',
        color: Colors.purple,
      ),
      _BloomLevel(
        title: 'Evaluate',
        subtitle: 'Judge options and defend your choice.',
        color: Colors.red,
      ),
      _BloomLevel(
        title: 'Create',
        subtitle: 'Design something new from all your ideas.',
        color: Colors.teal,
      ),
    ];

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;

          return Stack(
            children: [
              _AnimatedBackground(controller: _controller),
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: isWide ? 320 : 260,
                    pinned: true,
                    stretch: false,
                    // Only the image, no text over it
                    flexibleSpace: const FlexibleSpaceBar(
                      background: _FixedHeaderImage(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SafeArea(
                      top: false,
                      bottom: true,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 900),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _IntroCard(model: model),
                                const SizedBox(height: 20),
                                _QuickMetaRow(),
                                const SizedBox(height: 24),
                                _ImagesRow(controller: _controller),
                                const SizedBox(height: 24),
                                _LevelsSection(
                                  levels: levels,
                                  controller: _controller,
                                ),
                                const SizedBox(height: 24),
                                _UseCasesSection(model: model),
                                const SizedBox(height: 24),
                                _DesignerTipSection(),
                                const SizedBox(height: 24),
                                _AboutBloomSection(),

                                const SizedBox(height: 24),
                                const _ReferencesSection(),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// DATA CLASSES

class _BloomLevel {
  final String title;
  final String subtitle;
  final Color color;

  const _BloomLevel({
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

// HEADER IMAGE (fixed, no text)

class _FixedHeaderImage extends StatelessWidget {
  const _FixedHeaderImage();

  @override
  Widget build(BuildContext context) {
    return Image.network(
      AppImages.bloomsMain,
      fit: BoxFit.cover,
      // If you want a subtle dark overlay for readability below AppBar:
      // color: Colors.black.withOpacity(0.15),
      // colorBlendMode: BlendMode.darken,
    );
  }
}

// INTRO + META

class _IntroCard extends StatelessWidget {
  final LearningModel model;

  const _IntroCard({required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.surfaceVariant.withOpacity(0.4)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Your roadmap from basic memory to creative design.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: -4,
            children: [
              _AnimatedChip(
                icon: Icons.category_outlined,
                label: model.category,
              ),
              _AnimatedChip(
                icon: Icons.auto_awesome_outlined,
                label: model.levelFocus,
              ),
              _AnimatedChip(
                icon: Icons.favorite_outline,
                label: 'Perfect for exam planning',
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            model.description,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _QuickMetaRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color tileColor = isDark
        ? theme.colorScheme.surfaceVariant.withOpacity(0.3)
        : theme.colorScheme.surfaceVariant.withOpacity(0.8);

    return Row(
      children: [
        Expanded(
          child: _MetaTile(
            icon: Icons.psychology_alt_outlined,
            title: 'Created by',
            value: 'Benjamin Bloom\n& colleagues',
            color: tileColor,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _MetaTile(
            icon: Icons.calendar_month_outlined,
            title: 'Introduced',
            value: '1956\nrevised 2001',
            color: tileColor,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _MetaTile(
            icon: Icons.school_outlined,
            title: 'Used for',
            value: 'Goals\nquestions\nassessments',
            color: tileColor,
          ),
        ),
      ],
    );
  }
}

class _MetaTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _MetaTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _AnimatedChip extends StatefulWidget {
  final IconData icon;
  final String label;

  const _AnimatedChip({
    required this.icon,
    required this.label,
  });

  @override
  State<_AnimatedChip> createState() => _AnimatedChipState();
}

class _AnimatedChipState extends State<_AnimatedChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _chipController;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _chipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(
        parent: _chipController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _chipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return ScaleTransition(
      scale: _scale,
      child: Chip(
        avatar: Icon(widget.icon, size: 16, color: theme.colorScheme.primary),
        label: Text(widget.label),
        backgroundColor: isDark
            ? theme.colorScheme.surfaceVariant.withOpacity(0.6)
            : theme.colorScheme.surfaceVariant.withOpacity(0.9),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

// IMAGE STRIP

class _ImagesRow extends StatelessWidget {
  final AnimationController controller;

  const _ImagesRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final images = [
      AppImages.bloomsDiagram,
      AppImages.bloomsClassroom,
      AppImages.bloomsNotebook,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'See it in your day',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Bloom is not just theory. It lives in your notes, your labs, and every exam question you answer.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _AnimatedImageCard(
                imageUrl: images[index],
                index: index,
                controller: controller,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AnimatedImageCard extends StatelessWidget {
  final String imageUrl;
  final int index;
  final AnimationController controller;

  const _AnimatedImageCard({
    required this.imageUrl,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final t = (controller.value + index * 0.2) % 1.0;
        final dy = 4 * math.sin(2 * math.pi * t);

        return Transform.translate(
          offset: Offset(0, dy),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.55),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 6,
                  right: 8,
                  child: Text(
                    index == 0
                        ? 'Levels sketch / mind map'
                        : index == 1
                        ? 'Lab or classroom activity'
                        : 'Your notebook / planner',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// LEVELS SECTION

class _LevelsSection extends StatelessWidget {
  final List<_BloomLevel> levels;
  final AnimationController controller;

  const _LevelsSection({
    required this.levels,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bloom levels ladder',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Swipe through and imagine one real task from your course for each step.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: levels.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final level = levels[index];
              return _AnimatedLevelCard(
                index: index,
                total: levels.length,
                level: level,
                controller: controller,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AnimatedLevelCard extends StatelessWidget {
  final int index;
  final int total;
  final _BloomLevel level;
  final AnimationController controller;

  const _AnimatedLevelCard({
    required this.index,
    required this.total,
    required this.level,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final t = (controller.value + index / total) % 1.0;
        final scale = 0.95 + 0.05 * math.sin(2 * math.pi * t);
        final elevation = 4 + 2 * math.sin(2 * math.pi * t);

        return Transform.scale(
          scale: scale,
          child: Material(
            elevation: elevation,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    level.color.withOpacity(0.20),
                    level.color.withOpacity(0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: level.color.withOpacity(0.7),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: level.color,
                    radius: 16,
                    child: Text(
                      '${index + 1}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    level.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    level.subtitle,
                    style: theme.textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '${index + 1} / $total',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: level.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// USE CASES

class _UseCasesSection extends StatelessWidget {
  final LearningModel model;

  const _UseCasesSection({required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bulletItems = model.typicalUses;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Where you’ll actually use it',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...bulletItems.map(
              (use) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('•  '),
                Expanded(
                  child: Text(
                    use,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// DESIGN TIP

class _DesignerTipSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.2),
            theme.colorScheme.secondary.withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.18)
              : theme.colorScheme.primary.withOpacity(0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Pick one topic (Ohm’s law, binary numbers, sorting algorithms) and write 6 tasks: '
                  'one for each Bloom level. You just created a mini lesson plan that moves from easy to epic.',
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

// ABOUT BLOOM + REFERENCES (with inventor image and working links)

class _AboutBloomSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.surfaceVariant.withOpacity(0.4)
            : theme.colorScheme.surfaceVariant.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who made it?',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  AppImages.bloomsInventor,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Benjamin Bloom (1913–1999)',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Bloom was an educational psychologist who led a group of researchers to classify learning goals. "
                          "Their work turned into the taxonomy still used for designing learning objectives today.",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Why students still care',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Universities, accreditation bodies, and teachers still use Bloom to write course outcomes and exam questions. '
                'Knowing the levels helps you guess what a teacher is really testing and how to push your answers higher.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _ReferencesSection extends StatelessWidget {
  const _ReferencesSection();

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // In production you might show a snackbar instead of throwing.
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.surfaceVariant.withOpacity(0.35)
            : theme.colorScheme.surfaceVariant.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Want to go deeper?',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          _RefItem(
            title: 'Original taxonomy (1956)',
            subtitle: 'Benjamin Bloom et al., Handbook I: Cognitive Domain.',
            onTap: () => _openUrl(
              'https://en.wikipedia.org/wiki/Bloom%27s_taxonomy',
            ),
          ),
          const SizedBox(height: 6),
          _RefItem(
            title: 'Revised taxonomy (2001)',
            subtitle:
            'Anderson & Krathwohl, A Taxonomy for Learning, Teaching, and Assessing.',
            onTap: () => _openUrl(
              'https://www.apu.edu/live_data/files/333/blooms_taxonomy_action_verbs.pdf',
            ),
          ),
          const SizedBox(height: 6),
          _RefItem(
            title: 'Student-friendly overview',
            subtitle:
            'Quick intro to using Bloom levels when you plan study sessions.',
            onTap: () => _openUrl(
              'https://www.educationcorner.com/blooms-taxonomy/',
            ),
          ),
        ],
      ),
    );
  }
}

class _RefItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RefItem({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.open_in_new, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// BACKGROUND

class _AnimatedBackground extends StatelessWidget {
  final AnimationController controller;

  const _AnimatedBackground({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final t = controller.value;
          final offset1 = 40 * math.sin(2 * math.pi * t);
          final offset2 = 30 * math.cos(2 * math.pi * t);

          return Stack(
            children: [
              Positioned(
                top: -120 + offset1,
                left: -60,
                child: _blurCircle(
                  color: theme.colorScheme.primary.withOpacity(0.12),
                  size: 220,
                ),
              ),
              Positioned(
                bottom: -100 + offset2,
                right: -40,
                child: _blurCircle(
                  color: theme.colorScheme.secondary.withOpacity(0.12),
                  size: 200,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _blurCircle({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
