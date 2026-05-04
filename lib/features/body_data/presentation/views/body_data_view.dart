import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/body_data/data/repos/body_data_repo_impl.dart';
import 'package:move_on/features/body_data/presentation/cubits/inbody_analysis_cubit/inbody_analysis_cubit.dart';
import 'package:move_on/features/body_data/presentation/cubits/manual_assessment_cubit/manual_assessment_cubit.dart';
import 'package:move_on/features/body_data/presentation/views/widgets/body_data_view_body.dart';

class BodyDataView extends StatelessWidget {
  const BodyDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = BodyDataRepoImpl(ApiService(), LocalStorageService());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ManualAssessmentCubit(repo)),
        BlocProvider(create: (_) => InbodyAnalysisCubit(repo)),
      ],
      child: const Scaffold(body: BodyDataViewBody()),
    );
  }
}
