import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:portfolio/features/articles/presentation/bloc/articles_state.dart';
import 'package:portfolio/features/homepage/presentation/layouts/mobile_layout.dart';
import 'package:portfolio/features/homepage/presentation/layouts/tablet_layout.dart';
import 'package:portfolio/features/homepage/presentation/layouts/web_layout.dart';
import 'package:portfolio/features/projects/presentation/bloc/projects_bloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProjectsBloc, ProjectsState>(
          listener: (context, state) {
            if (state is ProjectsFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
        BlocListener<ArticlesBloc, ArticlesState>(
          listener: (context, state) {
            if (state is ArticlesFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure.message)),
              );
            }
          },
        ),
      ],
      child: ScreenSizeBuilder(
        builder: (context, size) {
          return Scaffold(
            body: Builder(
              builder: (context) {
                if (size.isDesktop) {
                  return const WebLayout();
                }
                if (size.isTablet) {
                  return const TabletLayout();
                }
                return const MobileLayout();
              },
            ),
            floatingActionButton: size.isMobile
                ? FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.mail, color: Colors.white),
                  )
                : null,
          );
        },
      ),
    );
  }
}
