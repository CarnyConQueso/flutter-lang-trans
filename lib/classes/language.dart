class Language {
  final int id;
  final String langCode;
  final String flag;
  final String name;

  Language(this.id, this.langCode, this.flag, this.name);

  static List<Language> langList() {
    return <Language>[
      Language(1, 'en', '🇺🇸', 'English'),
      Language(2, 'es', '🇪🇸', 'Español'),
      Language(3, 'fr', '🇫🇷', 'Français')
    ];
  }
}
