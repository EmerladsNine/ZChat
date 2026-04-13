
import 'package:zchat/messages_system/chats_manager.dart';
import 'package:zchat/messages_system/data_classes/session_list.dart';
import 'package:zchat/messages_system/internet/callback_notifiers.dart';
import 'package:zchat/messages_system/internet/events/message_response_event.dart';
import 'package:zchat/messages_system/internet/handlers/handler.dart';
import 'package:zchat/messages_system/internet/response_codes/message_response_code.dart';
import 'package:zchat/messages_system/internet/server_api.dart';

class NormalMessageResponseCodeHandler extends Handler {
  @override
  bool handle(List<int> buffer, ServerApi service,ChatsManager chatsManager) {
    List<(int,MessageResponseCode)> result = [];
    while(buffer.isNotEmpty)
    {
        if(buffer.length < userIdBytes + 1) break;
        int userId = bigEndianToInt(buffer, userIdBytes);
        int responseCode = buffer[0];
        buffer.removeAt(0);
        if(responseCode == MessageResponseCode.outdatedSessionListVersion.id)
        {
            if(buffer.length < sessionListVersionBytes + 1) break;
            int sessionListVersion = bigEndianToInt(buffer, sessionListVersionBytes);
            int sessionsCount = buffer[0];
            buffer.removeAt(0);
            if(buffer.length < sessionsCount * sessionIdBytes) break;
            List<int> sessions = [];
            for(int i = 0;i < sessionsCount;i++)
            {
              sessions.add(bigEndianToInt(buffer, sessionIdBytes));
            }
            SessionList sessionList = SessionList(version: sessionListVersion, sessions: sessions);
            chatsManager.sessionListsCache[userId] = sessionList;
        }
        result.add((userId,MessageResponseCode.fromId(responseCode)));
    }
    CallbackNotifiers.messageResponse.notify(MessageResponseEvent(result: result));

    return true;
  }
}
