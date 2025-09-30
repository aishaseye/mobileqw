import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qualywatchmobile/core/constants/app_assets.dart';
import 'package:qualywatchmobile/core/constants/app_colors.dart';
import 'package:qualywatchmobile/core/constants/app_fonts.dart';
import 'package:qualywatchmobile/presentation/widgets/custom_textfield.dart';

class RegisterPage0Vertical extends StatefulWidget {
  const RegisterPage0Vertical({Key? key}) : super(key: key);

  @override
  State<RegisterPage0Vertical> createState() => _RegisterPage0VerticalState();
}

class _RegisterPage0VerticalState extends State<RegisterPage0Vertical>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  // Form keys
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  // Step 1 - Manager data
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Step 2 - Company data
  final _nomEntrepriseController = TextEditingController();
  final _emailEntrepriseController = TextEditingController();
  final _phoneEntrepriseController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateCreationController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedCategory;
  String? _selectedEmployeeRange;

  // Step 3 - Photos
  File? _companyPhoto;
  File? _managerLogo;
  final ImagePicker _picker = ImagePicker();

  int _currentStep = 0;
  double _scrollProgress = 0.0;
  bool _isLoading = false;

  late AnimationController _fadeController;
  late AnimationController _slideController;

  final List<String> _categories = [
    'Restaurant',
    'Hôtel',
    'Café',
    'Commerce',
    'Service',
    'Technologie',
    'Santé',
    'Éducation',
    'Autre',
  ];

  final List<String> _employeeRanges = [
    '1-10',
    '11-50',
    '51-100',
    '101-500',
    '500+',
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scrollController.addListener(_onScroll);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nomEntrepriseController.dispose();
    _emailEntrepriseController.dispose();
    _phoneEntrepriseController.dispose();
    _descriptionController.dispose();
    _dateCreationController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    setState(() {
      _scrollProgress = maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;

      // Determine current step based on scroll position
      if (currentScroll < maxScroll * 0.33) {
        _currentStep = 0;
      } else if (currentScroll < maxScroll * 0.66) {
        _currentStep = 1;
      } else {
        _currentStep = 2;
      }
    });
  }

  void _scrollToStep(int step) {
    double targetScroll = 0;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (step == 0) {
      targetScroll = 0;
    } else if (step == 1) {
      targetScroll = maxScroll * 0.33;
    } else if (step == 2) {
      targetScroll = maxScroll * 0.66;
    }

    _scrollController.animateTo(
      targetScroll,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _nextStep() async {
    if (_currentStep == 0) {
      if (_formKey1.currentState!.validate()) {
        _scrollToStep(1);
      }
    } else if (_currentStep == 1) {
      if (_formKey2.currentState!.validate()) {
        if (_selectedCategory == null || _selectedEmployeeRange == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Veuillez remplir tous les champs')),
          );
          return;
        }
        _scrollToStep(2);
      }
    } else {
      await _handleSubmit();
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateCreationController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

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
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  void _showImageSourceDialog({required bool isCompanyPhoto}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Choisir une source',
              style: AppFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            _buildSourceOption(
              icon: Icons.collections_rounded,
              title: 'Galerie',
              onTap: () {
                Navigator.pop(context);
                _pickImage(isCompanyPhoto: isCompanyPhoto);
              },
            ),
            _buildSourceOption(
              icon: Icons.photo_camera_rounded,
              title: 'Appareil photo',
              onTap: () {
                Navigator.pop(context);
                // _takePhoto(isCompanyPhoto: isCompanyPhoto);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: AppFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
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

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✨ Inscription réussie!'),
          backgroundColor: Colors.green,
        ),
      );

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
      body: SafeArea(
        child: Column(
          children: [
            // Header avec progress
            _buildHeader(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildStep1(),
                    _buildDivider(),
                    _buildStep2(),
                    _buildDivider(),
                    _buildStep3(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Floating action button
            _buildFloatingButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, size: 24),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.logo,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Inscription',
                      style: AppFonts.luckiestGuy(
                        fontSize: 20,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48), // Pour équilibrer le back button
            ],
          ),
          const SizedBox(height: 16),
          // Animated progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (_currentStep + _scrollProgress.clamp(0, 0.33)) / 3,
              backgroundColor: AppColors.lightGrey,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.grey.withOpacity(0.3))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.arrow_downward_rounded,
              color: AppColors.grey.withOpacity(0.5),
              size: 20,
            ),
          ),
          Expanded(child: Divider(color: AppColors.grey.withOpacity(0.3))),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return FadeTransition(
      opacity: _fadeController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _fadeController,
          curve: Curves.easeOut,
        )),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vos Informations',
                  style: AppFonts.luckiestGuy(
                    fontSize: 28,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Créez votre profil gérant',
                  style: AppFonts.urbanist(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 32),

                CustomTextField(
                  label: 'Nom',
                  hintText: 'Entrez votre nom',
                  prefixIcon: Icons.badge_outlined,
                  controller: _nomController,
                  validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Prénom',
                  hintText: 'Entrez votre prénom',
                  prefixIcon: Icons.badge_outlined,
                  controller: _prenomController,
                  validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Téléphone',
                  hintText: '+33 6 00 00 00 00',
                  prefixIcon: Icons.phone_iphone_rounded,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Email',
                  hintText: 'votre@email.com',
                  prefixIcon: Icons.alternate_email_rounded,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v?.isEmpty ?? true) return 'Requis';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v!)) {
                      return 'Email invalide';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Mot de passe',
                  hintText: '••••••••',
                  prefixIcon: Icons.lock_open_rounded,
                  controller: _passwordController,
                  isPassword: true,
                  validator: (v) {
                    if (v?.isEmpty ?? true) return 'Requis';
                    if (v!.length < 6) return 'Min 6 caractères';
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Confirmer mot de passe',
                  hintText: '••••••••',
                  prefixIcon: Icons.lock_rounded,
                  controller: _confirmPasswordController,
                  isPassword: true,
                  validator: (v) {
                    if (v?.isEmpty ?? true) return 'Requis';
                    if (v != _passwordController.text) {
                      return 'Mots de passe différents';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep2() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Votre Entreprise',
              style: AppFonts.luckiestGuy(
                fontSize: 28,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Parlez-nous de votre établissement',
              style: AppFonts.urbanist(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 32),

            CustomTextField(
              label: 'Nom entreprise',
              hintText: 'Le nom de votre entreprise',
              prefixIcon: Icons.business_center_rounded,
              controller: _nomEntrepriseController,
              validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
            ),

            const SizedBox(height: 16),

            CustomTextField(
              label: 'Email entreprise',
              hintText: 'contact@entreprise.com',
              prefixIcon: Icons.alternate_email_rounded,
              controller: _emailEntrepriseController,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
            ),

            const SizedBox(height: 16),

            CustomTextField(
              label: 'Téléphone',
              hintText: '+33 1 00 00 00 00',
              prefixIcon: Icons.call_rounded,
              controller: _phoneEntrepriseController,
              keyboardType: TextInputType.phone,
              validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
            ),

            const SizedBox(height: 24),

            Text(
              'Catégorie',
              style: AppFonts.urbanist(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ] : [],
                    ),
                    child: Text(
                      cat,
                      style: AppFonts.urbanist(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            Text(
              'Nombre d\'employés',
              style: AppFonts.urbanist(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _employeeRanges.map((range) {
                final isSelected = _selectedEmployeeRange == range;
                return GestureDetector(
                  onTap: () => setState(() => _selectedEmployeeRange = range),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ] : [],
                    ),
                    child: Text(
                      range,
                      style: AppFonts.urbanist(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            CustomTextField(
              label: 'Description',
              hintText: 'Décrivez votre activité...',
              prefixIcon: Icons.article_rounded,
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
            ),

            const SizedBox(height: 16),

            CustomTextField(
              label: 'Date de création',
              hintText: 'JJ/MM/AAAA',
              prefixIcon: Icons.event_rounded,
              controller: _dateCreationController,
              readOnly: true,
              onTap: _selectDate,
              validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
            ),

            const SizedBox(height: 16),

            CustomTextField(
              label: 'Localisation',
              hintText: 'Ville, Pays',
              prefixIcon: Icons.place_rounded,
              controller: _locationController,
              validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep3() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Photos & Logo',
            style: AppFonts.luckiestGuy(
              fontSize: 28,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Ajoutez une touche visuelle',
            style: AppFonts.urbanist(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 32),

          _buildPhotoCard(
            title: 'Photo entreprise',
            subtitle: 'Photo de votre établissement',
            icon: Icons.storefront_rounded,
            color: const Color(0xFFFF9800),
            image: _companyPhoto,
            onTap: () => _showImageSourceDialog(isCompanyPhoto: true),
            onRemove: () => setState(() => _companyPhoto = null),
          ),

          const SizedBox(height: 20),

          _buildPhotoCard(
            title: 'Logo gérant',
            subtitle: 'Votre photo de profil',
            icon: Icons.account_circle_rounded,
            color: AppColors.primary,
            image: _managerLogo,
            onTap: () => _showImageSourceDialog(isCompanyPhoto: false),
            onRemove: () => setState(() => _managerLogo = null),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required File? image,
    required VoidCallback onTap,
    required VoidCallback onRemove,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: image != null ? color : AppColors.grey.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (image != null ? color : Colors.black).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: AppFonts.urbanist(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (image != null)
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.red),
                      onPressed: onRemove,
                    ),
                ],
              ),
            ),
            if (image != null)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                child: Image.file(
                  image,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.05),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_rounded,
                        color: color.withOpacity(0.4),
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ajouter',
                        style: AppFonts.urbanist(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: color.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 56,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _nextStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shadowColor: AppColors.primary.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentStep == 2 ? 'Terminer ' : 'Continuer',
                        style: AppFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (_currentStep < 2) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}