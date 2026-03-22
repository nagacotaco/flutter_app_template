import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/default_async_value_widget.dart';
import '../../application/providers/samples_provider.dart';
import '../../domain/entities/sample.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sampleAsync = ref.watch(sampleProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Text('detail #$id'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: DefaultAsyncValueWidget(
        asyncValue: sampleAsync,
        builder: (context, sample) => _SampleDetail(sample: sample),
      ),
    );
  }
}

class _SampleDetail extends StatelessWidget {
  const _SampleDetail({required this.sample});

  final Sample sample;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  '${sample.id}',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  sample.name,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Chip(label: Text(sample.category)),
          const SizedBox(height: 16),
          Row(
            children: List.generate(
              5,
              (i) => Icon(
                i < sample.rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(sample.description, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
