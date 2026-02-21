//Ids should never change after you push them to repo.
//Two types should not have the same id.
enum SearchResponseCode {
  unknown(id: -1),
  notFound(id: 0),
  found(id: 1),
  error(id: 2);

  final int id;
  const SearchResponseCode({required this.id});
  static SearchResponseCode fromId(int id) {
    return SearchResponseCode.values.firstWhere(
          (e) => e.id == id,
      orElse: () => SearchResponseCode.unknown,
    );
  }
}
