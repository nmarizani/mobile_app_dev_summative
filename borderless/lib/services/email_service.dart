import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  static final EmailService _instance = EmailService._internal();
  factory EmailService() => _instance;
  EmailService._internal();

  // Replace these with your actual email credentials
  final String _username = 'your-email@gmail.com';
  final String _password = 'your-app-specific-password';
  final String _smtpServer = 'smtp.gmail.com';
  final int _smtpPort = 587;

  Future<bool> sendVerificationCode(String toEmail) async {
    try {
      // Generate a 6-digit code
      final code = (100000 + Random().nextInt(900000)).toString();

      // Create SMTP server
      final smtpServer = SmtpServer(
        _smtpServer,
        port: _smtpPort,
        username: _username,
        password: _password,
        ssl: false,
      );

      // Create message
      final message = Message()
        ..from = Address(_username, 'Borderless')
        ..recipients.add(toEmail)
        ..subject = 'Your Verification Code'
        ..html = '''
          <h2>Your Verification Code</h2>
          <p>Please use the following code to verify your account:</p>
          <h1 style="color: #21D4B4; font-size: 32px; letter-spacing: 5px;">$code</h1>
          <p>This code will expire in 10 minutes.</p>
          <p>If you didn't request this code, please ignore this email.</p>
        ''';

      // Send message
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');

      // Store the code temporarily (in a real app, you would store this in a database)
      _verificationCodes[toEmail] = code;

      return true;
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }

  // Temporary storage for verification codes (replace with database in production)
  final Map<String, String> _verificationCodes = {};

  bool verifyCode(String email, String code) {
    final storedCode = _verificationCodes[email];
    if (storedCode == code) {
      _verificationCodes.remove(email); // Remove used code
      return true;
    }
    return false;
  }
}
