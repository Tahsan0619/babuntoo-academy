import 'package:flutter/material.dart';
import '../services/applink_api_service.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageWithAPI extends StatefulWidget {
  const LoginPageWithAPI({Key? key}) : super(key: key);

  @override
  State<LoginPageWithAPI> createState() => _LoginPageWithAPIState();
}

class _LoginPageWithAPIState extends State<LoginPageWithAPI> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  
  bool isOTPSent = false;
  bool isLoading = false;
  String? errorMessage;
  String? successMessage;
  bool useTestMode = false; // Set to false to use real API

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  Future<void> requestOTP() async {
    if (phoneController.text.isEmpty) {
      setState(() => errorMessage = 'Please enter phone number');
      return;
    }

    // Validate phone number format
    if (!phoneController.text.startsWith('+88') && !phoneController.text.startsWith('88')) {
      setState(() => errorMessage = 'Phone must start with +88 or 88');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
    });

    try {
      final phone = phoneController.text.startsWith('+88') 
          ? phoneController.text 
          : '+88${phoneController.text}';

      final response = useTestMode
          ? await ApplinkApiService.testRequestOTP(msisdn: phone)
          : await ApplinkApiService.requestOTP(
              msisdn: phone,
              shortCode: ApplinkApiService.defaultShortCode,
            );

      if (response['success']) {
        setState(() {
          isOTPSent = true;
          successMessage = response['message'] ?? 'OTP sent successfully';
          if (useTestMode && response['data'] != null) {
            successMessage = (successMessage ?? '') + '\n\n🧪 Test OTP: ${response['data']['testOTP']}';
          }
        });
      } else {
        setState(() => errorMessage = response['error'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      setState(() => errorMessage = 'Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> verifyOTPAndLogin() async {
    if (otpController.text.isEmpty) {
      setState(() => errorMessage = 'Please enter OTP');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
    });

    try {
      final phone = phoneController.text.startsWith('+88') 
          ? phoneController.text 
          : '+88${phoneController.text}';

      final response = useTestMode
          ? await ApplinkApiService.testVerifyOTP(
              msisdn: phone,
              otpCode: otpController.text,
            )
          : await ApplinkApiService.verifyOTP(
              msisdn: phone,
              otpCode: otpController.text,
              shortCode: ApplinkApiService.defaultShortCode,
            );

      if (response['success']) {
        // Save phone number and token to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userPhone', phone);
        await prefs.setString('userToken', response['data']['token'] ?? '');
        await prefs.setBool('isLoggedIn', true);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful!')),
          );
          // Navigate to home page
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        setState(() => errorMessage = response['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      setState(() => errorMessage = 'Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Logo/Title
            const Text(
              'Babuntoo Academy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Secure OTP-Based Login',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Mode Toggle
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: useTestMode ? Colors.orange[50] : Colors.green[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: useTestMode ? Colors.orange : Colors.green,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    useTestMode ? '🧪 Test Mode' : '🔗 Live Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: useTestMode ? Colors.orange[900] : Colors.green[900],
                    ),
                  ),
                  Switch(
                    value: useTestMode,
                    onChanged: isLoading ? null : (value) {
                      setState(() => useTestMode = value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Phone Number Input
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: '+8801234567890 or 8801234567890',
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: errorMessage != null && !isOTPSent ? errorMessage : null,
              ),
              enabled: !isOTPSent && !isLoading,
            ),
            const SizedBox(height: 16),

            // OTP Input (shown after OTP is sent)
            if (isOTPSent) ...[
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  hintText: '123456',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  counterText: '',
                ),
                enabled: !isLoading,
              ),
              const SizedBox(height: 16),
            ],

            // Error Message
            if (errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red[300]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    ),
                  ],
                ),
              ),
            if (errorMessage != null) const SizedBox(height: 16),

            // Success Message
            if (successMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[300]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.green[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        successMessage!,
                        style: TextStyle(color: Colors.green[700]),
                      ),
                    ),
                  ],
                ),
              ),
            if (successMessage != null) const SizedBox(height: 16),

            // Main Action Button
            ElevatedButton(
              onPressed: isLoading ? null : (isOTPSent ? verifyOTPAndLogin : requestOTP),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
                disabledBackgroundColor: Colors.grey[300],
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      isOTPSent ? 'Verify & Login' : 'Send OTP',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 12),

            // Reset Button (if OTP is sent)
            if (isOTPSent)
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        setState(() {
                          isOTPSent = false;
                          otpController.clear();
                          errorMessage = null;
                          successMessage = null;
                        });
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.grey[400],
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account? '),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

