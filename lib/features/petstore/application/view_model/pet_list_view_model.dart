import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/pets_provider.dart';
import 'pet_list_state.dart';

final petListVMProvider = NotifierProvider<PetListViewModel, PetListState>(
  PetListViewModel.new,
);

class PetListViewModel extends Notifier<PetListState> {
  @override
  PetListState build() {
    final pets = ref.watch(petsProvider);
    return PetListState(
      petsAsync: pets,
      isLoading: pets.isLoading,
      error: pets.error,
    );
  }
}
