import 'package:zchat/messages_system/internet/response_codes/search_response_code.dart';

class SearchEvent {
  final SearchResponseCode code;
  final int? id;
  final String? name;
  SearchEvent(this.code,this.id,this.name);
}