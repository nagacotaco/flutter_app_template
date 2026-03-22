import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/samples_provider.dart';
import 'home_page_state.dart';

final homePageVMProvider = NotifierProvider<HomePageViewModel, HomePageState>(
  HomePageViewModel.new,
);

class HomePageViewModel extends Notifier<HomePageState> {
  @override
  HomePageState build() {
    final samples = ref.watch(samplesProvider);
    return HomePageState(
      samplesAsync: samples,
      isLoading: samples.isLoading,
      error: samples.error,
    );
  }
}
