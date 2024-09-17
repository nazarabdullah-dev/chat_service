import 'package:chat_service/src/data/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.setting),
      ),
      body: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                title: Text(AppLocalizations.of(context)!.language),
                subtitle: Text(state.locale.languageCode),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title:
                            Text(AppLocalizations.of(context)!.select_language),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title:
                                  Text(AppLocalizations.of(context)!.english),
                              onTap: () {
                                context
                                    .read<LocaleCubit>()
                                    .changeLocale(const Locale('en'));
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  AppLocalizations.of(context)!.indonesian),
                              onTap: () {
                                context
                                    .read<LocaleCubit>()
                                    .changeLocale(const Locale('id'));
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text(AppLocalizations.of(context)!
                                  .use_device_locale),
                              onTap: () {
                                context.read<LocaleCubit>().useDeviceLocale();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
