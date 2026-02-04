import 'package:flutter/cupertino.dart';
import 'package:zchat/views/data_classes/pages/settings/dialog_option_data.dart';
import '../../../data_classes/pages/settings/settings_radio_group_dialog_button_data.dart';

// TODO make values parts of the prompt

final List<SettingsRadioGroupDialogButtonData<String>> personalityWidgetsData =
    [
      SettingsRadioGroupDialogButtonData<String>(
        label: 'Style & Tone',
        icon: '🎨',
        dialogOptions: [
          DialogOptionData(value: 'formal', displayText: 'Formal'),
          DialogOptionData(value: 'balanced', displayText: 'Balanced'),
          DialogOptionData(value: 'casual', displayText: 'Casual'),
          DialogOptionData(value: 'friendly', displayText: 'Friendly'),
          DialogOptionData(value: 'playful', displayText: 'Playful'),
        ],
        dialogTitle: 'Style & Tone',
        valueNotifier: ValueNotifier('balanced'),
      ),
      SettingsRadioGroupDialogButtonData<String>(
        label: 'Emotion Level',
        icon: '❤️',
        dialogOptions: [
          DialogOptionData(value: 'calm', displayText: 'calm'),
          DialogOptionData(value: 'neutral', displayText: 'neutral'),
          DialogOptionData(value: 'expressive', displayText: 'expressive'),
        ],
        dialogTitle: 'Emotion Level',
        valueNotifier: ValueNotifier('neutral'),
      ),
      SettingsRadioGroupDialogButtonData<String>(
        label: 'Creativity Level',
        icon: '✨',
        dialogOptions: [
          DialogOptionData(value: 'low', displayText: 'low'),
          DialogOptionData(value: 'medium', displayText: 'medium'),
          DialogOptionData(value: 'high', displayText: 'high'),
        ],
        dialogTitle: 'Creativity Level',
        valueNotifier: ValueNotifier('medium'),
      ),
      SettingsRadioGroupDialogButtonData<String>(
        label: 'Interaction Frequency',
        icon: '⚡',
        dialogOptions: [
          DialogOptionData(value: 'minimal', displayText: 'minimal'),
          DialogOptionData(value: 'verbose', displayText: 'verbose'),
        ],
        dialogTitle: 'Interaction Frequency',
        valueNotifier: ValueNotifier('minimal'),
      ),
    ];

final List<Map<String, dynamic>> personalitySwitchesData = [
  {
    'label': 'Use Slang',
    'helpText': 'Enable the AI to use casual or slang language.',
    'icon': '🗣️',
  },
  {
    'label': 'Show Empathy',
    'helpText': 'AI responds with empathetic messages.',
    'icon': '💖',
  },
  {
    'label': 'Creative Mode',
    'helpText': 'AI provides more imaginative responses.',
    'icon': '✨',
  },
  {
    'label': 'Be Concise',
    'helpText': 'AI provides shorter and to-the-point answers.',
    'icon': '✂️',
  },
  {
    'label': 'Technical',
    'helpText': 'AI prefers precise and technical responses.',
    'icon': '🛠️',
  },
];
