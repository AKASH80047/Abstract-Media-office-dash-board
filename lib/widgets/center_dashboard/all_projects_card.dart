import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_constants.dart';
import '../../models/project.dart';
import '../../services/dummy_data_service.dart';

class AllProjectsCard extends StatelessWidget {
  const AllProjectsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = DummyDataService.getProjects();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151D3B), // Dark navy card matching mockup
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: AppConstants.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Projects',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final project = projects[index];
              return _ProjectListItem(project: project);
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectListItem extends StatefulWidget {
  final Project project;

  const _ProjectListItem({required this.project});

  @override
  State<_ProjectListItem> createState() => _ProjectListItemState();
}

class _ProjectListItemState extends State<_ProjectListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.project.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.project.backgroundColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            // Thumbnail image with glass-like border
            Container(
              padding: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.5),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CachedNetworkImage(
                    imageUrl: widget.project.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey[800]),
                    errorWidget: (context, url, error) => const Icon(Iconsax.image, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Project #1',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        ' • ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'See project details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Edit icon button
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Iconsax.edit_2, size: 13, color: Colors.white),
                onPressed: () {
                  // Trigger project edit view
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
