import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/theme/app_colors.dart';
import 'package:flutter_app_template/core/theme/app_sizes.dart';
import 'package:flutter_app_template/core/theme/app_text_styles.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/app_button_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/app_components_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/app_gap_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/app_overlay_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/app_text_field_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/dialog_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/style_group_tab.dart';
import 'package:flutter_app_template/features/catalog/presentation/widgets/usage_examples_tab.dart';

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
    'Display',
    'Headline',
    'Title',
    'Body',
    'Label',
    '使用例',
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
            backgroundColor: AppColors.dark,
            foregroundColor: AppColors.cream,
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
                      color: AppColors.cream.withValues(alpha: 0.5),
                      letterSpacing: AppLetterSpacing.wide,
                    ),
                  ),
                  AppSpacing.gapVXs,
                  Text(
                    'Catalog',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.cream,
                    ),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: AppColors.accent,
              labelColor: AppColors.cream,
              unselectedLabelColor: AppColors.cream.withValues(alpha: 0.5),
              labelStyle: AppTextStyles.labelMedium,
              unselectedLabelStyle: AppTextStyles.labelMedium,
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            ...styleGroups.map((g) => StyleGroupTab(group: g)),
            const UsageExamplesTab(),
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
