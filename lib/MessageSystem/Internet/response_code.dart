//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum ResponseCode {
  emailAccountCreated(id: 0),
  emailAccountEmailExistError(id: 1),
  emailAccountUsernameExistError(id: 2),
  emailAccountInvalidEmailLengthError(id: 3),
  emailAccountInvalidPasswordLengthError(id: 4),
  emailAccountInvalidUsernameLengthError(id: 5),
  emailAccountCreationFailureError(id: 6),
  emailSignInEmailNotExistError(id: 7),
  emailSignInFailureError(id: 8),
  emailSignInPasswordIncorrectError(id: 9),
  emailSignInDone(id: 10),
  googleAuthInvalidToken(id: 11),
  googleAuthSuccessful(id: 12),
  googleAuthFailed (id: 13);

  final int id;
  const ResponseCode({required this.id});
  static ResponseCode fromId(int id) {
    return ResponseCode.values.firstWhere((e) => e.id == id);
  }
}
