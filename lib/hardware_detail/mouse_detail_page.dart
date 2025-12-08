import 'package:flutter/material.dart';
import '../models/hardware_model.dart';
import '../models/hardware_component_model.dart';
import '../widgets/hardware_basic_info_section.dart';
import '../widgets/hardware_components_section.dart';
import '../widgets/hardware_working_section.dart';

class MouseDetailPage extends StatelessWidget {
  static const routeName = '/mouse-detail';

  const MouseDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mouseModel = HardwareModel(
      id: 'mouse1',
      name: 'Computer Mouse',
      logoAssetPath: 'assets/images/hardware/mouse/mouse_logo.png',
      basicInfo: '''A computer mouse is a hand-held pointing device that detects two-dimensional motion relative to a surface. 
It allows the user to move a cursor and interact with a device’s graphical interface by clicking, dragging, and scrolling.
Today’s mice integrate advanced sensors, ergonomic designs, and even customizable buttons, making them integral for productivity and gaming.''',
      inventorName: 'Douglas Engelbart',
      inventorPhotoAssetPath: 'assets/images/hardware/mouse/douglas_engelbart.png',
      yearInvented: 1964,
      origin: '''The computer mouse was invented by Douglas Engelbart at the Stanford Research Institute as part of a larger project to augment human intelligence. 
The first prototype, constructed from wood, used two metal wheels to register X-Y motion. The invention was publicly demonstrated in 1968 during "The Mother of All Demos."''',
      evolution: '''The computer mouse has seen numerous technological advancements over the past five decades. 
From mechanical rollers to laser sensors, and from corded designs to wireless and rechargeable models, each stage has offered new features and user experiences.

Below is a table summarizing major mouse milestones:
''',
      typeVariants: [
        TypeVariant(imageAssetPath: 'assets/images/hardware/mouse/mouse_wireless.png', description: 'Wireless'),
        TypeVariant(imageAssetPath: 'assets/images/hardware/mouse/mouse_gaming.png', description: 'Gaming'),
        TypeVariant(imageAssetPath: 'assets/images/hardware/mouse/mouse_ergonomic.png', description: 'Ergonomic'),
        TypeVariant(imageAssetPath: 'assets/images/hardware/mouse/mouse_travel.png', description: 'Travel/Portable'),
        TypeVariant(imageAssetPath: 'assets/images/hardware/mouse/mouse_trackball.png', description: 'Trackball'),
        TypeVariant(imageAssetPath: 'assets/images/hardware/mouse/mouse_vertical.png', description: 'Vertical'),
        TypeVariant(imageAssetPath: 'assets/images/hardware/mouse/mouse_touch.png', description: 'Touch/Touchpad'),
      ],
      components: [
        HardwareComponent(name: 'Main body', imageAssetPath: 'assets/images/hardware/mouse/mouse_body.png', shortDetails: 'The molded structure designed for hand comfort and internal component housing.'),
        HardwareComponent(name: 'Left/Right Buttons', imageAssetPath: 'assets/images/hardware/mouse/mouse_buttons.png', shortDetails: 'Primary inputs for user commands and clicks.'),
        HardwareComponent(name: 'Scroll Wheel', imageAssetPath: 'assets/images/hardware/mouse/mouse_wheel.png', shortDetails: 'Allows vertical or horizontal navigation.'),
        HardwareComponent(name: 'Optical/Laser Sensor', imageAssetPath: 'assets/images/hardware/mouse/mouse_sensor.png', shortDetails: 'Detects movement across the surface, translating to cursor movement.'),
        HardwareComponent(name: 'Wireless Module', imageAssetPath: 'assets/images/hardware/mouse/mouse_wireless_module.png', shortDetails: 'For connecting to devices wirelessly via Bluetooth or RF.'),
        HardwareComponent(name: 'Rechargeable Battery', imageAssetPath: 'assets/images/hardware/mouse/mouse_battery.png', shortDetails: 'Powers wireless operations; some are removable.'),
        HardwareComponent(name: 'DPI Switch', imageAssetPath: 'assets/images/hardware/mouse/mouse_dpi_switch.png', shortDetails: 'Lets users adjust sensitivity and precision.'),
        HardwareComponent(name: 'Programmable Buttons', imageAssetPath: 'assets/images/hardware/mouse/mouse_side_buttons.png', shortDetails: 'Additional buttons for shortcuts, macros, or gameplay.'),
      ],
      workingFlowAssetPath: 'assets/images/hardware/mouse/mouse_flow_chart.png',
      technologiesUsed: [
        'Optical and laser motion sensors',
        'Capacitive touch detection (touch mice)',
        'Bluetooth and 2.4GHz RF wireless comms',
        'Lithium-polymer rechargeable batteries',
        'Teflon/ceramic skates for smooth movement',
        'LED illumination and RGB lighting (gaming mice)',
      ],
      connectivityAndCompatibility: '''USB (wired), Bluetooth (wireless), and proprietary wireless dongles. Compatible with Windows, macOS, Linux, and many tablets/phones.''',
      trivia: '''1. Early mice had one button; some modern gaming mice have over 10!
2. Logitech shipped the first wireless mouse in 1984.
3. The average lifespan of a mouse switch is over 20 million clicks.
4. Apple’s 1998 "hockey puck" mouse is notorious for its unusual, often uncomfortable design.
5. Many mice include onboard memory to store customization profiles.
6. The word "mouse" was coined due to the device’s shape and cord (like a tail).
7. Some advanced mice can track on glass and even mirror surfaces.
8. “Silent” mice use special switches for ultra-quiet clicking — popular in libraries and offices.
''',
    );

