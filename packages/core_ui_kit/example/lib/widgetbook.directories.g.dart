// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/stories/button_stories.dart'
    as _example_stories_button_stories;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'atoms',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'buttons',
            children: [
              _widgetbook.WidgetbookComponent(
                name: 'KitDestructiveButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder: _example_stories_button_stories
                        .destructiveButtonDefault,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Outlined',
                    builder: _example_stories_button_stories
                        .destructiveButtonOutlined,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'KitGhostButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder: _example_stories_button_stories.ghostButtonDefault,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'KitIconButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder: _example_stories_button_stories.iconButtonDefault,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'KitLinkButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder: _example_stories_button_stories.linkButtonDefault,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'KitOutlineButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _example_stories_button_stories.outlineButtonDefault,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'KitPrimaryButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _example_stories_button_stories.primaryButtonDefault,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Disabled',
                    builder:
                        _example_stories_button_stories.primaryButtonDisabled,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Loading',
                    builder:
                        _example_stories_button_stories.primaryButtonLoading,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'KitSecondaryButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Default',
                    builder:
                        _example_stories_button_stories.secondaryButtonDefault,
                  ),
                ],
              ),
              _widgetbook.WidgetbookComponent(
                name: 'KitSocialButton',
                useCases: [
                  _widgetbook.WidgetbookUseCase(
                    name: 'Apple',
                    builder: _example_stories_button_stories.socialButtonApple,
                  ),
                  _widgetbook.WidgetbookUseCase(
                    name: 'Google',
                    builder: _example_stories_button_stories.socialButtonGoogle,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
