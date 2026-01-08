import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

class ButtonShowcaseScreen extends StatefulWidget {
  const ButtonShowcaseScreen({super.key});

  @override
  State<ButtonShowcaseScreen> createState() => _ButtonShowcaseScreenState();
}

class _ButtonShowcaseScreenState extends State<ButtonShowcaseScreen> {
  // Global controls for the showcase
  KitButtonState _globalState = KitButtonState.enabled;
  KitButtonSize _globalSize = KitButtonSize.medium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button System Showcase'),
      ),
      body: Row(
        children: [
          // Sidebar Controls
          Container(
            width: 250,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Controls", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 24),
                
                Text("State", style: Theme.of(context).textTheme.titleMedium),
                _buildRadio(KitButtonState.enabled, "Enabled"),
                _buildRadio(KitButtonState.disabled, "Disabled"),
                _buildRadio(KitButtonState.loading, "Loading"),
                
                const Divider(height: 32),
                
                Text("Size", style: Theme.of(context).textTheme.titleMedium),
                _buildSizeRadio(KitButtonSize.small, "Small"),
                _buildSizeRadio(KitButtonSize.medium, "Medium"),
                _buildSizeRadio(KitButtonSize.large, "Large"),
              ],
            ),
          ),
          
          // Main Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection("Primary Button", 
                    "Main call to action. High emphasis.",
                    KitPrimaryButton(
                      onPressed: () {},
                      state: _globalState,
                      size: _globalSize,
                      child: const Text("Primary Action"),
                    ),
                  ),
                  
                  _buildSection("Secondary Button", 
                    "Alternative action. Medium emphasis.",
                    KitSecondaryButton(
                      onPressed: () {},
                      state: _globalState,
                      size: _globalSize,
                      child: const Text("Secondary Action"),
                    ),
                  ),
                  
                  _buildSection("Destructive Button", 
                    "Delete or Remove actions. High alert.",
                    KitDestructiveButton(
                      onPressed: () {},
                      state: _globalState,
                      size: _globalSize,
                      child: const Text("Delete Account"),
                    ),
                  ),

                   _buildSection("Destructive Outline", 
                    "Less prominent destructive action.",
                    KitDestructiveButton(
                      onPressed: () {},
                      state: _globalState,
                      size: _globalSize,
                      outlined: true,
                      child: const Text("Cancel Subscription"),
                    ),
                  ),
                  
                  _buildSection("Outline Button", 
                    "Ghost button with a border.",
                    KitOutlineButton(
                      onPressed: () {},
                      state: _globalState,
                      size: _globalSize,
                      child: const Text("View Details"),
                    ),
                  ),
                  
                  _buildSection("Ghost Button", 
                    "Text only. Lowest emphasis.",
                    KitGhostButton(
                      onPressed: () {},
                      state: _globalState,
                      size: _globalSize,
                      child: const Text("Learn More"),
                    ),
                  ),

                   _buildSection("Link Button", 
                    "Hyperlink style for inline text.",
                    KitLinkButton(
                      onPressed: () {},
                      state: _globalState,
                      text: "Forgot Password?",
                    ),
                  ),

                  const Divider(height: 64),
                  Text("Icon Variants", style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 24),

                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                       KitPrimaryButton(
                        onPressed: () {},
                        leading: const Icon(Icons.add),
                        state: _globalState,
                        size: _globalSize,
                        child: const Text("Add New"),
                      ),
                      KitSecondaryButton(
                        onPressed: () {},
                        trailing: const Icon(Icons.arrow_forward),
                        state: _globalState,
                        size: _globalSize,
                        child: const Text("Next Step"),
                      ),
                      KitOutlineButton(
                        onPressed: () {},
                        leading: const Icon(Icons.settings),
                        state: _globalState,
                        size: _globalSize,
                        child: const Text("Settings"),
                      ),
                    ],
                  ),

                  const Divider(height: 64),
                  Text("Social Buttons", style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 24),
                  
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        KitSocialButton(
                          onPressed: () {}, 
                          brand: SocialBrand.google,
                          state: _globalState,
                        ),
                        const SizedBox(height: 12),
                         KitSocialButton(
                          onPressed: () {}, 
                          brand: SocialBrand.apple,
                          state: _globalState,
                        ),
                        const SizedBox(height: 12),
                         KitSocialButton(
                          onPressed: () {}, 
                          brand: SocialBrand.facebook,
                          state: _globalState,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String subtitle, Widget button) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: button,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(KitButtonState value, String label) {
    return RadioListTile<KitButtonState>(
      title: Text(label),
      value: value,
      groupValue: _globalState,
      contentPadding: EdgeInsets.zero,
      onChanged: (v) => setState(() => _globalState = v!),
    );
  }

  Widget _buildSizeRadio(KitButtonSize value, String label) {
    return RadioListTile<KitButtonSize>(
      title: Text(label),
      value: value,
      groupValue: _globalSize,
      contentPadding: EdgeInsets.zero,
      onChanged: (v) => setState(() => _globalSize = v!),
    );
  }
}
