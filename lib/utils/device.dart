// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'remove_accent_converter.dart';

class DeviceInfoDetail {
  DeviceInfoDetail(
      {this.name,
      this.model,
      this.systemVersion,
      this.ipAddress,
      this.os,
      this.version});
  factory DeviceInfoDetail.fromJson(Map<String, dynamic> json) =>
      DeviceInfoDetail(
        name: json['name'] as String,
        model: json['model'] as String,
        systemVersion: json['systemVersion'] as String,
        ipAddress: json['ipAddress'] as String,
        version: json['version'] as String,
      );

  final String? name;
  final String? model;
  final String? systemVersion;
  final String? ipAddress;
  final int? os;
  final String? version;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name?.replaceAll(RegExp(r'[^\w\s]+'), ''),
        'model': model,
        'systemVersion': systemVersion,
        'ipAddress': ipAddress,
        'os': '$os',
        'version': version,
      };
}

class DeviceInfo {
  DeviceInfo({this.deviceId = '', this.deviceInfo});
  final String deviceId;
  final DeviceInfoDetail? deviceInfo;
}

Future<DeviceInfo> getDeviceInfo() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  DeviceInfo? deviceData;
  DeviceInfoDetail deviceInfoDetail;
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // versionRx.value = '${_packageInfo.version}.${_packageInfo.buildNumber}';

  try {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo deviceDataAndroid =
          await deviceInfoPlugin.androidInfo;

      deviceInfoDetail = DeviceInfoDetail(
        model: ConvertHelper.removeAccents(deviceDataAndroid.model),
        name: ConvertHelper.removeAccents(deviceDataAndroid.manufacturer),
        systemVersion: ConvertHelper.removeAccents(await getDeviceOS()),
        ipAddress: await getIps(),
        os: 2,
        version: '${packageInfo.version}.${packageInfo.buildNumber}',
      );

      deviceData = DeviceInfo(
        deviceId: deviceDataAndroid.androidId,
        deviceInfo: deviceInfoDetail,
      );
    } else if (Platform.isIOS) {
      final IosDeviceInfo deviceDataIOS = await deviceInfoPlugin.iosInfo;

      deviceInfoDetail = DeviceInfoDetail(
        model: ConvertHelper.removeAccents(deviceDataIOS.model),
        name: ConvertHelper.removeAccents(deviceDataIOS.name),
        systemVersion: ConvertHelper.removeAccents(await getDeviceOS()),
        ipAddress: await getIps(),
        os: 1,
        version: '${packageInfo.version}.${packageInfo.buildNumber}',
      );

      deviceData = DeviceInfo(
        deviceId: deviceDataIOS.identifierForVendor,
        deviceInfo: deviceInfoDetail,
      );
    }
  } on PlatformException {
    deviceData = DeviceInfo();
  }

  return deviceData!;
}

Future<String> getDeviceOS() async {
  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    final String release = androidInfo.version.release;
    final int sdkInt = androidInfo.version.sdkInt;
    final String manufacturer = androidInfo.manufacturer;
    final String model = androidInfo.model;
    return 'Android $release (SDK $sdkInt), $manufacturer $model';
    // Android 9 (SDK 28), Xiaomi Redmi Note 7
  }

  if (Platform.isIOS) {
    final IosDeviceInfo iosInfo = await DeviceInfoPlugin().iosInfo;
    final String systemName = iosInfo.systemName;
    final String version = iosInfo.systemVersion;
    final String name = iosInfo.name;
    final String model = iosInfo.model;
    return '$systemName $version, $name $model';
    // iOS 13.1, iPhone 11 Pro Max iPhone
  }
  return 'Undefine';
}

Future<String> getIps() async {
  String ip = '';
  for (final NetworkInterface interface in await NetworkInterface.list()) {
    for (final InternetAddress addr in interface.addresses) {
      // print(
      //     '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');

      if (addr.type == InternetAddressType.IPv4) {
        ip = addr.address;
      } else if (ip.isEmpty && addr.type == InternetAddressType.IPv6) {
        ip = addr.address;
      }
    }
  }

  return ip;
}
