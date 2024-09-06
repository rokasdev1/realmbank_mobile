import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/presentation/common/providers/theme_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/list_tile_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.heightBox,
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                var isDarkTheme = state is DarkThemeState;
                return ListTileWidget(
                  leading: isDarkTheme ? Icons.dark_mode : Icons.light_mode,
                  text: 'Dark Mode',
                  trailing: CupertinoSwitch(
                    activeColor: context.colorScheme.primary,
                    value: isDarkTheme,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                  onTap: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
