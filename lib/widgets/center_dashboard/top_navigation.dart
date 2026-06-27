import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../providers/dashboard_provider.dart';

class TopNavigation extends ConsumerWidget {
  final String title;

  const TopNavigation({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Drawer menu button on mobile/tablet
          if (!isDesktop) ...[
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Iconsax.menu_1, color: Theme.of(context).colorScheme.onSurface, size: 24),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            const SizedBox(width: 4),
          ],
          
          // Page Title
          Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: 0.5,
            ),
          ),
          
          const Spacer(),

          // Search Bar & Icons cluster
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search Input Pill
              Container(
                width: isDesktop ? 220 : 130,
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B254B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          ref.read(searchQueryProvider.notifier).state = value;
                        },
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: AppConstants.textLightColor, fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    const Icon(Iconsax.search_normal, color: AppConstants.textLightColor, size: 16),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Action Icons Panel (Folder, Notification, Power, Avatar)
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppConstants.cardShadow,
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.transparent
                        : Colors.grey.shade100,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    _buildIconButton(Iconsax.document_copy, () {
                      // Action details
                    }),
                    const SizedBox(width: 6),
                    Stack(
                      children: [
                        _buildIconButton(Iconsax.notification, () {
                          // Notification settings
                        }),
                        Positioned(
                          right: 3,
                          top: 3,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    _buildIconButton(Icons.power_settings_new, () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logging out from session...'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }),
                    const SizedBox(width: 8),
                    // User Avatar
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppConstants.primaryColor.withOpacity(0.3), width: 1.5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: CachedNetworkImage(
                          imageUrl: AppConstants.avatar5,
                          placeholder: (context, url) => Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) => const Icon(Icons.person, size: 16),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(icon, color: AppConstants.iconColor, size: 18),
      ),
    );
  }
}
