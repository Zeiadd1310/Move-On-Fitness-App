import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/profile/data/repos/profile_repo_impl.dart';
import 'package:move_on/features/profile/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:move_on/features/profile/presentation/views/widgets/edit_profile_view_body.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({
    super.key,
    this.firstTimeSetup = false,
    this.initialName,
    this.initialEmail,
    this.initialMobileNumber,
    this.initialDateOfBirth,
    this.initialWeight,
    this.initialHeight,
  });

  final bool firstTimeSetup;
  final String? initialName;
  final String? initialEmail;
  final String? initialMobileNumber;
  final String? initialDateOfBirth;
  final String? initialWeight;
  final String? initialHeight;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(
        ProfileRepoImpl(
          apiService: ApiService(),
          localStorageService: LocalStorageService(),
        ),
      ),
      child: Scaffold(
        body: EditProfileViewBody(
          firstTimeSetup: firstTimeSetup,
          initialName: initialName,
          initialEmail: initialEmail,
          initialMobileNumber: initialMobileNumber,
          initialDateOfBirth: initialDateOfBirth,
          initialWeight: initialWeight,
          initialHeight: initialHeight,
        ),
      ),
    );
  }
}
