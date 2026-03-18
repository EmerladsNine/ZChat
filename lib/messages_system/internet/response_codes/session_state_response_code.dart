//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum SessionStateResponseCode {
  unknown(id: -1),
  notAuthenticated(id: 0),
  authenticationFailure(id: 1),
  accessTokenExpired(id: 2),
  sessionAuthenticationSuccess(id: 3);

  final int id;
  const SessionStateResponseCode({required this.id});
  static SessionStateResponseCode fromId(int id) {
    return SessionStateResponseCode.values.firstWhere(
          (e) => e.id == id,
      orElse: () => SessionStateResponseCode.unknown,
    );
  }
}
