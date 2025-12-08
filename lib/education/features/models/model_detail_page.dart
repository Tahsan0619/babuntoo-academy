import 'package:flutter/material.dart';
import 'models_data.dart';

/// Expects a [String] id via route arguments or direct constructor,
/// then shows full details of the selected learning model. [web:73][web:76]
class ModelDetailPage extends StatelessWidget {
  final String? modelId;
  final LearningModel? model;

  const ModelDetailPage({
    super.key,
    this.modelId,
    this.model,
  });

  LearningModel? _resolveModel() {
    if (model != null) return model;
    if (modelId == null) return null;
    const repo = ModelsRepository();
    return repo.getModelById(modelId!);
  }

  static Route<dynamic> routeFromSettings(RouteSettings settings) {
    final args = settings.arguments;
    String? id;
    LearningModel? model;
    if (args is String) {
      id = args;
    } else if (args is LearningModel) {
      model = args;
    }
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => ModelDetailPage(modelId: id, model: model),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resolved = _resolveModel();

    if (resolved == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Model details'),
        ),
        body: const Center(
          child: Text('Model not found'),
        ),
      );
    }

    final model = resolved;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(model.shortName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            model.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: -4,
            children: [
              Chip(
                avatar: const Icon(Icons.category_outlined, size: 16),
                label: Text(model.category),
              ),
              Chip(
                avatar: const Icon(Icons.auto_awesome_outlined, size: 16),
                label: Text(model.levelFocus),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            model.description,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Key principles',
            items: model.keyPrinciples,
          ),
          _Section(
            title: 'Typical uses in engineering/EdTech',
            items: model.typicalUses,
          ),
          _Section(
            title: 'Strengths',
            items: model.strengths,
          ),
          _Section(
            title: 'Limitations',
            items: model.limitations,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<String> items;

  const _Section({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          ...items.map(
                (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  '),
                  Expanded(
                    child: Text(
                      item,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
