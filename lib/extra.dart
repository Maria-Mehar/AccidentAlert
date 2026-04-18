import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool automaticDetection = true;
  bool soundAlert = true;
  bool vibration = true;
  double sensitivity = 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SETTINGS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSectionTitle('EMERGENCY CONTACTS'),
          _buildNavTile('Manage Contacts'),
          _buildNavTile('Edit Emergency Message'),

          const SizedBox(height: 10),
          _buildSectionTitle('DETECTION SETTINGS'),
          SwitchListTile(
            title: const Text('Automatic Detection'),
            value: automaticDetection,
            onChanged: (val) => setState(() => automaticDetection = val),
          ),
          ListTile(
            title: const Text('Sensitivity Level'),
            subtitle: Slider(
              value: sensitivity,
              onChanged: (val) => setState(() => sensitivity = val),
            ),
          ),

          const SizedBox(height: 10),
          _buildSectionTitle('ALERT OPTIONS'),
          SwitchListTile(
            title: const Text('Sound Alert'),
            value: soundAlert,
            onChanged: (val) => setState(() => soundAlert = val),
          ),
          SwitchListTile(
            title: const Text('Vibration'),
            value: vibration,
            onChanged: (val) => setState(() => vibration = val),
          ),

          const SizedBox(height: 10),
          _buildSectionTitle('LOCATION'),
          _buildNavTile('Update Home Location'),
          _buildNavTile('Privacy Policy'),

          const SizedBox(height: 10),
          _buildSectionTitle('ACCOUNT'),
          _buildNavTile('Change Password'),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildNavTile(String title) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
