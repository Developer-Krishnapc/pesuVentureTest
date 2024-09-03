import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';

import '../../helper/pref_keys.dart';

part 'shar_pref.g.dart';

@riverpod
SharPrefRepo sharedPref(SharedPrefRef ref) =>
    SharPrefImpl(ref.read(secureSharedPrefProvider));

@riverpod
SecureSharedPref secureSharedPref(SecureSharedPrefRef ref) => throw Exception();

abstract class SharPrefRepo {
  Future<void> saveRegion(String region);
  Future<String?> getRegion();
}

class SharPrefImpl extends SharPrefRepo {
  SharPrefImpl(this._pref);

  final SecureSharedPref _pref;

  @override
  Future<String?> getRegion() async {
    final region = await _pref.getString(PrefKeys.region) ?? '';
    if (region.isEmpty) {
      return null;
    }
    return region;
  }

  @override
  Future<void> saveRegion(String region) async {
    await _pref.putString(PrefKeys.region, region);
  }
}
