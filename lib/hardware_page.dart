import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/data_models.dart';
import '../widgets/image_viewer.dart';

class HardwarePage extends StatelessWidget {
  final List<HardwareDevice> devices = [
    HardwareDevice(
      name: "Mouse",
      description: "A pointing device for navigating GUIs and interacting with digital content.",
      imageAssetPath: 'assets/images/hardware/mouse.png',
      history: '''
History of the Mouse:
- 1964: Invented by Douglas Engelbart at Stanford Research Institute; the first prototype was a wooden shell with two wheels.
- 1968: Engelbart publicly demonstrates the mouse during "The Mother of All Demos".
- 1981: The first commercial mouse, included with Xerox Star.
- 1983: Mouse introduced to consumers with Apple Lisa, and achieved popularity with Apple Macintosh.
- 1990s: Began using optical sensors instead of mechanical balls.
- 2000s: Wireless and laser mice become mainstream.
- Today: Varieties include multi-button, ergonomic, trackball, high-DPI gaming mice, and advanced wireless options.
''',
    ),
    HardwareDevice(
      name: "Keyboard",
      description: "The main input device for typing text, commands, and programming.",
      imageAssetPath: 'assets/images/hardware/keyboard.png',
      history: '''
History of the Keyboard:
- 1868: Inspired by the typewriter, the QWERTY layout is patented by Christopher Sholes.
- 1930s–1940s: Early computer keyboards adapted from teletype machines.
- 1980s: IBM Model M brings the PC keyboard layout, including function and control keys.
- 1990s: Introduction of ergonomic, multimedia, and wireless keyboards.
- 2000s–present: Mechanical switches, RGB lighting, and compact 60%, 75%, and split keyboards gain popularity, especially among gamers and professionals.
''',
    ),
    HardwareDevice(
      name: "Monitor",
      description: "A device that displays visual information, enabling interaction with the operating system.",
      imageAssetPath: 'assets/images/hardware/monitor.png',
      history: '''
History of the Monitor:
- 1940s: CRT (Cathode Ray Tube) developed for radar and oscilloscopes.
- 1970s: Early computer monitors adapted from televisions with text-only output.
- 1981: IBM PC includes monochrome and CGA monitors.
- 1990s: VGA, SVGA, and color CRTs become standard.
- 2000s: LCD and later LED monitors replace bulky CRTs; offering flat-screens, higher resolutions, and energy efficiency.
- 2010s–present: Wide adoption of 4K, curved, ultrawide, high refresh rate (for gaming), and touch screen monitors.
''',
    ),
    HardwareDevice(
      name: "CPU (Central Processing Unit)",
      description: "The brain of the computer; executes instructions, manages data, and controls hardware operations.",
      imageAssetPath: 'assets/images/hardware/cpu.png',
      history: '''
History of the CPU:
- 1940s: Early CPUs built from relays and vacuum tubes (ENIAC, UNIVAC).
- 1971: First commercial microprocessor, Intel 4004 (4-bit).
- 1974-78: Evolution from Intel 8080 to x86 architecture; Motorola 68000; Apple II and IBM PC CPUs.
- 1990s: Multi-core designs, increased clock speeds, power efficiency improvements.
- 2000s: 64-bit CPUs, multi-core desktops, mobile-focused architectures (ARM).
- Today: CPUs integrate graphics, AI instructions, and hardware-level security features.
''',
    ),
    HardwareDevice(
      name: "Motherboard",
      description: "The main printed circuit board (PCB) that holds and connects all computer components.",
      imageAssetPath: 'assets/images/hardware/motherboard.png',
      history: '''
History of the Motherboard:
- 1977: Apple II's logic board considered an early motherboard.
- 1981: IBM PC introduces modular motherboard with expansion slots.
- 1990s: Introduction of standardized AT, then ATX and microATX motherboard form factors.
- 2000s: Increased integration (sound, network, USB, storage controllers); support for SATA, PCI-Express, DDR RAM.
- 2010s–present: Smaller sizes (mini-ITX), diagnostic LEDs, robust overclocking features, RGB lighting, M.2 slots for SSDs.
''',
    ),
    HardwareDevice(
      name: "RAM (Random Access Memory)",
      description: "Temporary high-speed memory storing active programs and data for fast access.",
      imageAssetPath: 'assets/images/hardware/ram.png',
      history: '''
History of RAM:
- 1940s: Williams tube (CRT-based), magnetic core memory.
- 1970: Intel introduces first commercial DRAM chip (1103).
- 1980s: SIMMs (Single Inline Memory Modules) standard in PCs.
- 1990s: Evolution to DIMMs, higher densities, and faster speeds (SDRAM, DDR, DDR2).
- 2000s–present: DDR3, DDR4, and now DDR5, bring increased speeds and power efficiencies; SODIMM modules common in laptops.
''',
    ),
    HardwareDevice(
      name: "Hard Disk Drive (HDD)",
      description: "A magnetic storage device for retaining data long-term.",
      imageAssetPath: 'assets/images/hardware/hdd.png',
      history: '''
History of the Hard Disk Drive:
- 1956: IBM introduces the first HDD (RAMAC 305), 5 MB, refrigerator-sized.
- 1970s: 8-inch and 5.25-inch form factors; home/office computers use HDDs.
- 1980s: 3.5-inch and later 2.5-inch HDDs for desktops and laptops.
- 1990s: Consumer drives reach gigabyte capacities.
- 2000s: HDDs surpass terabyte range; Serial ATA (SATA) replaces PATA.
- 2010s–present: HDDs still used for affordable, high-capacity storage, though increasingly supplanted by SSDs in performance-critical systems.
''',
    ),
    HardwareDevice(
      name: "Solid State Drive (SSD)",
      description: "A high-speed, durable storage device with no moving parts, using flash memory.",
      imageAssetPath: 'assets/images/hardware/ssd.png',
      history: '''
History of the SSD:
- 1991: SanDisk ships first 20 MB SSD for IBM ThinkPad.
- Late 1990s: Enterprise SSDs appear for high-speed servers.
- 2007–2010: Affordable consumer SSDs launched (SATA, then mSATA, and PCIe/NVMe).
- 2015: NVMe (Non-Volatile Memory Express) SSDs greatly improve speed over SATA.
- 2020s: Widespread use in laptops/desktops, very high speeds and densities. SSDs rapidly replace HDDs for OS and active files.
''',
    ),
    HardwareDevice(
      name: "Graphics Card (GPU)",
      description: "A device dedicated to rendering images, video, and animations, also used for computation.",
      imageAssetPath: 'assets/images/hardware/gpu.png',
      history: '''
History of the Graphics Card (GPU):
- Early 1980s: First video cards (IBM Monochrome Display Adapter, CGA, EGA) for text and simple graphics.
- 1987: VGA standard by IBM sets color and resolution baseline.
- 1990s: S3, ATI, and NVIDIA introduce 2D/3D acceleration chips.
- Late 1990s: GPUs become programmable; NVIDIA GeForce and ATI Radeon begin "modern GPU" era.
- 2006: NVIDIA introduces CUDA; GPUs used for general computation (GPGPU).
- 2010s–present: Ray tracing, dedicated AI cores, multi-display/multi-GPU, huge gains in power for gaming, AI, and research.
''',
    ),
    HardwareDevice(
      name: "Power Supply Unit (PSU)",
      description: "Converts AC power from the wall to DC power for computer components.",
      imageAssetPath: "assets/images/hardware/psu.png",
      history: '''
History of the Power Supply Unit:
- 1960s–1970s: Linear power supplies in early minicomputers and mainframes.
- 1981: IBM PC includes 63W switch-mode PSU.
- 1990s: AT and ATX standards allow modular and more efficient supplies.
- 2000s: Higher wattages, efficiency standards (80 Plus), modular cabling introduced.
- Present: Digital monitoring, smaller SFX form factors, silent, smart fan, and redundancy features.
''',
    ),
    HardwareDevice(
      name: "Optical Drive (CD/DVD/Blu-ray)",
      description: "Reads and writes data using laser light on removable optical discs.",
      imageAssetPath: "assets/images/hardware/optical_drive.png",
      history: '''
History of Optical Drives:
- 1982: Sony & Philips launch first commercial CD-ROM.
- 1995: DVD-ROM increases capacity, followed by writable variants (DVD-R, DVD+RW).
- 2003: Blu-ray discs for HD storage.
- 2010s: Trend toward digital/downloads cuts widespread optical use; still used for media, backup, archival purposes.
''',
    ),
    HardwareDevice(
      name: "Sound Card",
      description: "Hardware that processes audio input and output for computers.",
      imageAssetPath: "assets/images/hardware/sound_card.png",
      history: '''
History of the Sound Card:
- 1980s: Early PCs use simple beepers; AdLib and Creative Sound Blaster introduce dedicated audio cards.
- 1990s: Advanced FM/PCM synthesis, MIDI support, and multi-channel audio.
- 2000s: 5.1/7.1 audio, EAX, hardware DSPs; later, integrated audio replaces add-on cards for most users.
- Today: High-end cards used by audiophiles, musicians, and gamers.
''',
    ),
    HardwareDevice(
      name: "Network Interface Card (NIC)",
      description: "Enables computers to connect to local networks and the internet.",
      imageAssetPath: "assets/images/hardware/nic.png",
      history: '''
History of Network Interface Card:
- 1970s: Ethernet invented at Xerox PARC.
- 1980s: ISA and then PCI network cards common in PCs.
- 2000s: Move to 100/1000 Mbps (Gigabit) then integrated NICs on motherboards.
- Today: Multi-gig and wireless NICs (WiFi/Bluetooth) built-in; 10G+ speeds in datacenters.
''',
    ),
    HardwareDevice(
      name: "Wi-Fi Adapter",
      description: "Lets computers connect wirelessly to home, campus, or public networks.",
      imageAssetPath: "assets/images/hardware/wifi_adapter.png",
      history: '''
History of Wi-Fi Adapter:
- 1997: IEEE 802.11 launches first Wi-Fi standard, 2Mbps.
- 2000s: USB and PCI Wi-Fi adapters bring wireless to desktops/laptops.
- 2009: 802.11n then 802.11ac (Wi-Fi 5), later Wi-Fi 6+ for faster, more reliable wireless.
- Today: Built into almost all laptops; USB dongles or PCIe cards upgrade desktops.
''',
    ),
    HardwareDevice(
      name: "Bluetooth Adapter",
      description: "Allows computers to connect to peripherals and devices using Bluetooth wireless technology.",
      imageAssetPath: "assets/images/hardware/bluetooth_adapter.png",
      history: '''
History of Bluetooth Adapter:
- 1994: Ericsson invents Bluetooth specification.
- 2000: First consumer Bluetooth adapters (PC card, USB).
- 2010s: Bluetooth 4.0+ adds low energy for IoT/wearables.
- Today: Standard in laptops/phones; USB adapters for desktops and specialized hardware.
''',
    ),
    HardwareDevice(
      name: "Uninterruptible Power Supply (UPS)",
      description: "Backup power device that protects computers from power loss or surges.",
      imageAssetPath: "assets/images/hardware/ups.png",
      history: '''
History of the UPS:
- 1960s-1970s: Large UPS units for mainframes/minis in business/server rooms.
- 1980s: Personal desktop UPS systems to prevent data loss.
- 2000s: "Smart" UPS with USB/computer status interface, automatic shutdown, and surge protection.
- Present: Line-interactive and online UPS types, used for business and home electronics.
''',
    ),
    HardwareDevice(
      name: "Printer",
      description: "Creates physical (hard copy) output from digital documents.",
      imageAssetPath: "assets/images/hardware/printer.png",
      history: '''
History of the Printer:
- 1950s: Impact printers (drum, dot matrix) for mainframes/minicomputers.
- 1980s: Inkjet, laser, bubble-jet, and color printers launched.
- 2000s: All-in-one printers with scan, fax, copy; affordable photo and wireless printing.
- Today: 3D printing and high-speed laser/inkjet dominate various markets.
''',
    ),
    HardwareDevice(
      name: "Scanner",
      description: "Converts paper documents and photos into digital images.",
      imageAssetPath: "assets/images/hardware/scanner.png",
      history: '''
History of the Scanner:
- 1957: First digital image scanner by Russell Kirsch (drum-based).
- 1980s: Flatbed scanners enter offices/homes.
- 2000s: Higher resolution, faster scanning, affordable all-in-ones with printers.
- Today: Document feeders and smartphone scanners continue to evolve utility.
''',
    ),
    HardwareDevice(
      name: "USB Flash Drive",
      description: "Portable flash-based storage device, used for file transfer and backup.",
      imageAssetPath: "assets/images/hardware/usb_flash_drive.png",
      history: '''
History of the USB Flash Drive:
- 2000: IBM and Trek launch the first USB memory sticks.
- 2005-2010: Larger sizes, widespread adoption worldwide.
- 2010s: USB 3.0/3.1 brings faster speeds; keychain and novelty designs appear.
- Present: Used for OS install, file transfer, live Linux, and secure backups.
''',
    ),
    HardwareDevice(
      name: "SD Card",
      description: "Removable flash memory card, used for cameras, phones, and portable devices.",
      imageAssetPath: "assets/images/hardware/sd_card.png",
      history: '''
History of SD Card:
- 1999: Matsushita, SanDisk, and Toshiba create SD card standard.
- 2001: SD cards replace SmartMedia, CompactFlash for digital cameras.
- 2010s: SDHC, SDXC extend storage to 2 TB; microSD becomes standard for phones/action cams.
- Present: UHS, A2, and high-speed classes for 4K video, gaming, and devices.
''',
    ),
    HardwareDevice(
      name: "Projector",
      description: "Displays digital visuals on a wall or screen for presentations, classrooms, or home theaters.",
      imageAssetPath: "assets/images/hardware/projector.png",
      history: '''
History of the Projector:
- 1960s: Overhead projectors for schools/offices.
- 1980s: LCD and DLP (digital light processing) projectors emerge.
- 2000s: Portable pico projectors, HD video projectors affordable.
- Today: 4K resolution, high-brightness laser and LED projectors widely used in education, conferences, and cinema.
''',
    ),
    HardwareDevice(
      name: "Trackpad / Touchpad",
      description: "A flat tactile sensor surface to control a pointer, common in laptops.",
      imageAssetPath: "assets/images/hardware/trackpad.png",
      history: '''
History of the Trackpad / Touchpad:
- 1982: First touchpad developed by Apollo Computers.
- 1994: Widespread adoption in Apple PowerBook laptops.
- 2000s: Multitouch gestures, palm rejection, glass surfaces.
- Today: Common on all notebooks, with gesture, haptic and Force Touch on premium models.
''',
    ),
    HardwareDevice(
      name: "Webcam",
      description: "Video camera designed for real-time video conversations and internet streaming.",
      imageAssetPath: "assets/images/hardware/webcam.png",
      history: '''
History of the Webcam:
- 1991: First webcam at Cambridge to monitor coffee pot.
- Late 1990s: USB webcams become available for consumers.
- 2000s: Webcams standard in laptops, higher resolution for video calls and streaming.
- Today: 4K, AI tracking, and security cameras with smart features.
''',
    ),
    HardwareDevice(
      name: "Microphone",
      description: "Captures audio input for communication, recording, or voice commands.",
      imageAssetPath: "assets/images/hardware/microphone.png",
      history: '''
History of the Microphone:
- 1877: First carbon microphone by Emile Berliner.
- 1960s–80s: Microphones in telephones, computers (analog).
- 1990s: Audio jacks on PCs plus USB digital mics.
- Today: Array mics, noise cancellation, voice recognition and studio-quality for podcasting, gaming, meetings.
''',
    ),
    HardwareDevice(
      name: "Fan / Cooling System",
      description: "Reduces temperature and prevents overheating of computer components.",
      imageAssetPath: "assets/images/hardware/fan.png",
      history: '''
History of Cooling in Computers:
- 1980s: Simple CPU fans and metal heat sinks in PCs.
- 1990s: Enhanced cooling for overclocking, case ventilation with airflow design.
- 2000s: Water cooling, heat pipes, smart thermal control.
- Today: RGB fans, AI-driven and custom liquid cooling for gaming/workstations.
''',
    ),
    HardwareDevice(
      name: "Heat Sink",
      description: "Passive component that absorbs and radiates heat from chips (CPU, GPU, etc).",
      imageAssetPath: "assets/images/hardware/heatsink.png",
      history: '''
History of Heat Sinks:
- 1960s-70s: First simple heatsinks for power transistors.
- 1980s: Used in microcomputers for CPUs.
- 1990s: Larger, finned aluminum/copper heatsinks, often with fans.
- Today: Advanced designs with vapor chambers, integrated into system boards and powerful chips.
''',
    ),
    HardwareDevice(
      name: "Power Button / Switch",
      description: "Turns the computer or device on or off by connecting or disconnecting power.",
      imageAssetPath: "assets/images/hardware/power_button.png",
      history: '''
History of the Power Button / Switch:
- Early computers: Mechanical switches on mainframes/minis.
- 1980s: AT/XT toggle switches for PCs.
- 1990s-now: Soft-power ("momentary") buttons allow safe shutdown, sleep features, RGB-lit buttons on high-end cases.
''',
    ),
    HardwareDevice(
      name: "Joystick / Game Controller",
      description: "Input device for games and 3D simulations, controlling direction and actions.",
      imageAssetPath: "assets/images/hardware/joystick.png",
      history: '''
History of the Joystick / Game Controller:
- 1967: Ralph Baer’s early gaming systems use dial/joystick controls.
- 1970s: Atari 2600 makes joystick mainstream for arcades and home games.
- 2000s: USB and wireless gamepads; analog sticks, force feedback.
- Today: Advanced, custom, adaptive, and VR controllers.
''',
    ),
    HardwareDevice(
      name: "Barcode Scanner",
      description: "Reads barcodes for quick data entry at stores, warehouses, and libraries.",
      imageAssetPath: "assets/images/hardware/barcode_scanner.png",
      history: '''
History of the Barcode Scanner:
- 1974: First retail barcode scan in Ohio (Wrigley’s gum).
- 1980s: Widespread in supermarkets, industry.
- 2000s: Laser then camera-based (imager) scanners.
- Today: 2D QR/barcode readers in mobile, cashless, and logistics.
''',
    ),
    HardwareDevice(
      name: "External Hard Drive",
      description: "Portable large-capacity storage, connects by USB, Thunderbolt or other interfaces.",
      imageAssetPath: "assets/images/hardware/external_hdd.png",
      history: '''
History of the External Hard Drive:
- 1990s: SCSI, parallel port, and first USB external drives.
- 2000s: USB 2.0/3.0 makes plug-and-play fast/external hard disks popular.
- Today: High-capacity portable USB/Thunderbolt SSDs, rugged and wireless drives.
''',
    ),
    HardwareDevice(
      name: "Docking Station",
      description: "Expands laptop connectivity, power, and peripherals through one plug.",
      imageAssetPath: "assets/images/hardware/docking_station.png",
      history: '''
History of the Docking Station:
- 1980s: Early laptop docks for power, monitor, printer.
- 2000s: Universal USB docks; more common as laptops lose ports.
- Today: Thunderbolt 3/4, USB-C docks for charging, displays, networking, and high-speed data through a single cable.
''',
    ),
    HardwareDevice(
      name: "KVM Switch (Keyboard Video Mouse)",
      description: "Lets one keyboard/mouse/monitor control multiple computers.",
      imageAssetPath: "assets/images/hardware/kvm_switch.png",
      history: '''
History of KVM Switch:
- 1980s: First hardware for server/console sharing.
- 2000s: PS/2, USB and VGA/HDMI KVMs common in IT/server rooms.
- Today: KVM over IP, remote switching, multi-monitor and secure government-grade models.
''',
    ),
  ];

  HardwarePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final cardPadding = deviceWidth * 0.04;
    final horizontalPadding = deviceWidth * 0.05;
    final iconSize = deviceWidth * 0.12;

    if (devices.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('PC Hardware', style: AppTextStyles.appBar(context)),
          centerTitle: true,
          backgroundColor: AppColors.background(context),
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primary(context)),
        ),
        body: Center(
          child: Text(
            "No hardware items found.",
            style: AppTextStyles.headline(context),
          ),
        ),
        backgroundColor: AppColors.background(context),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('PC Hardware', style: AppTextStyles.appBar(context)),
        centerTitle: true,
        backgroundColor: AppColors.background(context),
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primary(context)),
      ),
      backgroundColor: AppColors.background(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
        child: ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final device = devices[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: cardPadding / 2),
              child: Material(
                color: AppColors.background(context),
                elevation: 2,
                shadowColor: AppColors.cardShadow(context).withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: AppColors.background(context),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        title: Text(
                          device.name,
                          style: AppTextStyles.headline(context).copyWith(
                              color: AppColors.primary(context)
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ImageViewer(
                                imagePath: device.imageAssetPath.isNotEmpty
                                    ? device.imageAssetPath
                                    : ImageViewer.fallbackAsset,
                                height: iconSize * 2.1,
                                borderRadius: 10,
                              ),
                              SizedBox(height: 10),
                              Text(
                                device.description,
                                style: AppTextStyles.body(context),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 12),
                              Text(
                                device.history,
                                style: AppTextStyles.subtitle(context),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: Text('Close'),
                          )
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(cardPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageViewer(
                          imagePath: device.imageAssetPath.isNotEmpty
                              ? device.imageAssetPath
                              : ImageViewer.fallbackAsset,
                          height: iconSize + 12,
                          width: iconSize + 12,
                          borderRadius: 8,
                        ),
                        SizedBox(width: cardPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                device.name,
                                style: AppTextStyles.headline(context).copyWith(
                                    fontSize: deviceWidth < 400 ? 15 : 18,
                                    color: AppColors.primary(context)
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                device.description,
                                style: AppTextStyles.body(context).copyWith(
                                    fontSize: deviceWidth < 400 ? 13 : 15,
                                    color: AppColors.mainText(context)
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}