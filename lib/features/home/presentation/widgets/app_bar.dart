import 'package:bayzat_test/app/theme/colors.dart';
import 'package:bayzat_test/core/constants/config.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.displayLogo = true,
    this.backgroundColor = Colors.white,
  });

  final Color backgroundColor;
  final bool displayLogo;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 2)),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            if (displayLogo)
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Image(image: AssetImage('assets/images/logo.png')),
                    SizedBox(width: 8),
                    Text(
                      AppConfig.appName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: ColorPalette.darkPurple,
                      ),
                    ),
                  ],
                ),
              ),
            if (Navigator.of(context).canPop())
              Positioned(
                left: 4,
                child: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
