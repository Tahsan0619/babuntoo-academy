import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
// Example data model for inventions (put this in data_models.dart for reuse)
class Invention {
  final String name;
  final String year;
  final String sector;
  final String description;
  final String details;
  final List<String> imageAssetPaths; // multiple pics support
  final String? website;

  Invention({
    required this.name,
    required this.year,
    required this.sector,
    required this.description,
    required this.details,
    this.imageAssetPaths = const [],
    this.website,
  });
}

// Example inventions data (place your real data and file paths here)
final List<Invention> inventions = [
  Invention(
    name: "Quantum Internet",
    year: "2025",
    sector: "Communication",
    description: "Ultra-secure, ultra-fast networking using quantum entanglement.",
    details: "The quantum internet transfers information via entangled photons, making eavesdropping impossible. It's set to revolutionize data security and network speed over the next decade.",
    imageAssetPaths: [
      "assets/images/inventions/quantum_internet_1.jpg",
      "assets/images/inventions/quantum_internet_2.jpg",
    ],
    website: "https://cacm.acm.org/news/quantum-internet-is-slowly-becoming-a-reality/#:~:text=%E2%80%9CQuantum%20Internet%E2%80%9D%20is%20the%20term%20given%20to%20a,the%20principles%20of%20quantum%20mechanics%2C%20not%20traditional%20computing.",
  ),
  Invention(
    name: "Lab-Grown Meat",
    year: "2025",
    sector: "Food Technology",
    description: "Cultivated meat, made without harming animals.",
    details: "Lab-grown meat is produced from real animal cells in a controlled environment, offering a sustainable, ethical solution to feeding the planet without livestock farming.",
    imageAssetPaths: [
      "assets/images/inventions/lab_meat_1.jpg",
      "assets/images/inventions/lab_meat_2.jpg",
    ],
    website: "https://www.livescience.com/lab-grown-meat",
  ),
  Invention(
    name: "AI Medical Diagnosis Assistants",
    year: "2025",
    sector: "Healthcare",
    description: "AI systems that help doctors with rapid, accurate diagnoses.",
    details: "Trained on millions of patient records and images, advanced AI assistants now help doctors spot diseases early, avoid errors, and streamline clinical workflows in major hospitals worldwide.",
    imageAssetPaths: [
      "assets/images/inventions/ai_diagnosis_1.jpg",
      "assets/images/inventions/ai_diagnosis_2.jpg",
    ],
    website: "https://pmc.ncbi.nlm.nih.gov/articles/PMC8754556/",
  ),
  Invention(
    name: "mRNA Vaccines for Cancer",
    year: "2025",
    sector: "Medicine",
    description: "Personalized mRNA vaccines that train the body to kill cancer.",
    details: "Building on COVID-19 vaccine tech, scientists now use mRNA to harness the immune system to target individual patients' cancer mutations, with promising clinical results in melanoma and other cancers.",
    imageAssetPaths: [
      "assets/images/inventions/mrna_cancer_1.jpg",
      "assets/images/inventions/mrna_cancer_2.jpg",
    ],
    website: "https://www.nature.com/articles/s41571-024-00902-1",
  ),
  Invention(
    name: "Ultra-Thin Flexible Solar Panels",
    year: "2025",
    sector: "Renewable Energy",
    description: "Paper-thin, lightweight solar panels usable on any surface.",
    details: "These next-gen panels use materials like perovskite for record-breaking efficiency and flexibility, enabling solar power on windows, tents, vehicles, and more.",
    imageAssetPaths: [
      "assets/images/inventions/flexible_solar_1.jpg",
      "assets/images/inventions/flexible_solar_2.jpg",
    ],
    website: "https://www.sustainability-times.com/energy/worlds-most-powerful-flexible-solar-cell-japans-stunning-breakthrough-reaches-26-5-efficiency-setting-unprecedented-global-performance-standard/",
  ),
  Invention(
    name: "Brain-Computer Interface (Non-Invasive)",
    year: "2025",
    sector: "Neurotechnology",
    description: "Wireless, wearable headsets that decode thoughts into digital commands.",
    details: "Advances in AI and sensor technology now allow people to control devices and type with their thoughts, restoring communication for people with paralysis, and opening new accessibility frontiers.",
    imageAssetPaths: [
      "assets/images/inventions/bci_1.jpg",
      "assets/images/inventions/bci_2.jpg",
    ],
    website: "https://pmc.ncbi.nlm.nih.gov/articles/PMC11861396/",
  ),
  Invention(
    name: "Biodegradable Electronics",
    year: "2025",
    sector: "Green Electronics",
    description: "Consumer gadgets and sensors made to safely decompose after use.",
    details: "New polymers, plant-based substrates, and dissolvable conductors enable phones, wearables, and medical sensors with zero e-waste footprint.",
    imageAssetPaths: [
      "assets/images/inventions/biodegradable_electronics_1.jpg",
      "assets/images/inventions/biodegradable_electronics_2.jpg",
    ],
    website: "https://resources.pcb.cadence.com/blog/2021-the-advantages-and-challenges-of-biodegradable-electronic-components",
  ),
  Invention(
    name: "Self-Healing Concrete",
    year: "2025",
    sector: "Construction",
    description: "Concrete that repairs its own cracks using embedded bacteria or polymers.",
    details: "This material can last decades longer, reducing infrastructure costs and emissions by auto-sealing micro-cracks as soon as they form.",
    imageAssetPaths: [
      "assets/images/inventions/self_healing_concrete_1.jpg",
      "assets/images/inventions/self_healing_concrete_2.jpg",
    ],
    website: "https://www.rics.org/news-insights/building-a-sustainable-future-the-incredible-potential-of-self-healing-concrete",
  ),
  Invention(
    name: "Living Building Facades",
    year: "2025",
    sector: "Architecture",
    description: "Building walls covered in photosynthetic organisms that clean air.",
    details: "Using microalgae or moss, these living surfaces absorb CO₂, reduce air pollution, and lower indoor temperatures while generating biofuel as a byproduct.",
    imageAssetPaths: [
      "assets/images/inventions/living_facade_1.jpg",
      "assets/images/inventions/living_facade_2.jpg",
    ],
    website: "https://theconstructor.org/architecture/architectural-landscapes/vertical-gardens-living-walls-transforming-city-landscapes/577116/#:~:text=Vertical%20gardens%2C%20also%20known%20as%20living%20walls%20or,enhance%20urban%20environments%20while%20providing%20significant%20environmental%20benefits.",
  ),
  Invention(
    name: "Universal Real-Time Translation Earbuds",
    year: "2025",
    sector: "AI/Translation",
    description: "Wireless earbuds that translate multiple languages instantly in conversation.",
    details: "AI-powered earbuds now allow speakers of dozens of languages to talk in real-time, supporting global travelers, students, and business professionals.",
    imageAssetPaths: [
      "assets/images/inventions/translation_earbuds_1.jpg",
      "assets/images/inventions/translation_earbuds_2.jpg",
    ],
    website: "https://www.timekettle.co/blogs/tips-and-tricks/6-best-translator-earbuds-that-work-in-real-time",
  ),
  Invention(
    name: "Advanced Exoskeletons",
    year: "2025",
    sector: "Healthcare/Assistive Tech",
    description: "Powered wearable suits for walking assistance, rehabilitation, and industrial use.",
    details: "Lightweight, AI-controlled exoskeletons now help paralyzed users walk again and reduce fatigue for workers in heavy-lifting jobs.",
    imageAssetPaths: [
      "assets/images/inventions/exoskeleton_1.jpg",
      "assets/images/inventions/exoskeleton_2.jpg",
    ],
    website: "https://www.roboticstomorrow.com/article/2025/06/wearable-robotics-and-exoskeleton-technology/24899",
  ),
  Invention(
    name: "Augmented Reality Contact Lenses",
    year: "2025",
    sector: "Wearable Tech",
    description: "Contact lenses with built-in AR displays overlaying data in real time.",
    details: "Prototypes now display directions, health alerts, and notifications directly in your field of view—all in a contact lens, powered by nanobatteries.",
    imageAssetPaths: [
      "assets/images/inventions/ar_contact_1.jpg",
      "assets/images/inventions/ar_contact_2.jpg",
    ],
    website: "https://spectrum.ieee.org/ar-in-a-contact-lens-its-the-real-deal",
  ),
  Invention(
    name: "Fully Recyclable Clothing",
    year: "2025",
    sector: "Sustainable Fashion",
    description: "Garments made entirely from materials that can be broken down and reused endlessly.",
    details: "Polyester from captured CO₂ or plant fiber, and circular design, enables landfill-free fashion and reduces global textile waste.",
    imageAssetPaths: [
      "assets/images/inventions/recyclable_clothes_1.jpg",
      "assets/images/inventions/recyclable_clothes_2.jpg",
    ],
    website: "https://www.bbc.com/future/article/20230227-how-to-recycle-your-clothes",
  ),
  Invention(
    name: "CRISPR Gene Editing Therapy",
    year: "2024",
    sector: "Biotechnology",
    description: "Precise DNA-editing therapy curing genetic disorders.",
    details: "CRISPR-based therapies have moved from the lab to clinics, now used to correct genetic errors in sickle cell disease, beta-thalassemia, and more. The technology allows for targeted, efficient gene edits in humans.",
    imageAssetPaths: [
      "assets/images/inventions/crispr_1.jpg",
      "assets/images/inventions/crispr_2.jpg",
    ],
    website: "https://pmc.ncbi.nlm.nih.gov/articles/PMC7427626/",
  ),
  Invention(
    name: "Solid-State Battery for EVs",
    year: "2024",
    sector: "Energy/Transport",
    description: "High-density, fast-charging solid batteries in electric vehicles.",
    details: "Solid-state batteries replace flammable liquid electrolytes with solid materials, boosting EV safety, energy capacity, and rapid charging. Production vehicles with these batteries launched in 2024.",
    imageAssetPaths: [
      "assets/images/inventions/solid_state_battery_1.jpg",
      "assets/images/inventions/solid_state_battery_2.jpg",
    ],
    website: "https://www.caranddriver.com/features/a63306863/solid-state-batteries-evs-explained/",
  ),
  Invention(
    name: "Green Hydrogen Energy Plants",
    year: "2024",
    sector: "Clean Energy",
    description: "Industrial-scale production of green hydrogen from renewable sources.",
    details: "Breakthroughs in electrolysis now allow for economic hydrogen production powered by wind and solar, enabling clean fuel for vehicles, factories, and grid storage.",
    imageAssetPaths: [
      "assets/images/inventions/green_hydrogen_1.jpg",
      "assets/images/inventions/green_hydrogen_2.jpg",
    ],
    website: "https://www.sciencedirect.com/science/article/pii/S0196890424008483#:~:text=Green%20hydrogen%20stands%20as%20a%20promising%20clean%20energy,efficiency%2C%20cost%2C%20and%20maturity%2C%20necessitating%20a%20comprehensive%20assessment.",
  ),
  Invention(
    name: "Recyclable Wind Turbine Blades",
    year: "2024",
    sector: "Sustainable Engineering",
    description: "Wind turbine blades that can be fully recycled at end of life.",
    details: "New composite materials allow large wind turbine blades to be broken down and reused in other products, solving a key waste challenge in green energy infrastructure.",
    imageAssetPaths: [
      "assets/images/inventions/recyclable_blades_1.jpg",
      "assets/images/inventions/recyclable_blades_2.jpg",
    ],
    website: "https://www.sciencedirect.com/science/article/pii/S2452223622001584#:~:text=Recycling%20of%20wind%20turbine%20blades%20is%20an%20important,development%20of%20new%20recyclable%20blade%20generation%20are%20discussed.",
  ),
  Invention(
    name: "Vertical Farming Skyscrapers",
    year: "2024",
    sector: "Agriculture",
    description: "Large-scale urban farms growing crops year-round indoors",
    details: "Fully automated buildings use LED light, hydroponics, and AI monitoring to maximize crop yield per square meter—in the heart of cities, reducing food miles and water use.",
    imageAssetPaths: [
      "assets/images/inventions/vertical_farm_1.jpg",
      "assets/images/inventions/vertical_farm_2.jpg",
    ],
    website: "https://www.sciencedirect.com/science/article/abs/pii/S2210670715000700",
  ),
  Invention(
    name: "Direct Air Capture (DAC) Plants",
    year: "2024",
    sector: "Climate Technology",
    description: "Machines that remove CO₂ directly from ambient air.",
    details: "Gigaton-scale DAC is now online, sucking CO₂ from the atmosphere, then storing it underground or turning it into building materials—combating climate change directly.",
    imageAssetPaths: [
      "assets/images/inventions/direct_air_capture_1.jpg",
      "assets/images/inventions/direct_air_capture_2.jpg",
    ],
    website: "https://www.sciencedirect.com/science/article/pii/S0959652619307772",
  ),
  Invention(
    name: "Portable Water-from-Air Device",
    year: "2024",
    sector: "Water Technology",
    description: "Backpack-sized devices extracting clean water from air humidity.",
    details: "Using highly efficient condensation, these devices provide safe drinking water in arid regions and during disasters, powered by solar panels.",
    imageAssetPaths: [
      "assets/images/inventions/water_from_air_1.jpg",
      "assets/images/inventions/water_from_air_2.jpg",
    ],
    website: "https://interestingengineering.com/energy/portable-air-to-drinking-water-converter",
  ),
  Invention(
    name: "Satellite Mega-Constellations for Internet",
    year: "2024",
    sector: "Communication/Aerospace",
    description: "Networks of thousands of satellites providing high-speed global broadband.",
    details: "Low-Earth-orbit constellations (like Starlink) now provide reliable internet in remote/rural areas worldwide, shrinking the digital divide.",
    imageAssetPaths: [
      "assets/images/inventions/satellite_constellation_1.jpg",
      "assets/images/inventions/satellite_constellation_2.jpg",
    ],
    website: "https://www.comsoc.org/publications/best-readings/satellite-mega-constellations#:~:text=Then%2C%20we%20provide%20a%20list%20of%20recent%20research,%28PNT%29%20and%20finally%20enabling%20technologies%20and%20emerging%20applications.",
  ),
  Invention(
    name: "Smart Window Glass",
    year: "2024",
    sector: "Building Technology",
    description: "Glass that can change tint or opacity electronically.",
    details: "These smart windows adjust to sunlight automatically, saving energy on lighting and HVAC, and providing privacy on-demand in offices and homes.",
    imageAssetPaths: [
      "assets/images/inventions/smart_glass_1.jpg",
      "assets/images/inventions/smart_glass_2.jpg",
    ],
    website: "https://intelligentglass.net/smart-glass-windows/",
  ),
  Invention(
    name: "Edible Water Pods",
    year: "2023",
    sector: "Environmental Packaging",
    description: "Water pouches with edible, biodegradable membranes.",
    details: "Seaweed-based water capsules replace millions of plastic bottles at events and in vending machines, helping to cut single-use plastic pollution.",
    imageAssetPaths: [
      "assets/images/inventions/edible_water_pod_1.jpg",
      "assets/images/inventions/edible_water_pod_2.jpg",
    ],
    website: "https://www.notpla.com/ooho",
  ),
  // Add more inventions with as many images as you want...
];