    return Scaffold(
      appBar: AppBar(title: Text(mouseModel.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HardwareBasicInfoSection(model: mouseModel),
              Text("Evolution", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(mouseModel.evolution, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 14),
              const EvolutionTable(),
              const SizedBox(height: 24),
              HardwareComponentsSection(components: mouseModel.components),
              const SizedBox(height: 24),
              HardwareWorkingSection(
                workingFlowAssetPath: mouseModel.workingFlowAssetPath,
                technologiesUsed: mouseModel.technologiesUsed,
                connectivityAndCompatibility: mouseModel.connectivityAndCompatibility,
                trivia: mouseModel.trivia,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Put this in a separate dart file if you prefer
class EvolutionTable extends StatelessWidget {
  const EvolutionTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.5);
    final headerBgColor = theme.colorScheme.surfaceVariant;
    final headerTextColor = Colors.red;  // Set header text color to red for dark mode visibility
    final cellTextColor = theme.colorScheme.onSurface;

    return Table(
      border: TableBorder.all(color: borderColor, width: 1),
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: headerBgColor),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Year', style: TextStyle(fontWeight: FontWeight.bold, color: headerTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold, color: headerTextColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, color: headerTextColor)),
            ),
          ],
        ),
        _buildTableRow('1964', 'Mechanical', 'Wooden body, 2-axis wheels, corded.', cellTextColor),
        _buildTableRow('1980s', 'Ball Mouse', 'Used a rolling ball to track motion.', cellTextColor),
        _buildTableRow(
            '1999', 'Optical', 'Infrared/Red LED to detect movement (Microsoft introduced).', cellTextColor),
        _buildTableRow('2004', 'Laser', 'Higher accuracy and works on more surfaces.', cellTextColor),
        _buildTableRow('2010+', 'Wireless, Ergonomic, RGB, Vertical',
            'Rechargeable, customizable, ergonomic, and designer options.', cellTextColor),
      ],
    );
  }

  TableRow _buildTableRow(String year, String type, String description, Color textColor) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(year, style: TextStyle(color: textColor)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(type, style: TextStyle(color: textColor)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(description, style: TextStyle(color: textColor)),
        ),
      ],
    );
  }
}
