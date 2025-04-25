import 'package:flutter/material.dart';
import 'package:neoquest/widgets/animated_logo.dart';
import 'package:neoquest/widgets/custom_button.dart';
import 'package:neoquest/theme/neoquest.dart';
import 'package:neoquest/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: NeoQuestTheme.backgroundColor,
      body: Stack(
        children: [
          // Animated background bubbles
          ...List.generate(
            5,
            (i) => Positioned(
              top: (i * 100).toDouble(),
              left: ((i % 2) * 200).toDouble(),
              child: _Bubble(delay: i * 300),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const AnimatedLogo(),
                  const SizedBox(height: 40),
                  Text(
                    'Добро пожаловать, Квестер!',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  // Menu grid
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: const [
                        _MenuCard(
                          icon: Icons.history_edu,
                          label: 'История',
                          route: AppRoutes.history,
                        ),
                        _MenuCard(
                          icon: Icons.shopping_cart,
                          label: 'Магазин',
                          route: AppRoutes.shop,
                        ),
                        _MenuCard(
                          icon: Icons.rocket_launch,
                          label: 'Акселератор',
                          route: AppRoutes.accelerator,
                        ),
                        _MenuCard(
                          icon: Icons.map,
                          label: 'Квест',
                          route: AppRoutes.quest,
                        ),
                        _MenuCard(
                          icon: Icons.school,
                          label: 'Академия',
                          route: AppRoutes.education,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Мои баллы: 120',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Menu option card
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const _MenuCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: NeoQuestTheme.primaryColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: NeoQuestTheme.accentColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

// Floating animated bubble
class _Bubble extends StatefulWidget {
  final int delay;
  const _Bubble({Key? key, this.delay = 0}) : super(key: key);

  @override
  __BubbleState createState() => __BubbleState();
}

class __BubbleState extends State<_Bubble> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _anim = Tween<double>(begin: 0, end: -50).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _anim.value),
          child: const Opacity(
            opacity: 0.2,
            child: Icon(
              Icons.bubble_chart,
              size: 80,
              color: NeoQuestTheme.accentColor,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
