import 'package:flutter/material.dart';

import '../../core/app_routes.dart';
import 'models_data.dart';
import 'widgets/model_card.dart';

class ModelsListPage extends StatefulWidget {
  const ModelsListPage({super.key});

  @override
  State<ModelsListPage> createState() => _ModelsListPageState();
}

class _ModelsListPageState extends State<ModelsListPage> {
  final _repository = const ModelsRepository();
  late final List<LearningModel> _allModels;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _allModels = _repository.getAllModels();
  }

  @override
  Widget build(BuildContext context) {
    final categories = <String>{
      'All',
      ..._allModels.map((m) => m.category),
    }.toList();

    final filtered = _allModels.where((model) {
      final q = _searchQuery.toLowerCase();
      final matchesQuery = q.isEmpty ||
          model.name.toLowerCase().contains(q) ||
          model.shortName.toLowerCase().contains(q) ||
          model.description.toLowerCase().contains(q);
      final matchesCategory =
          _selectedCategory == 'All' || model.category == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Models'),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryChips(categories),
          const Divider(height: 1),
          Expanded(
            child: filtered.isEmpty
                ? const _EmptyState()
                : ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final model = filtered[index];
                return ModelCard(
                  model: model,
                  onTap: () => _openModelDetail(context, model),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openModelDetail(BuildContext context, LearningModel model) {
    switch (model.id) {
      case 'blooms_taxonomy':
        Navigator.pushNamed(context, AppRoutes.blooms);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
            Text('Custom page not implemented yet for ${model.name}.'),
          ),
        );
    }
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search models (e.g. Bloom, ADDIE)…',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          isDense: true,
        ),
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildCategoryChips(List<String> categories) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = category == _selectedCategory;
          return ChoiceChip(
            label: Text(category),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedCategory = category;
              });
            },
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'No models match your search.\nTry a different keyword or category.',
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
