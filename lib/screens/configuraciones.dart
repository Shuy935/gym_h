import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../darkmode/theme_provider.dart';

class ConfiguracionesScreen extends StatelessWidget {
  const ConfiguracionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: themeProvider.isDarkMode
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Configuraciones'),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeProvider.appBarColor1,
                      themeProvider.appBarColor2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            body: Center(
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const ListTile(
                      title: Text(
                        'P R E F E R E N C I A S',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text('Dark Mode'),
                      trailing: Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          themeProvider.toggleTheme();
                        },
                      ),
                    ),
                    const ListTile(
                      title: SizedBox(width: 50),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
