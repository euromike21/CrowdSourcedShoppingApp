class UserProf {
  final String imagePath;
  final bool isDarkMode;
  final String name;
  final String latitude;
  final String longitude;

  const UserProf({
    required this.imagePath,
    required this.isDarkMode,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  UserProf copy({
    String? imagePath,
    bool? isDarkMode,
    String? name,
    String? latitude,
    String? longitude,
  }) =>
      UserProf(
        imagePath: imagePath ?? this.imagePath,
        isDarkMode: isDarkMode ?? this.isDarkMode,
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  static UserProf fromJson(Map<String, dynamic> json) => UserProf(
      imagePath: json['imagePath'],
      isDarkMode: json['isDarkMode'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude']);

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'isDarkMode': isDarkMode,
        'name': name,
        'latitude': latitude,
        'longitude': longitude
      };
}
