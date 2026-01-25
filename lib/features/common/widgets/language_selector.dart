import 'package:ecommerce_assignment_module_31/app/extensions/localization_extension.dart';
import 'package:ecommerce_assignment_module_31/app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(context.localizations.changeLanguage),
        DropdownMenu<String>(
          initialSelection: context
              .read<LanguageProvider>()
              .currentLocale
              .languageCode,
          onSelected: (String? language) {
            context.read<LanguageProvider>().changeLocale(Locale(language!));
          },
          dropdownMenuEntries: [
            DropdownMenuEntry(value: "en", label: "English"),
            DropdownMenuEntry(value: "bn", label: "বাংলা"),
            DropdownMenuEntry(value: "fr", label: "France"),
          ],
        ),
      ],
    );
  }
}
