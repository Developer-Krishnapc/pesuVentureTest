import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/app_utils.dart';
import '../../data/source/local/shar_pref.dart';
import '../../domain/model/weather_model.dart';
import '../shared/model/user_state.dart';
import '../theme/app_color.dart';
import 'components/error_widget.dart';
import 'components/loading_widget.dart';
import 'components/no_region_selected_widget.dart';
import 'components/weather_widget.dart';
import 'providers/weather_notifer.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ProviderSubscription? _weatherSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final cachedRegion = await ref.read(sharedPrefProvider).getRegion();
      ref
          .read(weatherNotifierProvider.notifier)
          .getWeatherByRegion(region: cachedRegion ?? '');
    });
    _weatherSubscription = ref.listenManual<UserState<WeatherModel>>(
        weatherNotifierProvider, (previous, next) {
      if (next.error != '' && ModalRoute.of(context)?.isCurrent == true) {
        AppUtils.flushBar(context, next.error, isSuccessPopup: false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _weatherSubscription?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(weatherNotifierProvider);
    final color =
        AppUtils.getStyleByWeather(temperature: state.data.currentWeather.temp);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: RefreshIndicator(
        onRefresh: () async {
          if (state.data.selectedRegion.isNotEmpty) {
            ref
                .read(weatherNotifierProvider.notifier)
                .getWeatherByRegion(region: state.data.selectedRegion);
          }
        },
        child: state.loading
            ? const Center(
                child: LoadingWidget(),
              )
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: state.error.isNotEmpty
                    ? CustomErrorWidget(
                        error: state.error,
                        region: state.data.selectedRegion,
                      )
                    : state.data.selectedRegion.isEmpty
                        ? const NoRegionSelectedWidget()
                        : WeatherWidget(
                            bgColor: color,
                            countryName: state.data.location.country,
                            regionName: state.data.selectedRegion,
                            temp: state.data.currentWeather.temp,
                            weather: state.data.currentWeather.condition.name,
                            weatherIcon:
                                state.data.currentWeather.condition.iconUrl,
                          ),
              ),
      ),
    );
  }
}
