import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final ThemeData appTheme = Theme.of(context);
    final bool isDark = appTheme.brightness == Brightness.dark;
    final qrBgColor = isDark ? appTheme.colorScheme.onSurface : appTheme.colorScheme.surface;
    final qrColor = isDark ? appTheme.colorScheme.surface : appTheme.colorScheme.onSurface;

    return Column(
      children: [
        Text('12 350 ₽', style: theme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 20),
        Text(
          'Самый удобный способ оплатить счет '
          '-- воспользоваться QR-кодом:',
          style: theme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        QrImageView(
          data: '1234567890 1234567890 1234567890 adfawe asdlfjh awefj sakldfj ',
          version: QrVersions.auto,
          size: 250.0,
          dataModuleStyle: QrDataModuleStyle(
            color: qrColor,
            dataModuleShape: QrDataModuleShape.square,
          ),
          eyeStyle: QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: qrColor,
          ),
          backgroundColor: qrBgColor,
          // backgroundColor: Theme.of(context).colorScheme.background,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.save_alt_outlined),
              label: const Text('Сохранить'),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share_outlined),
              label: const Text('Поделиться'),
            ),
          ],
        ),
      ],
    );
  }
}
