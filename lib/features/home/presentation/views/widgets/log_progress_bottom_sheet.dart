import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/features/home/data/models/log_progress_request.dart';
import 'package:move_on/features/home/presentation/cubits/progress_cubit/progress_cubit.dart';
import 'package:move_on/features/profile/data/models/user_profile_model.dart';

class LogProgressBottomSheet extends StatefulWidget {
  final UserProfileModel? profile;

  const LogProgressBottomSheet({super.key, this.profile});

  static Future<void> show(
    BuildContext context, {
    UserProfileModel? profile,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ProgressCubit>(),
        child: LogProgressBottomSheet(profile: profile),
      ),
    );
  }

  @override
  State<LogProgressBottomSheet> createState() => _LogProgressBottomSheetState();
}

class _LogProgressBottomSheetState extends State<LogProgressBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _weightCtrl;
  late final TextEditingController _heightCtrl;
  final TextEditingController _fatCtrl = TextEditingController();
  final TextEditingController _muscleCtrl = TextEditingController();
  final TextEditingController _bmrCtrl = TextEditingController();
  bool _isSubmitting = false;
  String? _token;

  @override
  void initState() {
    super.initState();
    // Pre-fill from profile
    final w = widget.profile?.weight ?? '';
    final h = widget.profile?.height ?? '';
    _weightCtrl = TextEditingController(text: w.isNotEmpty ? w : '');
    _heightCtrl = TextEditingController(text: h.isNotEmpty ? h : '');
    _loadToken();
  }

  Future<void> _loadToken() async {
    final t = await LocalStorageService().getToken();
    if (mounted) setState(() => _token = t);
  }

  @override
  void dispose() {
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    _fatCtrl.dispose();
    _muscleCtrl.dispose();
    _bmrCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_token == null || _token!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not authenticated. Please log in again.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final request = LogProgressRequest(
      weight: double.parse(_weightCtrl.text.trim()),
      height: double.parse(_heightCtrl.text.trim()),
      fatPercentage: double.tryParse(_fatCtrl.text.trim()) ?? 0,
      musclePercentage: double.tryParse(_muscleCtrl.text.trim()) ?? 0,
      bmr: double.tryParse(_bmrCtrl.text.trim()) ?? 0,
      date: DateTime.now().toIso8601String(),
    );

    if (mounted) {
      context.read<ProgressCubit>().logProgress(request, _token!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + bottomInset),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.monitor_weight_outlined,
                      color: kPrimaryColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log Progress',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        "Today's body measurements",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontFamily: 'League Spartan',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Required fields
              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      controller: _weightCtrl,
                      label: 'Weight (kg)',
                      hint: 'e.g. 75.5',
                      icon: Icons.fitness_center,
                      required: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildField(
                      controller: _heightCtrl,
                      label: 'Height (cm)',
                      hint: 'e.g. 178',
                      icon: Icons.straighten,
                      required: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Optional fields
              const _SectionLabel(text: 'Optional'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      controller: _fatCtrl,
                      label: 'Fat %',
                      hint: 'e.g. 18',
                      icon: Icons.water_drop_outlined,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildField(
                      controller: _muscleCtrl,
                      label: 'Muscle %',
                      hint: 'e.g. 40',
                      icon: Icons.accessibility_new,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: _bmrCtrl,
                label: 'BMR (kcal/day)',
                hint: 'e.g. 1800',
                icon: Icons.local_fire_department_outlined,
              ),
              const SizedBox(height: 28),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.black,
                    disabledBackgroundColor: kPrimaryColor.withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          'Save Progress',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool required = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'League Spartan',
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: kPrimaryColor, size: 18),
        labelStyle: const TextStyle(
          color: Colors.white54,
          fontFamily: 'League Spartan',
          fontSize: 13,
        ),
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      validator: required
          ? (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              final d = double.tryParse(v.trim());
              if (d == null || d <= 0) return 'Invalid';
              return null;
            }
          : null,
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white12)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 11,
              fontFamily: 'League Spartan',
              letterSpacing: 1.2,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Colors.white12)),
      ],
    );
  }
}
