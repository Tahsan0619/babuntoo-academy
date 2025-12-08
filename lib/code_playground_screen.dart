import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage instance for saving the Groq API key on device. [web:130][web:132]
const _storage = FlutterSecureStorage();
const _groqKeyStorageKey =
    'YOUR_GROQ_API_KEY_HERE';

class CodePlaygroundScreen extends StatefulWidget {
  const CodePlaygroundScreen({Key? key}) : super(key: key);

  @override
  State<CodePlaygroundScreen> createState() => _CodePlaygroundScreenState();
}

class _CodePlaygroundScreenState extends State<CodePlaygroundScreen> {
  final TextEditingController _codeController = TextEditingController(
    text:
        "def greet(name):\n    return f\"Hello {name}\"\n\nprint(greet(\"World\"))",
  );
  final TextEditingController _stdinController = TextEditingController(
    text: "World",
  );

  String _selectedLanguage = 'python';
  String _executionStyle = 'explain'; // explain | run | review

  String _pureOutput = ''; // legit program output
  String _explanation = ''; // explanation text
  String _aiRecommendations = ''; // joined recommendations
  String _error = '';
  bool _isCallingGroq = false;

  String? _groqApiKey; // loaded from secure storage

  @override
  void initState() {
    super.initState();
    _initGroqKey();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _stdinController.dispose();
    super.dispose();
  }

  Future<void> _initGroqKey() async {
    final key = await _storage.read(key: _groqKeyStorageKey) ?? '';
    setState(() {
      _groqApiKey = key;
    });
  }

  Future<void> _saveGroqKey(String key) async {
    await _storage.write(key: _groqKeyStorageKey, value: key);
    setState(() {
      _groqApiKey = key;
      _error = '';
    });
  }

  Future<void> _openKeyDialog() async {
    final controller = TextEditingController(text: _groqApiKey ?? '');
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Groq API Key'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Paste your Groq secret key below.\n'
                'This will be stored securely on this device.',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Groq API Key',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final value = controller.text.trim();
                await _saveGroqKey(value);
                if (mounted) Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    controller.dispose();
  }

  Future<void> _callGroq() async {
    if (_groqApiKey == null || _groqApiKey!.isEmpty) {
      setState(() {
        _error =
            'Groq key not configured. Tap the key icon in the top bar to paste it once.';
        _pureOutput = '';
        _explanation = '';
        _aiRecommendations = '';
      });
      return;
    }

    setState(() {
      _isCallingGroq = true;
      _error = '';
      _pureOutput = '';
      _explanation = '';
      _aiRecommendations = '';
    });

    try {
      final uri = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

      final userPrompt = _buildUserPrompt();

      final body = {
        "model": "llama-3.1-8b-instant",
        "messages": [
          {
            "role": "system",
            "content": "You are an expert coding mentor.\n"
                "You must return STRICT JSON only, following the requested schema exactly."
          },
          {
            "role": "user",
            "content": userPrompt,
          },
        ],
        "temperature": 0.2,
      };

      final response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${_groqApiKey!}',
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        setState(() {
          _error = 'Groq HTTP ${response.statusCode}: ${response.reasonPhrase}';
        });
        return;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final choices = data['choices'] as List<dynamic>?;

      if (choices == null || choices.isEmpty) {
        setState(() {
          _error = 'Empty response from Groq.';
        });
        return;
      }

      final content =
          choices.first['message']?['content']?.toString().trim() ?? '';

      if (content.isEmpty) {
        setState(() {
          _error = 'Groq returned empty content.';
        });
        return;
      }

      String pureOutput = '';
      String explanation = '';
      String parsedRecommendations = '';

      try {
        final decodedJson = jsonDecode(content);

        if (decodedJson is Map<String, dynamic>) {
          pureOutput = decodedJson['pure_output']?.toString() ?? '';
          explanation = decodedJson['explanation']?.toString() ?? '';
          final recs = decodedJson['recommendations'];

          if (recs is List) {
            parsedRecommendations = recs.map((e) => '- $e').join('\n');
          } else if (recs is String) {
            parsedRecommendations = recs;
          }
        } else {
          explanation = content;
        }
      } catch (_) {
        explanation = content;
      }

      setState(() {
        _pureOutput = pureOutput;
        _explanation =
            explanation.isEmpty ? '(no explanation yet)' : explanation;
        _aiRecommendations = parsedRecommendations.isEmpty
            ? 'No recommendations parsed.'
            : parsedRecommendations;
      });
    } catch (e) {
      setState(() {
        _error = 'Unexpected Groq error: $e';
      });
    } finally {
      setState(() {
        _isCallingGroq = false;
      });
    }
  }

