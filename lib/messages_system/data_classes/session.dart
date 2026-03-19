class Session {
  int userId;
  int sessionId;
  List<int> accessToken;
  List<int> refreshToken;
  Session(this.userId,this.sessionId,this.accessToken,this.refreshToken);
}