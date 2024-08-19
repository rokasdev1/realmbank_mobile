import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/data/models/request.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/data/repositories/request_repository.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit({required this.requestRepository})
      : super(InitialRequestState());

  final RequestRepository requestRepository;
  StreamSubscription? receivedRequestStateChanges;

  Future<void> getReceivedRequests() async {
    receivedRequestStateChanges?.cancel();
    try {
      emit(LoadingRequestState());
      receivedRequestStateChanges =
          requestRepository.getReceivedRequestsStream().listen(
        (requests) {
          final allRequests = requests.docs;
          emit(
            SuccessRequestState(requests: allRequests),
          );
          if (allRequests.isNotEmpty) {
            MessageToaster.showMessage(
              message: 'You have new requests',
              toastType: ToastType.info,
            );
          }
        },
      );
    } catch (e) {
      log('RequestCubit.getReceivedRequests: Error: $e');
      emit(FailedRequestState(e.toString()));
    }
  }

  Future<List<Request>> getSentRequests() async {
    try {
      final requestDocs = await requestRepository.getSentRequests();
      if (requestDocs == null) {
        return [];
      }
      final requests = requestDocs.docs
          .map((doc) => Request.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return requests;
    } catch (e) {
      log('RequestCubit.getReceivedRequests: Error: $e');
      emit(FailedRequestState(e.toString()));
      return [];
    }
  }

  Future<void> sendRequest({
    required RMUser requestor,
    required RMUser requestee,
    required double amount,
    required String description,
  }) async {
    try {
      await requestRepository.createRequest(
        requestor: requestor,
        requestee: requestee,
        amount: amount,
        description: description,
      );
      MessageToaster.showMessage(
        message: 'Request sent successfully',
        toastType: ToastType.success,
      );
    } catch (e) {
      log('RequestCubit.sendRequest: Error: $e');
    }
  }

  Future<void> closeRequest({
    required String requestId,
  }) async {
    try {
      await requestRepository.closeRequest(requestId: requestId);
      MessageToaster.showMessage(
        message: 'Request closed successfully',
        toastType: ToastType.success,
      );
    } catch (e) {
      log('RequestCubit.closeRequest: Error: $e');
    }
  }
}

abstract class RequestState {}

class InitialRequestState extends RequestState {}

class LoadingRequestState extends RequestState {}

class SuccessRequestState extends RequestState {
  SuccessRequestState({
    required this.requests,
  });
  final List<QueryDocumentSnapshot> requests;
}

class FailedRequestState extends RequestState {
  FailedRequestState(this.message);
  final String message;
}
