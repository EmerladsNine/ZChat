import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/data_classes/session_list.dart';
import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/ok_event.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/response_codes/session_list_response_code.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class SessionListResponseCodeHandler extends Handler {

  @override
  bool handle(List<int> buffer, ServerApi api,ChatsManager chatsManager) {
    int responseCode = buffer[0];
    buffer.removeAt(0);
    if (responseCode == SessionListResponseCode.error.id)
    {
      CallbackNotifiers.sessionListResponse.value = OkEvent();
    }
    else if(responseCode == SessionListResponseCode.success.id)
    {
        while(buffer.isNotEmpty)
        {
            if(buffer.length < userIdBytes + sessionListVersionBytes + 1)
            {
              CallbackNotifiers.sessionListResponse.value = OkEvent();
              return true;
            }
            int userId = bigEndianToInt(buffer, userIdBytes);
            int version = bigEndianToInt(buffer, sessionListVersionBytes);
            int sessionsCount = bigEndianToInt(buffer, 1);
            if(buffer.length < sessionsCount * sessionIdBytes)
            {
              CallbackNotifiers.sessionListResponse.value = OkEvent();
              return true;
            }
            List<int> sessions = [];
            for(int i = 0;i < sessionsCount;i++)
            {
                sessions.add(bigEndianToInt(buffer, sessionIdBytes));
            }
            SessionList sessionList = SessionList(version: version, sessions: sessions);
            chatsManager.sessionListsCache[userId] = sessionList;
            CallbackNotifiers.sessionListResponse.value = OkEvent();
        }
    }
    return true;
  }
}