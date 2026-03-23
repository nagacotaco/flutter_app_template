import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/widgets/default_async_value_widget.dart';
import '../../application/providers/pets_provider.dart';
import '../../application/view_model/pet_list_view_model.dart';
import '../../domain/entities/pet_entity.dart';

class PetListPage extends ConsumerWidget {
  const PetListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(petListVMProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets'),
      ),
      body: DefaultAsyncValueWidget(
        asyncValue: state.petsAsync,
        onRetry: () => ref.invalidate(petsProvider),
        builder: (context, pets) => _PetList(
          pets: pets,
          onRefresh: () => ref.refresh(petsProvider.future),
        ),
      ),
    );
  }
}

class _PetList extends StatelessWidget {
  const _PetList({required this.pets, required this.onRefresh});

  final List<PetEntity> pets;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: pets.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) => _PetCard(pet: pets[index]),
      ),
    );
  }
}

class _PetCard extends StatelessWidget {
  const _PetCard({required this.pet});

  final PetEntity pet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => PetDetailRoute(id: pet.id).go(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PetAvatar(pet: pet),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pet.name,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        _StatusChip(status: pet.status),
                      ],
                    ),
                    if (pet.categoryName != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        pet.categoryName!,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                    if (pet.tags.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        children: pet.tags
                            .map(
                              (tag) => Chip(
                                label: Text(tag),
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                              ),
                            )
                            .toList(),
                      ),
                    ],
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

class _PetAvatar extends StatelessWidget {
  const _PetAvatar({required this.pet});

  final PetEntity pet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (pet.photoUrls.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          pet.photoUrls.first,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _fallback(theme),
        ),
      );
    }
    return _fallback(theme);
  }

  Widget _fallback(ThemeData theme) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: theme.colorScheme.primaryContainer,
      child: Text(
        pet.name.isNotEmpty ? pet.name[0] : '?',
        style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final PetStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      PetStatus.available => ('販売中', Colors.green),
      PetStatus.pending => ('保留中', Colors.orange),
      PetStatus.sold => ('売約済', Colors.red),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
