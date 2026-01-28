import 'package:flutter/material.dart';
import 'package:zchat/views/data/app_notifiers.dart';


class DebugLogsWidget extends StatelessWidget {
   const DebugLogsWidget({super.key});

   static final List<String> appLogs = [];

   static void addLog(String text)
   {
     appLogs.add(text);
     AppNotifiers.appLogsChanged.value = true;
     AppNotifiers.appLogsChanged.value = false;
   }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ValueListenableBuilder(
        valueListenable: AppNotifiers.appLogsChanged,
        builder: (_,_,_) {
          return ListView.builder(
            itemCount: DebugLogsWidget.appLogs.length,
            itemBuilder: (context, index) {
            return  Text(DebugLogsWidget.appLogs[index]);
          },);
        }
      ),
    );
  }
}
