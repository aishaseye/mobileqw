import 'package:intl/intl.dart';

class AppUtils {
  // Date formatting
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} jour${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} heure${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'À l\'instant';
    }
  }

  // String utilities
  static String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // Validation
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phone.replaceAll(' ', ''));
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // File utilities
  static String getFileExtension(String fileName) {
    return fileName.split('.').last.toLowerCase();
  }

  static bool isImageFile(String fileName) {
    final extension = getFileExtension(fileName);
    return ['jpg', 'jpeg', 'png', 'gif'].contains(extension);
  }

  static bool isVideoFile(String fileName) {
    final extension = getFileExtension(fileName);
    return ['mp4', 'avi', 'mov', 'mkv'].contains(extension);
  }

  static bool isAudioFile(String fileName) {
    final extension = getFileExtension(fileName);
    return ['mp3', 'wav', 'aac', 'm4a'].contains(extension);
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Color utilities
  static String getInitials(String name) {
    final names = name.trim().split(' ');
    if (names.length == 1) {
      return names[0].isNotEmpty ? names[0][0].toUpperCase() : '';
    }
    return '${names.first[0]}${names.last[0]}'.toUpperCase();
  }

  // Rating utilities
  static String getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Très insatisfait';
      case 2:
        return 'Insatisfait';
      case 3:
        return 'Neutre';
      case 4:
        return 'Satisfait';
      case 5:
        return 'Très satisfait';
      default:
        return 'Non évalué';
    }
  }

  // Debug utilities
  static void debugPrint(String message) {
    print('[QualyWatch] $message');
  }
}