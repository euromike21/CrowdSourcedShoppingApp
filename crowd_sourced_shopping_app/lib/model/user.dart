class UserProf {
  final String imagePath;
  final bool isDarkMode;
  final String name;

  const UserProf({
    required this.imagePath,
    required this.isDarkMode,
    required this.name,
  });

  UserProf copy({
    String? imagePath,
    bool? isDarkMode,
    String? name,
  }) =>
      UserProf(
        imagePath: imagePath ?? this.imagePath,
        isDarkMode: isDarkMode ?? this.isDarkMode,
        name: name ?? this.name,
      );

  static UserProf fromJson(Map<String, dynamic> json) => UserProf(
      imagePath: json['imagePath'],
      isDarkMode: json['isDarkMode'],
      name: json['name']);

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'isDarkMode': isDarkMode,
        'name': name,
      };
}
