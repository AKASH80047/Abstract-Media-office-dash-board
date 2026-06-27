import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';

class LeftSidebar extends ConsumerWidget {
  final bool isDrawer;

  const LeftSidebar({super.key, required this.isDrawer});

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == '/employees') return 1;
    if (location == '/attendance') return 2;
    if (location == '/summary') return 3;
    if (location == '/information') return 4;
    if (location == '/settings') return 5;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    if (isDrawer) {
      Navigator.of(context).pop(); // Close drawer first
    }
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/employees');
        break;
      case 2:
        context.go('/attendance');
        break;
      case 3:
        context.go('/summary');
        break;
      case 4:
        context.go('/information');
        break;
      case 5:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = _getSelectedIndex(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E293B)
            : Colors.white,
        border: Border(
          right: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo Section
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
            child: _buildLogo(context),
          ),

          // User Profile Card
          _buildUserProfileCard(context),

          const Divider(indent: 20, endIndent: 20, height: 24),

          // Scrollable Menu Area
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Navigation Items
                  _buildMenuItem(context, Iconsax.home, 'Home', activeIndex == 0, () => _onItemTapped(0, context)),
                  _buildMenuItem(context, Iconsax.people, 'Employees', activeIndex == 1, () => _onItemTapped(1, context)),
                  _buildMenuItem(context, Iconsax.calendar, 'Attendance', activeIndex == 2, () => _onItemTapped(2, context)),
                  _buildMenuItem(context, Iconsax.document_text, 'Summary', activeIndex == 3, () => _onItemTapped(3, context)),
                  _buildMenuItem(context, Iconsax.info_circle, 'Information', activeIndex == 4, () => _onItemTapped(4, context)),

                  const SizedBox(height: 16),
                  
                  // Workspaces Section
                  _buildWorkspaceHeader(context),
                  _buildWorkspaceItem(context, 'Adstacks', const ['Analytics', 'Projects']),
                  _buildWorkspaceItem(context, 'Finance', const ['Salaries', 'Invoices']),
                ],
              ),
            ),
          ),

          // Bottom Action Panel (Setting & Logout)
          const Divider(indent: 20, endIndent: 20, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              children: [
                _buildMenuItem(context, Iconsax.setting, 'Setting', activeIndex == 5, () => _onItemTapped(5, context)),
                _buildMenuItem(context, Iconsax.logout, 'Logout', false, () {
                  // Simulate Logout
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logging out...')),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE31A1A), Color(0xFF5B3DF5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'AS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Adstacks',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w800,
            fontSize: 15,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfileCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFFDB777), Color(0xFFFD9346), Color(0xFFC23A4A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircleAvatar(
              radius: 36,
              backgroundImage: const CachedNetworkImageProvider(AppConstants.poojaAvatar),
              backgroundColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 8),
          
          // Name
           Text(
            'Akash Pandey',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),

          // Admin Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              boxShadow: AppConstants.cardShadow,
            ),
            child: const Text(
              'Admin',
              style: TextStyle(
                color: AppConstants.textLightColor,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, bool isActive, VoidCallback onTap) {
    return SidebarMenuItem(
      icon: icon,
      title: title,
      isActive: isActive,
      onTap: onTap,
    );
  }

  Widget _buildWorkspaceHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'WORKSPACES',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              letterSpacing: 1.0,
            ),
          ),
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.add, size: 16, color: AppConstants.textLightColor),
            onPressed: () {
              // Action to add workspace
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWorkspaceItem(BuildContext context, String title, List<String> subItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          dense: true,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppConstants.primaryColor,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          children: subItems
              .map(
                (sub) => ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 48),
                  title: Text(
                    sub,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  onTap: () {},
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class SidebarMenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const SidebarMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<SidebarMenuItem> createState() => _SidebarMenuItemState();
}

class _SidebarMenuItemState extends State<SidebarMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        decoration: BoxDecoration(
          color: widget.isActive
              ? (Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF334155) // Sleek dark active background
                  : const Color(0xFFF4F7FE)) // Sleek light active background
              : (_isHovered
                  ? (Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFF7F8FC))
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          onTap: widget.onTap,
          dense: true,
          visualDensity: const VisualDensity(vertical: -1),
          leading: Icon(
            widget.icon,
            color: widget.isActive
                ? Theme.of(context).colorScheme.onSurface
                : AppConstants.iconColor,
            size: 20,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w500,
              color: widget.isActive
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 13.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        ),
      ),
    );
  }
}
