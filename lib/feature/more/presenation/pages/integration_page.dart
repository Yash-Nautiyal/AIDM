import 'package:aidm/core/constant/app_dimensions.dart';
import 'package:aidm/core/theme/app_theme_extension.dart';
import 'package:aidm/core/theme/typography/app_typography_extension.dart';
import 'package:aidm/core/widgets/app_bar/app_appbar.dart';
import 'package:aidm/feature/more/presenation/widgets/integration/api_tokens_card.dart';
import 'package:aidm/feature/more/presenation/widgets/integration/webhook_url_card.dart';
import 'package:flutter/material.dart';

class IntegrationPage extends StatefulWidget {
  const IntegrationPage({super.key});

  @override
  State<IntegrationPage> createState() => _IntegrationPageState();
}

class _IntegrationPageState extends State<IntegrationPage> {
  static const _webhookUrl = 'https://your-server.com/webhooks';

  String? _apiToken;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _createToken() {
    if (_apiToken != null) {
      _showMessage('Only one token is allowed at a time');
      return;
    }

    setState(() {
      _apiToken = 'aidm_live_••••••••••••••••4f2a';
    });
    _showMessage('API token created');
  }

  void _openDocs() {
    _showMessage('API & Integration docs');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppThemeExtension>()!;
    final typography = Theme.of(context).extension<AppTypographyExtension>()!;

    return Scaffold(
      backgroundColor: theme.backgroundPage,
      appBar: const AppAppBar(title: 'Integration', showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppDimensions.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Develop Settings',
                style: typography.h3.copyWith(color: theme.textPrimary),
              ),
              SizedBox(height: AppDimensions.spacingVerticalSm),
              Text(
                'API tokens and webhook URL for integrating with your '
                'workflows.',
                style: typography.bodyMedium.copyWith(
                  color: theme.textSecondary,
                ),
              ),
              SizedBox(height: AppDimensions.spacingVertical2xl),
              ApiTokensCard(
                token: _apiToken,
                onCreateToken: _createToken,
              ),
              SizedBox(height: AppDimensions.spacingVerticalLg),
              WebhookUrlCard(
                url: _webhookUrl,
                onOpenDocs: _openDocs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
