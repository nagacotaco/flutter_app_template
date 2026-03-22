import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/default_async_value_widget.dart';
import '../../application/providers/pets_provider.dart';
import '../../domain/entities/pet_entity.dart';

class PetDetailPage extends ConsumerWidget {
  const PetDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petAsync = ref.watch(petByIdProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Text('Pet #$id'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/petstore');
            }
          },
        ),
      ),
      body: DefaultAsyncValueWidget(
        asyncValue: petAsync,
        builder: (context, pet) => _PetDetail(pet: pet),
      ),
    );
  }
}

class _PetDetail extends StatelessWidget {
  const _PetDetail({required this.pet});

  final PetEntity pet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pet.photoUrls.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                pet.photoUrls.first,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 240,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.pets,
                    size: 80,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            )
          else
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.pets,
                  size: 80,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  pet.name,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              _StatusBadge(status: pet.status),
            ],
          ),
          if (pet.categoryName != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.category_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  pet.categoryName!,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
          if (pet.tags.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('タグ', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: pet.tags
                  .map(
                    (tag) => Chip(
                      label: Text(tag),
                      avatar: const Icon(Icons.label_outline, size: 16),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 16),
          Text('ID: ${pet.id}', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final PetStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      PetStatus.available => ('販売中', Colors.green),
      PetStatus.pending => ('保留中', Colors.orange),
      PetStatus.sold => ('売約済', Colors.red),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
