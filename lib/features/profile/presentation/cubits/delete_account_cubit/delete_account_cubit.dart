import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/profile/data/repos/profile_repo.dart';
import 'package:move_on/features/profile/presentation/cubits/delete_account_cubit/delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final ProfileRepo profileRepo;

  DeleteAccountCubit(this.profileRepo) : super(DeleteAccountInitial());

  Future<void> deleteAccount() async {
    if (isClosed) return;
    emit(DeleteAccountLoading());
    try {
      await profileRepo.deleteAccount();
      if (!isClosed) emit(DeleteAccountSuccess());
    } catch (e) {
      if (!isClosed) emit(DeleteAccountError(_extractErrorMessage(e)));
    }
  }

  String _extractErrorMessage(Object error) {
    final rawMessage = error.toString().trim();
    const exceptionPrefix = 'Exception: ';

    if (rawMessage.startsWith(exceptionPrefix)) {
      return rawMessage.substring(exceptionPrefix.length).trim();
    }

    if (rawMessage.isEmpty) {
      return 'Unexpected error, please try again later.';
    }

    return rawMessage;
  }
}
