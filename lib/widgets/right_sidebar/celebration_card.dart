import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../models/birthday_person.dart';
import '../../providers/dashboard_provider.dart';

class CelebrationCard extends ConsumerWidget {
  final String title;
  final List<BirthdayPerson> people;
  final bool isBirthday;

  const CelebrationCard({
    super.key,
    required this.title,
    required this.people,
    required this.isBirthday,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishingActive = ref.watch(isBirthday ? birthdayWishingProvider : anniversaryWishingProvider);
    
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2347), // Dark cards inside sidebar
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      child: Column(
        children: [
          // Header with Stars Sparkle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 14),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.star, color: Colors.amber, size: 14),
            ],
          ),
          const SizedBox(height: 16),

          // Overlapping Avatars
          _buildAvatarStack(context),
          const SizedBox(height: 16),

          // Total Count Divider Box
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: Colors.white.withOpacity(0.08), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 1,
                    height: 12,
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
                Text(
                  '${people.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 1,
                    height: 12,
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
                const Icon(Iconsax.clock, color: Colors.amber, size: 12),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Action Button
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: wishingActive
                  ? null
                  : () {
                      ref.read(isBirthday ? birthdayWishingProvider.notifier : anniversaryWishingProvider.notifier).triggerWishing();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isBirthday 
                              ? '🎉 Birthday wishes sent successfully!' 
                              : '🎊 Work anniversary congratulations sent!'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppConstants.primaryColor,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor,
                disabledBackgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: wishingActive
                    ? const Row(
                        key: ValueKey('sent'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, size: 14, color: Colors.white),
                          SizedBox(width: 6),
                          Text('Wishes Sent! 🎉', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      )
                    : Row(
                        key: const ValueKey('send'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.direct_send, size: 14, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            isBirthday ? 'Birthday Wishing' : 'Anniversary Wishing',
                            style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarStack(BuildContext context) {
    const double avatarRadius = 20.0;
    const double overlap = 14.0;
    final double stackWidth = (people.length * (avatarRadius * 2)) - ((people.length - 1) * overlap);

    return SizedBox(
      width: stackWidth,
      height: avatarRadius * 2 + 10, // Extra height for birthday hats
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(people.length, (index) {
          final person = people[index];
          final double leftPos = index * (avatarRadius * 2 - overlap);
          
          return Positioned(
            left: leftPos,
            bottom: 0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF1B2347), width: 2),
                  ),
                  child: CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: CachedNetworkImageProvider(person.avatarUrl),
                    backgroundColor: Colors.grey[800],
                  ),
                ),
                // Render custom party hats if it is birthday card
                if (isBirthday) const _PartyHatWidget(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _PartyHatWidget extends StatelessWidget {
  const _PartyHatWidget();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -12,
      left: 10,
      child: RotationTransition(
        turns: const AlwaysStoppedAnimation(15 / 360),
        child: CustomPaint(
          size: const Size(20, 20),
          painter: _HatPainter(),
        ),
      ),
    );
  }
}

class _HatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Triangular hat shape
    final Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF007A), Color(0xFFFF9E00)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, paint);

    // Pom-pom ball on top
    canvas.drawCircle(
      Offset(size.width / 2, 0),
      3,
      Paint()..color = const Color(0xFFFFEB3B),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
