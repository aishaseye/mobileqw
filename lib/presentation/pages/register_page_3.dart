import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qualywatchmobile/core/constants/app_assets.dart';
import 'package:qualywatchmobile/core/constants/app_colors.dart';
import 'package:qualywatchmobile/core/constants/app_fonts.dart';

class RegisterPage3 extends StatefulWidget {
  final Map<String, dynamic> managerData;
  final Map<String, dynamic> companyData;

  const RegisterPage3({
    Key? key,
    required this.managerData,
    required this.companyData,
  }) : super(key: key);

  @override
  State<RegisterPage3> createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {
  File? _companyPhoto;
  File? _managerLogo;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage({required bool isCompanyPhoto}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1200,
      );

      if (image != null) {
        setState(() {
          if (isCompanyPhoto) {
            _companyPhoto = File(image.path);
          } else {
            _managerLogo = File(image.path);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la sélection: $e')),
      );
    }
  }

  Future<void> _takePhoto({required bool isCompanyPhoto}) async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1200,
      );

      if (photo != null) {
        setState(() {
          if (isCompanyPhoto) {
            _companyPhoto = File(photo.path);
          } else {
            _managerLogo = File(photo.path);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la prise de photo: $e')),
      );
    }
  }

  void _showImageSourceDialog({required bool isCompanyPhoto}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choisir une source',
              style: AppFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.collections_rounded, color: AppColors.primary, size: 28),
              title: Text(
                'Galerie',
                style: AppFonts.urbanist(fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(isCompanyPhoto: isCompanyPhoto);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_rounded, color: AppColors.primary, size: 28),
              title: Text(
                'Appareil photo',
                style: AppFonts.urbanist(fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                _takePhoto(isCompanyPhoto: isCompanyPhoto);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_companyPhoto == null || _managerLogo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez ajouter les deux photos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Implement actual registration logic
    print('Manager Data: ${widget.managerData}');
    print('Company Data: ${widget.companyData}');
    print('Company Photo: ${_companyPhoto?.path}');
    print('Manager Logo: ${_managerLogo?.path}');

    setState(() {
      _isLoading = false;
    });

    // Navigate to success screen or home
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inscription réussie!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to home or login
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/auth/login',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                 // Logo
                Image.asset(
                  AppAssets.logo,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 16),

                // Title
                Text(
                  'Photos',
                  style: AppFonts.luckiestGuy(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'Étape 3/3',
                  style: AppFonts.urbanist(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 8),

                // Progress indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProgressDot(number: 1, isActive: true),
                    _buildProgressLine(isActive: true),
                    _buildProgressDot(number: 2, isActive: true),
                    _buildProgressLine(isActive: true),
                    _buildProgressDot(number: 3, isActive: true),
                  ],
                ),

                const SizedBox(height: 32),

                // Description
                Text(
                  'Ajoutez une photo de votre entreprise et votre logo',
                  style: AppFonts.urbanist(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Photo cards in row
                Row(
                  children: [
                    Expanded(
                      child: _buildPhotoUploadCard(
                        title: 'Photo entreprise',
                        icon: Icons.storefront_rounded,
                        image: _companyPhoto,
                        onTap: () => _showImageSourceDialog(isCompanyPhoto: true),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildPhotoUploadCard(
                        title: 'Logo gérant',
                        icon: Icons.account_circle_rounded,
                        image: _managerLogo,
                        onTap: () => _showImageSourceDialog(isCompanyPhoto: false),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Bouton Terminer
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledBackgroundColor: AppColors.grey,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Terminer',
                            style: AppFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoUploadCard({
    required String title,
    required IconData icon,
    required File? image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: image != null ? AppColors.primary : AppColors.primary.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: image != null
            ? Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.edit_rounded,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_rounded,
                    color: AppColors.primary,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: AppFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildProgressDot({required int number, required bool isActive}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.primary : Colors.white,
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.grey,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '$number',
          style: AppFonts.urbanist(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressLine({required bool isActive}) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? AppColors.primary : AppColors.grey,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}