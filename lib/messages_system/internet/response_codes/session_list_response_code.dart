//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum SessionListResponseCode {
  unknown(id: -1),
  error(id: 0),
  success(id: 1);

  final int id;
  const SessionListResponseCode({required this.id});
  static SessionListResponseCode fromId(int id) {
    return SessionListResponseCode.values.firstWhere(
      (e) => e.id == id,
      orElse: () => SessionListResponseCode.unknown,
    );
  }
}
