import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home_page_state.dart';

final homePageVMProvider = NotifierProvider<HomePageViewModel, HomePageState>(
  HomePageViewModel.new,
);

class HomePageViewModel extends Notifier<HomePageState> {
  @override
  HomePageState build() {
    return HomePageState();
  }
}
