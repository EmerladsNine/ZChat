import '../../data_classes/settings_base_button_data.dart';

final List<SettingsBaseButtonData> personalityWidgetsData = [
  SettingsBaseButtonData(
    label: 'Style & Tone',
    onTap: () {
      // Navigate to AI style & tone selection page
    },
    icon: '🎨',
  ),
  SettingsBaseButtonData(
    label: 'Response Length',
    onTap: () {
      // Choose short, medium, long responses
    },
    icon: '📏',
  ),
  SettingsBaseButtonData(
    label: 'Preferred Topics',
    onTap: () {
      // Select topics AI prioritizes
    },
    icon: '📚',
  ),
  SettingsBaseButtonData(
    label: 'Emotion Level',
    onTap: () {
      // Choose calm, neutral, expressive
    },
    icon: '❤️',
  ),
  SettingsBaseButtonData(
    label: 'Knowledge Depth',
    onTap: () {
      // Select AI knowledge level
    },
    icon: '🧠',
  ),
  SettingsBaseButtonData(
    label: 'Creativity Level',
    onTap: () {
      // Low, medium, high creativity
    },
    icon: '✨',
  ),
  SettingsBaseButtonData(
    label: 'Interaction Frequency',
    onTap: () {
      // Verbose or minimal responses
    },
    icon: '⚡',
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
    'label': 'Humor Mode',
    'helpText': 'AI can add humor when responding.',
    'icon': '😂',
  },
  {
    'label': 'Friendly',
    'helpText': 'AI uses warm and friendly language.',
    'icon': '🤝',
  },
  {
    'label': 'Technical',
    'helpText': 'AI prefers precise and technical responses.',
    'icon': '🛠️',
  },
];
