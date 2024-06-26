import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quikhyr_worker/features/notification/models/work_alert_rejection_back_to_client_model.dart';
import 'package:quikhyr_worker/features/notification/models/work_approval_request_back_to_client_model.dart';
import 'package:quikhyr_worker/features/notification/repository/notification_repo.dart';
import 'package:quikhyr_worker/models/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _notificationRepo;
  NotificationCubit(this._notificationRepo) : super(NotificationInitial());
  // void sendNotification(NotificationModel notification) async{
  //   emit(const NotificationSentLoading());
  //   final result = await _notificationRepo.createNotification(notification);
  //   result.fold(
  //     (error) => emit(NotificationSentError(error: error)),
  //     (success) => emit(const NotificationSentSuccess()),
  //   );
  // }
  void getNotifications() async {
    emit(const NotificationLoading());
    final result = await _notificationRepo.getNotifications();
    result.fold(
      (error) => emit(NotificationError(error: error)),
      (notifications) => emit(NotificationLoaded(notifications: notifications)),
    );
  }

  void sendWorkAlertRejectionBackToClient(
      WorkAlertRejectionBackToClientModel notification) async {
    emit(const NotificationSentLoading());
    final result = await _notificationRepo
        .createWorkAlertRejectionBackToClient(notification);
    result.fold(
      (error) => emit(NotificationSentError(error: error)),
      (success) => emit(const NotificationSentSuccess()),
    );
  }

  void sendWorkApprovalRequestBackToClient(
      WorkApprovalRequestBackToClientModel notification) async {
    emit(const NotificationSentLoading());
    final result = await _notificationRepo
        .createWorkApprovalRequestBackToClient(notification);
    result.fold(
      (error) => emit(NotificationSentError(error: error)),
      (success) => emit(const NotificationSentSuccess()),
    );
  }
}
