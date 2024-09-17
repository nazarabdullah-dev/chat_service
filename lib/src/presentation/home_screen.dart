import 'package:chat_service/src/data/cubit/login_cubit.dart';
import 'package:chat_service/src/data/repository/login_repository.dart';
import 'package:chat_service/src/di/dependency_injection.dart';
import 'package:chat_service/src/presentation/chat_screen.dart';
import 'package:chat_service/src/presentation/setting_screen.dart';
import 'package:chat_service/src/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(getIt<LoginRepository>()),
        child: const HomeScreenWidget());
  }
}

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  HomeScreenWidgetState createState() => HomeScreenWidgetState();
}

class HomeScreenWidgetState extends State<HomeScreenWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool openChat = false;

  @override
  void initState() {
    context.read<LoginCubit>().checkAuthStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.appTitle),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SettingScreen.routeName);
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: Row(
            children: [
              SizedBox(
                width: openChat ? 200 : MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () => setState(() {
                    openChat = false;
                  }),
                  child: Container(
                    color: openChat ? Colors.grey : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                        if (state.user != null) {
                          return Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (ScreenUtil.isTablet(context)) {
                                  setState(() {
                                    openChat = true;
                                  });
                                } else {
                                  Navigator.pushNamed(
                                      context, ChatScreen.routeName);
                                }
                              },
                              child: Text(
                                  AppLocalizations.of(context)!.start_chat),
                            ),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.email),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.password),
                              obscureText: true,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<LoginCubit>().signIn(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                              child: Text(AppLocalizations.of(context)!.login),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
              if (openChat) const Expanded(child: ChatScreen())
            ],
          ),
        ));
  }
}
