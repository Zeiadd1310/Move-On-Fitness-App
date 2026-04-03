import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/body_data/data/repos/body_data_repo_impl.dart';
import 'package:move_on/features/body_data/presentation/cubits/manual_assessment_cubit/manual_assessment_cubit.dart';
import 'package:move_on/features/body_data/presentation/views/widgets/body_data_view_body.dart';

class BodyDataView extends StatelessWidget {
  const BodyDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ManualAssessmentCubit(
        BodyDataRepoImpl(ApiService(), LocalStorageService()),
      ),
      child: const Scaffold(body: BodyDataViewBody()),
    );
  }
}
