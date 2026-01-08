import 'package:core_ui_kit/core_ui_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Kit Gallery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          error: Colors.redAccent,
        ),
        useMaterial3: true,
      ),
      home: const ButtonGalleryPage(),
    );
  }
}

class ButtonGalleryPage extends StatelessWidget {
  const ButtonGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Kit Gallery')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSection(
                  title: 'Primary Button',
                  description: 'Main call to action',
                  children: [
                    KitPrimaryButton(
                      onPressed: () {},
                      child: const Text('Get Started'),
                    ),
                    const SizedBox(height: 10),
                    KitPrimaryButton(
                      onPressed: null,
                      child: const Text('Disabled'),
                    ),
                  ],
                ),
                
                const Divider(height: 40),
            
                _buildSection(
                  title: 'Secondary Button',
                  description: 'Alternative actions',
                  children: [
                    KitSecondaryButton(
                      onPressed: () {},
                      child: const Text('Learn More'),
                    ),
                  ],
                ),
            
                const Divider(height: 40),
            
                _buildSection(
                  title: 'Destructive Button',
                  description: 'Dangerous actions',
                  children: [
                    KitDestructiveButton(
                      onPressed: () {},
                      child: const Text('Delete Account'),
                    ),
                    const SizedBox(height: 10),
                    KitDestructiveButton(
                      onPressed: () {},
                      outlined: true,
                      child: const Text('Remove Item'),
                    ),
                  ],
                ),
            
                const Divider(height: 40),
            
                _buildSection(
                  title: 'App Icon Button',
                  description: 'Standardized Icon Actions',
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KitIconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.settings),
                          tooltip: 'Settings',
                        ),
                        const SizedBox(width: 16),
                        KitIconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.close),
                          backgroundColor: Colors.grey.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                  ],
                ),
            
                const Divider(height: 40),
            
                _buildSection(
                  title: 'Social Button',
                  description: 'Authentication Providers',
                  children: [
                    KitSocialButton(
                      brand: SocialBrand.google,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    KitSocialButton(
                      brand: SocialBrand.apple,
                      onPressed: () {},
                    ),
                     const SizedBox(height: 12),
                    KitSocialButton(
                      brand: SocialBrand.facebook,
                      onPressed: () {},
                    ),
                  ],
                ),
            
                const Divider(height: 40),
            
                _buildSection(
                  title: 'Link Button',
                  description: 'Inline text actions',
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        KitLinkButton(
                          onPressed: () {},
                          text: 'Sign up',
                        ),
                      ],
                    ),
                  ],
                ),
            
                const Divider(height: 40),
                
                 _buildSection(
                  title: 'Outline & Ghost',
                  description: 'Lower emphasis',
                  children: [
                    KitOutlineButton(
                      onPressed: () {},
                      child: const Text('View Details'),
                    ),
                    const SizedBox(height: 10),
                    KitGhostButton(
                      onPressed: () {},
                      child: const Text('Skip for now'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required List<Widget> children,
  }) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(description, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}