class LatestInventionsPage extends StatelessWidget {
  const LatestInventionsPage({Key? key}) : super(key: key);

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = deviceWidth * 0.05;
    final cardPadding = deviceWidth * 0.045;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Latest Inventions',
          style: AppTextStyles.appBar(context),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.background(context),
      ),
      backgroundColor: AppColors.background(context),
      body: inventions.isEmpty
          ? Center(
        child: Text(
          'No inventions found.',
          style: AppTextStyles.headline(context),
        ),
      )
          : ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
        itemCount: inventions.length,
        separatorBuilder: (_, __) => SizedBox(height: deviceWidth * 0.06),
        itemBuilder: (context, index) {
          final inv = inventions[index];
          return Card(
            color: AppColors.background(context),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            shadowColor: AppColors.cardShadow(context).withOpacity(0.12),
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inv.name,
                    style: AppTextStyles.headline(context).copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "${inv.year} · ${inv.sector}",
                    style: AppTextStyles.subtitle(context).copyWith(
                      fontSize: 15,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.teal[200]
                          : Colors.teal[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    inv.description,
                    style: AppTextStyles.body(context).copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  if (inv.imageAssetPaths.isNotEmpty)
                    SizedBox(
                      height: deviceWidth * 0.46,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: inv.imageAssetPaths.length,
                        separatorBuilder: (context, i) => const SizedBox(width: 10),
                        itemBuilder: (context, i) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              inv.imageAssetPaths[i],
                              height: deviceWidth * 0.40,
                              width: deviceWidth * 0.62,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey[850]
                                    : Colors.grey[200],
                                width: deviceWidth * 0.62,
                                alignment: Alignment.center,
                                child: Icon(Icons.image_not_supported, size: 40,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white60
                                        : Colors.grey),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  SizedBox(height: 10),
                  Text(
                    inv.details,
                    style: AppTextStyles.body(context).copyWith(
                      fontSize: 15,
                      color: AppColors.mainText(context), // <-- Fix applied here
                    ),
                  ),
                  if (inv.website != null) ...[
                    SizedBox(height: 12),
                    TextButton.icon(
                      icon: Icon(Icons.open_in_new,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.teal[200]
                              : Colors.teal[700]),
                      label: Text(
                        "Read More",
                        style: AppTextStyles.subtitle(context).copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.teal[100]
                              : Colors.teal[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => _launchUrl(context, inv.website!),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}