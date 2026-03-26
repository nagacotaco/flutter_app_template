import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/widgets/default_async_value_widget.dart';
import '../../application/view_model/home_page_view_model.dart';
import '../../domain/entities/sample.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homePageVMProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: DefaultAsyncValueWidget(
        asyncValue: state.samplesAsync,
        builder: (context, samples) => _SampleList(samples: samples),
      ),
    );
  }
}

class _SampleList extends StatelessWidget {
  const _SampleList({required this.samples});

  final List<Sample> samples;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: samples.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) => _SampleCard(sample: samples[index]),
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.sample});

  final Sample sample;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => DetailRoute(id: sample.id).go(context),
        child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                '${sample.id}',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          sample.name,
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      _RatingStars(rating: sample.rating),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sample.description,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(sample.category),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  const _RatingStars({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (i) => Icon(
          i < rating ? Icons.star : Icons.star_border,
          size: 14,
        ),
      ),
    );
  }
}
