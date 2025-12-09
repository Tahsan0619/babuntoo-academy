import 'package:flutter/material.dart';
import '../services/applink_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPageWithAPI extends StatefulWidget {
  const SignupPageWithAPI({Key? key}) : super(key: key);

  @override
  State<SignupPageWithAPI> createState() => _SignupPageWithAPIState();
}

class _SignupPageWithAPIState extends State<SignupPageWithAPI> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isOTPSent = false;
  bool isLoading = false;
  bool wantSubscription = true;
  String? errorMessage;
  String? successMessage;
  bool useTestMode = false; // Set to false to use real API

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    nameController.dispose();
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

  Future<void> verifyOTPAndSignup() async {
    if (otpController.text.isEmpty) {
      setState(() => errorMessage = 'Please enter OTP');
      return;
    }

    if (nameController.text.isEmpty) {
      setState(() => errorMessage = 'Please enter your name');
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

      // First verify OTP
      final verifyResponse = useTestMode
          ? await ApplinkApiService.testVerifyOTP(
              msisdn: phone,
              otpCode: otpController.text,
            )
          : await ApplinkApiService.verifyOTP(
              msisdn: phone,
              otpCode: otpController.text,
              shortCode: ApplinkApiService.defaultShortCode,
            );

      if (!verifyResponse['success']) {
        setState(() => errorMessage = verifyResponse['message'] ?? 'Invalid OTP');
        setState(() => isLoading = false);
        return;
      }

      // If subscription is enabled, process subscription
      if (wantSubscription) {
        final subResponse = useTestMode
            ? await ApplinkApiService.testSubscription(
                msisdn: phone,
                action: 'subscribe',
              )
            : await ApplinkApiService.userSubscription(
                msisdn: phone,
                subscriptionType: 'DAILY',
                action: 'subscribe',
                shortCode: ApplinkApiService.defaultShortCode,
              );

        if (!subResponse['success']) {
          setState(() => errorMessage =
              subResponse['error'] ?? 'Subscription failed, but account created');
        }
      }

      // Save user data to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', nameController.text);
      await prefs.setString('userPhone', phone);
      await prefs.setString('userToken', verifyResponse['data']['token'] ?? '');
      await prefs.setBool('isLoggedIn', true);
      await prefs.setBool('userSubscribed', wantSubscription);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully!')),
        );
        // Navigate to home page
        Navigator.of(context).pushReplacementNamed('/home');
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
        title: const Text('Sign Up'),
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
              'Create Your Account',
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

            // Full Name Input
            if (!isOTPSent) ...[
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                enabled: !isLoading,
              ),
              const SizedBox(height: 16),
            ],

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

              // Subscription Toggle
              Card(
                child: CheckboxListTile(
                  title: const Text('Subscribe to Daily Updates'),
                  subtitle: const Text('Get daily challenges and learning materials'),
                  value: wantSubscription,
                  onChanged: isLoading ? null : (value) {
                    setState(() => wantSubscription = value ?? true);
                  },
                  activeColor: Colors.blue,
                ),
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
              onPressed: isLoading ? null : (isOTPSent ? verifyOTPAndSignup : requestOTP),
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
                      isOTPSent ? 'Create Account' : 'Send OTP',
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

            // Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Login',
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
