//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum ResponseCode {
  emailAccountCreated(id: 0),
  ;
  final int id;
  const ResponseCode({required this.id});
  static ResponseCode fromId(int id)
  {
    return ResponseCode.values.firstWhere((e) => e.id == id);
  }
}