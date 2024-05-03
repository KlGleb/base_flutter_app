import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPermissionsCard extends StatefulWidget {
  const NotificationsPermissionsCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificationPermissionsCardState();
}

class _NotificationPermissionsCardState extends State<NotificationsPermissionsCard> with WidgetsBindingObserver {
  bool _needToShow = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeInQuad,
      switchOutCurve: Curves.easeInQuad,
      duration: const Duration(milliseconds: 300),
      child: !_needToShow
          ? const Padding(
              padding: EdgeInsets.zero,
              key: Key('Permission Card Hidden'),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Разрешите приложению доступ к оповещениям, '
                        'чтобы мы уведомляли вас о счетах и других важных действиях',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(onPressed: _close, child: const Text('Закрыть')),
                          const SizedBox(width: 8),
                          ElevatedButton(onPressed: _askForPermissions, child: const Text('Разрешить доступ')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void initState() {
    _initCheckForPermissions();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initCheckForPermissions();
    }
  }

  Future<void> _initCheckForPermissions() async {
    final permissionStatus = await Permission.notification.notificationStatus();
    _checkForPermissions(permissionStatus);
  }

  Future<void> _checkForPermissions(PermissionStatus permissionStatus) async {
    if (!permissionStatus.isGranted && !permissionStatus.isLimited && !permissionStatus.isPermanentlyDenied) {
      setState(() {
        _needToShow = true;
      });
    } else {
      setState(() {
        _needToShow = false;
      });
    }
  }

  Future<void> _askForPermissions() async {
    final permissionStatus = await Permission.notification.notificationRequest();
    if (permissionStatus != null) {
      _checkForPermissions(permissionStatus);
    }
  }

  void _close() {
    setState(() {
      _needToShow = false;
    });
  }
}

///Temporary fix https://github.com/Baseflow/flutter-permission-handler/issues/902
extension TemporaryNotificationsStatusSolution on Permission {
  static const _permissionName = 'notificationsPermanentlyDenied';
  static const _diffInMills = 500;

  Future<PermissionStatus> notificationStatus() async {
    var permissionStatus = await Permission.notification.status;
    if (!permissionStatus.isDenied || !(await _isAndroidSdk33())) {
      return permissionStatus;
    }

    final preferences = await SharedPreferences.getInstance();
    final flag = preferences.getBool(_permissionName);
    if (flag == true && permissionStatus.isDenied) {
      return PermissionStatus.permanentlyDenied;
    }

    return permissionStatus;
  }

  ///returns null when it opens App Settings
  Future<PermissionStatus?> notificationRequest() async {
    if (!(await _isAndroidSdk33())) {
      return await Permission.notification.request();
    }

    final checkStatusTime = DateTime.now();
    final status = await Permission.notification.status;
    final newStatus = await Permission.notification.request();
    final newCheckStatusTime = DateTime.now();
    Duration difference = newCheckStatusTime.difference(checkStatusTime);

    if (status.isDenied && newStatus.isPermanentlyDenied && difference.inMilliseconds < _diffInMills) {
      final preferences = await SharedPreferences.getInstance();
      preferences.setBool(_permissionName, true);
      openAppSettings();
      return null;
    }

    return newStatus;
  }

  Future<bool> _isAndroidSdk33() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt == 33;
  }
}
