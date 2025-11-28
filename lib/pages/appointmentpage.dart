// lib/pages/appointment_page.dart
import 'package:flutter/material.dart';
import '../theme/themecolors.dart';
import '../widgets/responsive.dart';
import '../widgets/portalnavbar.dart';
import '../utils/auth.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  String? selectedDepartment;
  String? selectedDoctor;
  DateTime? selectedDate;

  final List<String> departments = [
    "General Medicine",
    "Pediatrics",
    "Cardiology",
    "Emergency Care",
    "Laboratory",
    'Dermatology',
    "Surgeon",
  ];

  final List<String> doctors = [
    "Dr. Maria Santos",
    'Dr. Mark Villanueva',
    'Dr. John Reyes',
    'Dr. Angela Cruz',
    'Dr. Liza Gomez',
    'Dr. Paolo Diaz',
    'Dr. Nina Morales',
    'Dr. Carlo Ramos',
    'Dr. Emma Torres',
    'Dr. Victor Lim',
  ];

  @override
  void initState() {
    super.initState();

    if (Auth.isLoggedIn && Auth.userType == "patient") {
      nameController.text = Auth.userName ?? '';
      emailController.text = Auth.userEmail ?? '';
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Only patients can book appointments")),
        );
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // PortalNavBar
            const PortalNavBar(),

            // Hero / Header
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/images/hero.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  "Book an Appointment",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: ThemeColors.textLight,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Form Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Responsive(
                desktop: _AppointmentDesktop(state: this),
                mobile: _AppointmentMobile(state: this),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void submitAppointment() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedDepartment == null ||
        selectedDoctor == null ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Appointment booked!\n${selectedDepartment!} with $selectedDoctor on ${selectedDate!.toLocal()}'
              .split(' ')[0],
        ),
      ),
    );

    setState(() {
      phoneController.clear();
      notesController.clear();
      selectedDepartment = null;
      selectedDoctor = null;
      selectedDate = null;
    });
  }
}

// Desktop Layout
class _AppointmentDesktop extends StatelessWidget {
  final _AppointmentPageState state;
  const _AppointmentDesktop({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _LeftFormSection(state: state)),
        const SizedBox(width: 50),
        Expanded(child: _RightFormSection(state: state)),
      ],
    );
  }
}

// Mobile Layout
class _AppointmentMobile extends StatelessWidget {
  final _AppointmentPageState state;
  const _AppointmentMobile({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LeftFormSection(state: state),
        const SizedBox(height: 30),
        _RightFormSection(state: state),
      ],
    );
  }
}

// Left Form Section
class _LeftFormSection extends StatelessWidget {
  final _AppointmentPageState state;
  const _LeftFormSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("Full Name"),
        _input(controller: state.nameController, readOnly: true),
        const SizedBox(height: 25),
        _label("Email Address"),
        _input(controller: state.emailController, readOnly: true),
        const SizedBox(height: 25),
        _label("Select Department"),
        _dropdown(
          items: state.departments,
          value: state.selectedDepartment,
          onChanged: (val) =>
              state.setState(() => state.selectedDepartment = val),
        ),
        const SizedBox(height: 25),
        _label("Select Doctor"),
        _dropdown(
          items: state.doctors,
          value: state.selectedDoctor,
          onChanged: (val) => state.setState(() => state.selectedDoctor = val),
        ),
      ],
    );
  }
}

// Right Form Section
class _RightFormSection extends StatelessWidget {
  final _AppointmentPageState state;
  const _RightFormSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label("Appointment Date"),
        _datePicker(context, state),
        const SizedBox(height: 25),
        _label("Phone Number"),
        _input(controller: state.phoneController),
        const SizedBox(height: 25),
        _label("Notes (Optional)"),
        _input(controller: state.notesController, maxLines: 4),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.submitAppointment,
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.accentDark,
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: const Text(
              "Book Appointment",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeColors.textLight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Widgets
Widget _label(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ThemeColors.textDark,
    ),
  );
}

Widget _input({
  required TextEditingController controller,
  int maxLines = 1,
  bool readOnly = false,
}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    readOnly: readOnly,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

Widget _dropdown({
  required List<String> items,
  required String? value,
  required void Function(String?) onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: DropdownButtonFormField<String>(
      decoration: const InputDecoration(border: InputBorder.none),
      value: value,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    ),
  );
}

Widget _datePicker(BuildContext context, _AppointmentPageState state) {
  return TextField(
    readOnly: true,
    decoration: InputDecoration(
      hintText: state.selectedDate == null
          ? "Select Date"
          : "${state.selectedDate!.toLocal()}".split(' ')[0],
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      suffixIcon: const Icon(Icons.calendar_today),
    ),
    onTap: () async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: state.selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );
      if (picked != null) {
        state.setState(() => state.selectedDate = picked);
      }
    },
  );
}
