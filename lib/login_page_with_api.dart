import 'package:flutter/material.dart';
import '../services/applink_api_service.dart';
import '../utils/constants.dart';

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
  bool useTestMode = true; // Toggle to test without actual API

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  // Request OTP
  Future<void> requestOTP() async {
    if (phoneController.text.isEmpty) {
      setState(() => errorMessage = 'Please enter phone number');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
    });

    try {
      final response = useTestMode
          ? await ApplinkApiService.testRequestOTP(msisdn: phoneController.text)
          : await ApplinkApiService.requestOTP(
              msisdn: phoneController.text,
              shortCode: '1234', // Replace with actual short code
            );

      if (response['success']) {
        setState(() {
          isOTPSent = true;
          successMessage = response['message'];
          if (useTestMode) {
            successMessage += '\n\nTest OTP: ${response['data']['testOTP']}';
          }
        });
      } else {
        setState(() => errorMessage = response['error']);
      }
    } catch (e) {
      setState(() => errorMessage = 'Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Verify OTP and Login
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
      final response = useTestMode
          ? await ApplinkApiService.testVerifyOTP(
              msisdn: phoneController.text,
              otpCode: otpController.text,
            )
          : await ApplinkApiService.verifyOTP(
              msisdn: phoneController.text,
              otpCode: otpController.text,
              shortCode: '1234', // Replace with actual short code
            );

      if (response['success']) {
        setState(() {
          successMessage = 'Login successful!';
        });
        
        // Navigate to home page or next screen
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful!')),
          );
          // Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        setState(() => errorMessage = response['message']);
      }
    } catch (e) {
      setState(() => errorMessage = 'Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Test SMS sending
  Future<void> testSendSMS() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
    });

    try {
      final response = useTestMode
          ? await ApplinkApiService.testSendSMS(
              phoneNumber: phoneController.text,
              message: 'Welcome to Babuntoo Academy!',
            )
          : await ApplinkApiService.sendSMS(
              phoneNumber: phoneController.text,
              message: 'Welcome to Babuntoo Academy!',
            );

      if (response['success']) {
        setState(() => successMessage = '✅ ${response['message']}');
      } else {
        setState(() => errorMessage = response['error']);
      }
    } catch (e) {
      setState(() => errorMessage = 'Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Test subscription
  Future<void> testSubscription(String action) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
    });

    try {
      final response = useTestMode
          ? await ApplinkApiService.testSubscription(
              msisdn: phoneController.text,
              action: action,
            )
          : await ApplinkApiService.userSubscription(
              msisdn: phoneController.text,
              subscriptionType: 'DAILY',
              action: action,
              shortCode: '1234', // Replace with actual short code
            );

      if (response['success']) {
        setState(() => successMessage = '✅ ${response['message']}');
      } else {
        setState(() => errorMessage = response['error']);
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
        title: const Text('Login with Applink API'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mode Indicator
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: useTestMode ? Colors.orange[100] : Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    useTestMode ? '🧪 TEST MODE' : '🔗 PRODUCTION MODE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: useTestMode ? Colors.orange[900] : Colors.green[900],
                    ),
                  ),
                  Switch(
                    value: useTestMode,
                    onChanged: (value) {
                      setState(() => useTestMode = value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              'Applink API Integration Demo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Phone Number Input
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: '+8801234567890',
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              enabled: !isOTPSent && !isLoading,
            ),
            const SizedBox(height: 16),

            // OTP Input (shown after OTP is sent)
            if (isOTPSent) ...[
              TextField(
                controller: otpController,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  hintText: '123456',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red[900]),
                ),
              ),
            if (errorMessage != null) const SizedBox(height: 16),

            // Success Message
            if (successMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  successMessage!,
                  style: TextStyle(color: Colors.green[900]),
                ),
              ),
            if (successMessage != null) const SizedBox(height: 16),

            // Main Login Button
            ElevatedButton(
              onPressed: isLoading ? null : (isOTPSent ? verifyOTPAndLogin : requestOTP),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
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
                      isOTPSent ? 'Verify OTP & Login' : 'Request OTP',
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
                  backgroundColor: Colors.grey,
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
            const Divider(),
            const SizedBox(height: 24),

            // SMS API Test Section
            const Text(
              'SMS API Test',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Test SMS sending capability',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: isLoading || phoneController.text.isEmpty ? null : testSendSMS,
              icon: const Icon(Icons.sms),
              label: const Text('Send Test SMS'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.purple,
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),

            // Subscription API Test Section
            const Text(
              'Subscription API Test',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Test subscription/unsubscription',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLoading || phoneController.text.isEmpty
                        ? null
                        : () => testSubscription('subscribe'),
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Subscribe'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLoading || phoneController.text.isEmpty
                        ? null
                        : () => testSubscription('unsubscribe'),
                    icon: const Icon(Icons.cancel),
                    label: const Text('Unsubscribe'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // API Documentation Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '📚 API Integration Features',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '✅ SMS Sending\n'
                    '✅ SMS Receiving\n'
                    '✅ SMS Delivery Reports\n'
                    '✅ OTP Request & Verification\n'
                    '✅ User Subscription Management\n'
                    '✅ Subscriber Notifications\n'
                    '✅ Base Size Query',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