  String _buildUserPrompt() {
    final modeDescription = () {
      switch (_executionStyle) {
        case 'run':
          return '1) Mentally simulate the program using the given stdin and set pure_output exactly to what the console would show.\n'
              '2) If the code is wrong, still set pure_output to the most likely error message.';
        case 'review':
          return 'Focus on explaining bugs or risks and how to fix them in recommendations; pure_output should reflect the most likely console output.';
        case 'explain':
        default:
          return 'Explain what this code does, and if it has bugs, clearly mention them and how to fix them in recommendations. pure_output must be the console output only.';
      }
    }();

    return 'You are given:\n'
        '- Language: $_selectedLanguage\n'
        '- Execution style: $_executionStyle\n'
        '- Code:\n'
        '---\n${_codeController.text}\n---\n'
        '- stdin (if relevant):\n${_stdinController.text}\n\n'
        'TASK:\n'
        '$modeDescription\n\n'
        'Return ONLY valid JSON with this exact schema (no extra keys, no text outside JSON):\n'
        '{\n'
        '  "pure_output": "string, EXACTLY what the program would print to stdout/stderr (like real console), with newlines if needed",\n'
        '  "explanation": "string, human explanation of what happens and why",\n'
        '  "recommendations": [\n'
        '    "short bullet 1 (<= 25 words)",\n'
        '    "short bullet 2 (<= 25 words)",\n'
        '    "short bullet 3 (<= 25 words)"\n'
        '  ]\n'
        '}\n'
        'If the code is wrong, put the error-like text in pure_output and explain how to fix it in explanation and recommendations.\n';
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: baseTheme.brightness,
    );

