import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_fonts.dart';
import '../widgets/notifications.dart';

class DemoNotificationsScreen extends StatelessWidget {
  const DemoNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Demo Notifications',
          style: AppFonts.appBarTitle,
        ),
        backgroundColor: AppColors.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SnackBar Section
            _SectionTitle('SnackBars'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DemoButton(
                  'Success SnackBar',
                  AppColors.success,
                  () => AppSnackBar.showSuccess(
                    context,
                    message: 'Votre action a été effectuée avec succès !',
                    actionLabel: 'Voir',
                  ),
                ),
                _DemoButton(
                  'Error SnackBar',
                  AppColors.error,
                  () => AppSnackBar.showError(
                    context,
                    message: 'Une erreur s\'est produite. Veuillez réessayer.',
                    actionLabel: 'Retry',
                  ),
                ),
                _DemoButton(
                  'Warning SnackBar',
                  AppColors.warning,
                  () => AppSnackBar.showWarning(
                    context,
                    message: 'Attention ! Cette action est irréversible.',
                  ),
                ),
                _DemoButton(
                  'Info SnackBar',
                  AppColors.info,
                  () => AppSnackBar.showInfo(
                    context,
                    message: 'Nouvelle mise à jour disponible.',
                    actionLabel: 'Télécharger',
                  ),
                ),
                _DemoButton(
                  'Custom SnackBar',
                  AppColors.primary,
                  () => AppSnackBar.showCustom(
                    context,
                    message: 'Message personnalisé avec icône custom',
                    title: 'QualyWatch',
                    color: AppColors.primary,
                    icon: const Icon(Icons.star, color: AppColors.white, size: 20),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Toast Section
            _SectionTitle('Toasts'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DemoButton(
                  'Success Toast',
                  AppColors.success,
                  () => AppToast.showSuccess(
                    context,
                    message: 'Données sauvegardées !',
                  ),
                ),
                _DemoButton(
                  'Error Toast',
                  AppColors.error,
                  () => AppToast.showError(
                    context,
                    message: 'Échec de la connexion au serveur.',
                  ),
                ),
                _DemoButton(
                  'Warning Toast',
                  AppColors.warning,
                  () => AppToast.showWarning(
                    context,
                    message: 'Batterie faible !',
                  ),
                ),
                _DemoButton(
                  'Info Toast',
                  AppColors.info,
                  () => AppToast.showInfo(
                    context,
                    message: 'Synchronisation en cours...',
                  ),
                ),
                _DemoButton(
                  'Loading Toast',
                  AppColors.textSecondary,
                  () {
                    AppToast.showLoading(context);
                    Future.delayed(const Duration(seconds: 3), () {
                      AppToast.hideLoading();
                      AppToast.showSuccess(context, message: 'Chargement terminé !');
                    });
                  },
                ),
                _DemoButton(
                  'Party Toast',
                  AppColors.primary,
                  () => AppToast.showParty(
                    context,
                    message: 'Vous avez gagné 50 KaliPoints !',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Overlay Toast Section
            _SectionTitle('Overlay Toasts'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DemoButton(
                  'Success Overlay',
                  AppColors.success,
                  () => AppOverlayToast.showSuccess(
                    context,
                    message: 'Votre feedback a été envoyé avec succès !',
                    onTap: () {
                      AppOverlayToast.hide();
                      print('Toast tapped!');
                    },
                  ),
                ),
                _DemoButton(
                  'Error Overlay',
                  AppColors.error,
                  () => AppOverlayToast.showError(
                    context,
                    message: 'Impossible de scanner le QR code.',
                  ),
                ),
                _DemoButton(
                  'Warning Overlay',
                  AppColors.warning,
                  () => AppOverlayToast.showWarning(
                    context,
                    message: 'Connexion internet instable.',
                  ),
                ),
                _DemoButton(
                  'Info Overlay',
                  AppColors.info,
                  () => AppOverlayToast.showInfo(
                    context,
                    message: 'Nouvelle récompense disponible !',
                  ),
                ),
                _DemoButton(
                  'Loading Overlay',
                  AppColors.textSecondary,
                  () {
                    AppOverlayToast.showLoading(
                      context,
                      message: 'Analyse de votre feedback...',
                    );
                    Future.delayed(const Duration(seconds: 3), () {
                      AppOverlayToast.hide();
                      AppOverlayToast.showCelebration(
                        context,
                        message: 'Analyse terminée ! +25 KaliPoints gagnés.',
                      );
                    });
                  },
                ),
                _DemoButton(
                  'Celebration',
                  AppColors.primary,
                  () => AppOverlayToast.showCelebration(
                    context,
                    message: 'Vous avez atteint le niveau Gold !',
                  ),
                ),
                _DemoButton(
                  'Floating Bubble',
                  AppColors.secondary,
                  () => AppOverlayToast.showFloatingBubble(
                    context,
                    message: 'Message flottant discret',
                    type: OverlayToastType.info,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Custom Examples
            _SectionTitle('Exemples QualyWatch'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DemoButton(
                  'QR Scanné',
                  AppColors.primary,
                  () => AppOverlayToast.show(
                    context,
                    message: 'Redirection vers le formulaire de feedback...',
                    title: 'QR Code détecté',
                    type: OverlayToastType.success,
                    customIcon: const Icon(Icons.qr_code_scanner, color: AppColors.white),
                  ),
                ),
                _DemoButton(
                  'Feedback Envoyé',
                  AppColors.success,
                  () => AppSnackBar.show(
                    message: 'Merci pour votre retour ! Vos KaliPoints ont été crédités.',
                    title: 'Feedback envoyé',
                    type: SnackBarType.success,
                    actionLabel: 'Voir mes points',
                  ),
                ),
                _DemoButton(
                  'Récompense',
                  AppColors.primary,
                  () => AppToast.showParty(
                    context,
                    message: 'Votre café gratuit vous attend au comptoir !',
                    title: '🎁 Récompense réclamée',
                  ),
                ),
                _DemoButton(
                  'Niveau Up',
                  AppColors.warning,
                  () => AppOverlayToast.showCelebration(
                    context,
                    message: 'Vous êtes maintenant niveau Silver ! Nouvelles récompenses débloquées.',
                    title: '🎉 Niveau supérieur atteint !',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () => AppOverlayToast.hide(),
              child: const Text('Masquer tous les overlays'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppFonts.coiny(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _DemoButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const _DemoButton(this.text, this.color, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: AppFonts.buttonText.copyWith(fontSize: 12),
      ),
      child: Text(text),
    );
  }
}