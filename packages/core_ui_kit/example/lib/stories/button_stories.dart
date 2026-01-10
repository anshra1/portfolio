import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_ui_kit/core_ui_kit.dart';

// --- Primary Button ---
@widgetbook.UseCase(
  name: 'Default',
  type: KitPrimaryButton,
)
Widget primaryButtonDefault(BuildContext context) {
  return Center(
    child: KitPrimaryButton(
      onPressed: () {},
      child: const Text('Primary Button'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Disabled',
  type: KitPrimaryButton,
)
Widget primaryButtonDisabled(BuildContext context) {
  return Center(
    child: KitPrimaryButton(
      onPressed: null,
      state: KitButtonState.disabled,
      child: const Text('Disabled Button'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Loading',
  type: KitPrimaryButton,
)
Widget primaryButtonLoading(BuildContext context) {
  return Center(
    child: KitPrimaryButton(
      onPressed: () {},
      state: KitButtonState.loading,
      child: const Text('Loading Button'),
    ),
  );
}

// --- Destructive Button ---
@widgetbook.UseCase(
  name: 'Default',
  type: KitDestructiveButton,
)
Widget destructiveButtonDefault(BuildContext context) {
  return Center(
    child: KitDestructiveButton(
      onPressed: () {},
      child: const Text('Destructive Button'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Outlined',
  type: KitDestructiveButton,
)
Widget destructiveButtonOutlined(BuildContext context) {
  return Center(
    child: KitDestructiveButton(
      onPressed: () {},
      outlined: true,
      child: const Text('Destructive Outlined'),
    ),
  );
}

// --- Secondary Button ---
@widgetbook.UseCase(
  name: 'Default',
  type: KitSecondaryButton,
)
Widget secondaryButtonDefault(BuildContext context) {
  return Center(
    child: KitSecondaryButton(
      onPressed: () {},
      child: const Text('Secondary Button'),
    ),
  );
}

// --- Outline Button ---
@widgetbook.UseCase(
  name: 'Default',
  type: KitOutlineButton,
)
Widget outlineButtonDefault(BuildContext context) {
  return Center(
    child: KitOutlineButton(
      onPressed: () {},
      child: const Text('Outline Button'),
    ),
  );
}

// --- Ghost Button ---
@widgetbook.UseCase(
  name: 'Default',
  type: KitGhostButton,
)
Widget ghostButtonDefault(BuildContext context) {
  return Center(
    child: KitGhostButton(
      onPressed: () {},
      child: const Text('Ghost Button'),
    ),
  );
}

// --- Link Button ---
@widgetbook.UseCase(
  name: 'Default',
  type: KitLinkButton,
)
Widget linkButtonDefault(BuildContext context) {
  return Center(
    child: KitLinkButton(
      onPressed: () {},
      text: 'Link Button',
    ),
  );
}

// --- Icon Button ---
@widgetbook.UseCase(
  name: 'Default',
  type: KitIconButton,
)
Widget iconButtonDefault(BuildContext context) {
  return Center(
    child: KitIconButton(
      onPressed: () {},
      icon: const Icon(Icons.favorite),
    ),
  );
}

// --- Social Button ---
@widgetbook.UseCase(
  name: 'Google',
  type: KitSocialButton,
)
Widget socialButtonGoogle(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: KitSocialButton(
        onPressed: () {},
        brand: SocialBrand.google,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Apple',
  type: KitSocialButton,
)
Widget socialButtonApple(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: KitSocialButton(
        onPressed: () {},
        brand: SocialBrand.apple,
      ),
    ),
  );
}