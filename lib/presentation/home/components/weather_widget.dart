import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/context.dart';
import '../../../core/extension/widget.dart';
import '../../shared/components/app_text_theme.dart';
import '../../theme/app_color.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget(
      {super.key,
      required this.regionName,
      required this.countryName,
      required this.bgColor,
      required this.temp,
      required this.weather,
      required this.weatherIcon});
  final String regionName;
  final String countryName;
  final String weather;
  final double temp;
  final Color bgColor;
  final String weatherIcon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.height,
          width: context.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [bgColor, Colors.white])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                child: SizedBox(
                  height: 250,
                  child: Opacity(
                      opacity: 0.5,
                      child: CachedNetworkImage(
                        imageUrl: 'https:$weatherIcon',
                        errorWidget: (_, _a, _b) {
                          return const SizedBox();
                        },
                        fit: BoxFit.fitWidth,
                      )),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          top: 195,
          child: SizedBox(
            child: Text(
              '$temp°C',
              style: AppTextTheme.semiBold60
                  .copyWith(color: AppColor.white, fontSize: 50),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned.fill(
          top: 80,
          child: Column(
            children: [
              Text(
                weather,
                style: AppTextTheme.semiBold25.copyWith(color: AppColor.white),
                textAlign: TextAlign.center,
              ),
              Text(
                '$regionName, $countryName',
                style: AppTextTheme.semiBold20.copyWith(color: AppColor.white),
                textAlign: TextAlign.center,
              ),
            ],
          ).padHor(10),
        )
      ],
    );
  }
}
