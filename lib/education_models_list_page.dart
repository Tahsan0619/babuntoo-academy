import 'package:flutter/material.dart';
import 'models/education_models_data.dart';
import 'education_model_page.dart';

class EducationModelsListPage extends StatelessWidget {
  const EducationModelsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Education Models')),
      body: ListView.builder(
        itemCount: educationModels.length,
        itemBuilder: (context, index) {
          final model = educationModels[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade600,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            title: Text(model.inventorName),
            subtitle: Text(model.yearPublished),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EducationModelPage(model: model),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
