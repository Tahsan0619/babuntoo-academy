import 'package:flutter/material.dart';

class MenuOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget targetPage;

  MenuOption(this.icon, this.title, this.subtitle, this.targetPage);
}

class Menu extends StatelessWidget {
  final List<MenuOption> options;
  const Menu({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    // Grid: 2 columns on phone, 3 on small tablet, 4+ on large tablet/desktop
    int crossAxisCount =
    deviceWidth > 1100 ? 4 : deviceWidth > 800 ? 3 : deviceWidth > 530 ? 2 : 1;
    final cardHeight = deviceWidth < 800 ? 110.0 : 130.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      child: GridView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: options.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 18,
          crossAxisSpacing: 16,
          childAspectRatio: 2.4,
        ),
        itemBuilder: (context, index) => _MenuCard(
          option: options[index],
          cardHeight: cardHeight,
        ),
      ),
    );
  }
}

class _MenuCard extends StatefulWidget {
  final MenuOption option;
  final double cardHeight;
  const _MenuCard({Key? key, required this.option, required this.cardHeight}) : super(key: key);

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard> with SingleTickerProviderStateMixin {
  double _elev = 3;
  late AnimationController _anim;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 140));
    _scale = Tween<double>(begin: 1, end: 0.97).animate(_anim);
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _onTap() async {
    await _anim.forward();
    await _anim.reverse();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget.option.targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surfaceVariant;
    final titleTextColor = Colors.red;
    final subtitleTextColor = theme.textTheme.bodyMedium?.color?.withOpacity(0.7) ?? Colors.grey;
    final primaryColor = theme.colorScheme.primary;

    return ScaleTransition(
      scale: _scale,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        elevation: _elev,
        shadowColor: primaryColor.withAlpha(80),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _onTap,
          onHover: (h) => setState(() => _elev = h ? 8 : 3),
          splashColor: primaryColor.withOpacity(0.1),
          highlightColor: primaryColor.withOpacity(0.09),
          child: Container(
            height: widget.cardHeight,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: primaryColor.withOpacity(0.07)),
              color: backgroundColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withOpacity(0.18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(widget.option.icon, size: 32, color: primaryColor),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.option.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: titleTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.option.subtitle.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            widget.option.subtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(color: subtitleTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.arrow_forward_ios, color: Colors.red.shade400, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
