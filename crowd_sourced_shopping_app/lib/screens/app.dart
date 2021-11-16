import 'package:crowd_sourced_shopping_app/exports.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return ThemeProvider(
        themes: [
          AppTheme(
            id: 'dark',
            description: 'darkTheme',
            data: ThemeData.dark(),
          ),
          AppTheme(
            id: 'light',
            description: 'lightTheme',
            data: ThemeData.light(),
          )
        ],
        defaultThemeId: user.isDarkMode ? 'dark' : 'light',
        child: Builder(
            builder: (context) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Crowd Sourced Shopping App Login',
                  theme: ThemeProvider.themeOf(context).data,
                  home: LoginScreen(),
                )));
  }
}
