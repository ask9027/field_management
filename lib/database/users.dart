const String tableUsers = "users";

class UsersFields {
  static final List<String> values = [
    id,
    name,
    age,
    time,
  ];

  static const String id = "_id";
  static const String name = "name";
  static const String age = "age";
  static const String time = "time";
}

class Users {
  final int? id;
  final String name;
  final int age;
  final DateTime createTime;

  const Users({
    this.id,
    required this.name,
    required this.age,
    required this.createTime,
  });

  Users copy({
    int? id,
    String? name,
    int? age,
    DateTime? createTime,
  }) =>
      Users(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        createTime: createTime ?? this.createTime,
      );

  static Users fromJson(Map<String, Object?> json) => Users(
        id: json[UsersFields.id] as int?,
        name: json[UsersFields.name] as String,
        age: json[UsersFields.age] as int,
        createTime: DateTime.parse(json[UsersFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        UsersFields.id: id,
        UsersFields.name: name,
        UsersFields.age: age,
        UsersFields.time: createTime.toIso8601String(),
      };
}
