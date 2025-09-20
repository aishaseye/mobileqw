class AppConstants {
  // API Configuration
  static const String baseUrl = 'http://localhost:8000/api';
  static const String apiVersion = 'v1';

  // Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String feedbackEndpoint = '/feedback';
  static const String companiesEndpoint = '/companies';
  static const String servicesEndpoint = '/services';
  static const String employeesEndpoint = '/employees';
  static const String rewardsEndpoint = '/rewards';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String companyKey = 'company_data';

  // App Configuration
  static const String appName = 'QualyWatch';
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png'];
  static const List<String> supportedVideoFormats = ['mp4', 'avi', 'mov'];
  static const List<String> supportedAudioFormats = ['mp3', 'wav', 'aac'];

  // Validation
  static const int minPasswordLength = 6;
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 1000;

  // QR Code
  static const String qrCodePrefix = 'qualywatch://';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Font families
  static const String coinyFont = 'Coiny';
  static const String courgetteFont = 'Courgette';
  static const String urbanistFont = 'Urbanist';

  // Typography usage guidelines
  // Coiny: Fun, playful headers and titles
  // Courgette: Decorative text, special messages
  // Urbanist: Body text, UI elements, clean reading
}