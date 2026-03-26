import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/app_button_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/app_components_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/app_gap_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/app_overlay_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/app_text_field_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/dialog_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/typography_tab.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CatalogScreen();
  }
}

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _tabs = [
    'Typography',
    'AppGap',
    'Dialog',
    'Button',
    'TextField',
    'Components',
    'Overlay',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: const Color(0xFF2D2926),
            foregroundColor: const Color(0xFFF7F5F2),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, 0, AppSpacing.lg, 56),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'samples',
                    style: AppTextStyles.labelSmall.copyWith(
                      letterSpacing: AppLetterSpacing.wide,
                    ),
                  ),
                  AppSpacing.gapVXs,
                  Text(
                    'Catalog',
                    style: AppTextStyles.titleLarge.copyWith(
                    ),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: const Color(0xFFC4622D),
              labelColor: const Color(0xFFF7F5F2),
              unselectedLabelColor: const Color(0xFFF7F5F2).withValues(alpha: 0.5),
              labelStyle: AppTextStyles.labelMedium,
              unselectedLabelStyle: AppTextStyles.labelMedium,
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            const TypographyTab(),
            const AppGapTab(),
            const DialogTab(),
            const AppButtonTab(),
            const AppTextFieldTab(),
            const AppComponentsTab(),
            const AppOverlayTab(),
          ],
        ),
      ),
    );
  }
}
