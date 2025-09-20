abstract class Failure {
  const Failure([this.message]);
  final String? message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

// Authentication failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure([super.message]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message]);
}

// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure([super.message]);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure([super.message]);
}

// QR Code failures
class QRCodeFailure extends Failure {
  const QRCodeFailure([super.message]);
}

class PermissionFailure extends Failure {
  const PermissionFailure([super.message]);
}

// File handling failures
class FileFailure extends Failure {
  const FileFailure([super.message]);
}

class FileSizeExceededFailure extends Failure {
  const FileSizeExceededFailure([super.message]);
}

class UnsupportedFileFormatFailure extends Failure {
  const UnsupportedFileFormatFailure([super.message]);
}