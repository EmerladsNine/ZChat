//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum AuthResponseCode {
  unknown(id: -1),
  emailAccountCreated(id: 0),
  emailAccountEmailExistError(id: 1),
  emailAccountUsernameExistError(id: 2),
  emailAccountInvalidEmailError(id: 3),
  emailAccountInvalidPasswordLengthError(id: 4),
  emailAccountInvalidUsernameError(id: 5),
  emailAccountCreationFailureError(id: 6),
  emailSignInEmailNotExistError(id: 7),
  emailSignInFailureError(id: 8),
  emailSignInPasswordIncorrectError(id: 9),
  emailSignInDone(id: 10),
  googleAuthInvalidToken(id: 11),
  googleAuthSuccessful(id: 12),
  googleAuthFailed(id: 13),
  googleAuthRequireSignUp(id: 14),
  googleSignUpInvalidUsernameError(id: 15),
  googleSignUpUsernameExistError(id: 16),
  googleSignUpGoogleIdExistError(id: 17);

  final int id;
  const AuthResponseCode({required this.id});
  static AuthResponseCode fromId(int id) {
    return AuthResponseCode.values.firstWhere(
      (e) => e.id == id,
      orElse: () => AuthResponseCode.unknown,
    );
  }
}