    final theme = baseTheme.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: baseTheme.textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
        ),
      ),
    );

    return Theme(
      data: theme,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.brightness == Brightness.dark
                  ? const Color(0xFF020617)
                  : const Color(0xFFE0F7FA),
              colorScheme.brightness == Brightness.dark
                  ? const Color(0xFF0F172A)
                  : const Color(0xFFE8EAF6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Babuntoo Academy Assistant',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Code. Run. Level up.',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: _groqApiKey == null || _groqApiKey!.isEmpty
                    ? 'Set Groq API key'
                    : 'Update Groq API key',
                icon: Icon(
                  Icons.vpn_key_rounded,
                  color: _groqApiKey == null || _groqApiKey!.isEmpty
                      ? Colors.redAccent
                      : colorScheme.primary,
                ),
                onPressed: _openKeyDialog,
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 700;

                return Column(
                  children: [
                    // Top controls
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: colorScheme.surface.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: colorScheme.primary.withOpacity(0.15),
                          ),
                        ),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.code_rounded,
                                  size: 18,
                                  color: colorScheme.primary,
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'Language',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedLanguage,
                                dropdownColor: colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() => _selectedLanguage = value);
                                },
                                items: const [
                                  DropdownMenuItem(
                                      value: 'python', child: Text('Python')),
                                  DropdownMenuItem(
                                      value: 'javascript',
                                      child: Text('JavaScript')),
                                  DropdownMenuItem(
                                      value: 'java', child: Text('Java')),
                                  DropdownMenuItem(
                                      value: 'dart', child: Text('Dart')),
                                  DropdownMenuItem(
                                      value: 'c', child: Text('C')),
                                  DropdownMenuItem(
                                      value: 'cpp', child: Text('C++')),
                                  DropdownMenuItem(
                                      value: 'go', child: Text('Go')),
                                  DropdownMenuItem(
                                      value: 'rust', child: Text('Rust')),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.bolt_rounded,
                                  size: 18,
                                  color: colorScheme.secondary,
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'Mode',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _executionStyle,
                                dropdownColor: colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() => _executionStyle = value);
                                },
                                items: const [
                                  DropdownMenuItem(
                                      value: 'explain', child: Text('Explain')),
                                  DropdownMenuItem(
                                      value: 'run',
                                      child: Text('Simulate run')),
                                  DropdownMenuItem(
                                      value: 'review',
                                      child: Text('Code review')),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            SizedBox(
                              width: isWide ? 220 : double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _isCallingGroq ? null : _callGroq,
                                icon: _isCallingGroq
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    : const Icon(Icons.auto_awesome_rounded),
                                label: Text(
                                  _isCallingGroq
                                      ? 'Babuntoo is thinking…'
                                      : 'Ask Babuntoo',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Main content
                    Expanded(
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight - 120,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                            child: Column(
                              children: [
                                // Code editor
                                _FrostedCard(
                                  colorScheme: colorScheme,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: isWide ? 260 : 230,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        _CardHeader(
                                          title: 'Code playground',
                                          subtitle: 'Write your magic here',
                                          icon: Icons.terminal_rounded,
                                          colorScheme: colorScheme,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: _codeController,
                                              maxLines: null,
                                              expands: true,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              style: const TextStyle(
                                                fontFamily: 'monospace',
                                                fontSize: 14,
                                              ),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'for i in range(3):\n    print("Hello Babuntoo!")',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // STDIN
                                _FrostedCard(
                                  colorScheme: colorScheme,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      _CardHeader(
                                        title: 'Sample input (stdin)',
                                        subtitle:
                                            'Optional values your program reads',
                                        icon: Icons.tune_rounded,
                                        colorScheme: colorScheme,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: _stdinController,
                                          maxLines: 3,
                                          decoration: const InputDecoration(
                                            hintText:
                                                'e.g. 42\nJohn\nhello world',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // 1. Output (pure cmd-style)
                                _buildCmdOutputCard(colorScheme),

                                const SizedBox(height: 10),

                                // 2. Explanation
                                _buildExplanationCard(colorScheme),

                                const SizedBox(height: 10),

                                // 3. Recommendations
                                _buildRecommendationsCard(colorScheme),

                                if (_error.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  _FrostedCard(
                                    colorScheme: colorScheme,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SelectableText(
                                        _error,
                                        style: const TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 13,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCmdOutputCard(ColorScheme colorScheme) {
    return _FrostedCard(
      colorScheme: colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CardHeader(
            title: 'Output',
            subtitle: 'Console-style result',
            icon: Icons.terminal_rounded,
            colorScheme: colorScheme,
          ),
          Container(
            height: 140,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(
                colorScheme.brightness == Brightness.dark ? 0.7 : 0.9,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: SelectableText(
                _pureOutput.isEmpty ? r'$ python main.py' : _pureOutput,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Colors.greenAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationCard(ColorScheme colorScheme) {
    return _FrostedCard(
      colorScheme: colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CardHeader(
            title: 'Explanation',
            subtitle: 'What your code is doing',
            icon: Icons.lightbulb_rounded,
            colorScheme: colorScheme,
          ),
          SizedBox(
            height: 150,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                _explanation,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsCard(ColorScheme colorScheme) {
    return _FrostedCard(
      colorScheme: colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CardHeader(
            title: 'Recommendations',
            subtitle: 'Babuntoo’s tips to improve',
            icon: Icons.tips_and_updates_rounded,
            colorScheme: colorScheme,
          ),
          SizedBox(
            height: 150,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                _aiRecommendations.isEmpty
                    ? 'Run once to see Babuntoo’s coaching here.'
                    : _aiRecommendations,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable frosted-glass style card.
class _FrostedCard extends StatelessWidget {
  final Widget child;
  final ColorScheme colorScheme;

  const _FrostedCard({
    Key? key,
    required this.child,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: colorScheme.surface.withOpacity(0.9),
      shadowColor: Colors.black.withOpacity(0.18),
      child: child,
    );
  }
}

class _CardHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final ColorScheme colorScheme;

  const _CardHeader({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colorScheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withOpacity(0.12),
            colorScheme.secondary.withOpacity(0.06),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurface.withOpacity(0.65),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
