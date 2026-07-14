abstract final class ApiEndpoints {
  static const baseUrl = 'https://webinar-api.webinar.gg/api/';
  static const requestOtp = 'auth/request-otp';
  static const verifyOtp = 'auth/verify-otp';
  static const createAccount = 'auth/create-account';
  static const updateProfile = 'user/profile';
  static const updateAvatar = 'user/avatar';
}

abstract final class ApiConstants {
  static const sessionCookieName = 'connect.sid';
  static final apiUri = Uri.parse(ApiEndpoints.baseUrl);
  static final originUri = Uri.parse('https://webinar-api.webinar.gg/');
}