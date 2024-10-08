import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/common/router_extras.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/models/request.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/card/widgets/request_bar.dart';
import 'package:realmbank_mobile/presentation/common/providers/request_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/find_tools.dart';
import 'package:realmbank_mobile/presentation/common/utils/formatters.dart';
import 'package:realmbank_mobile/presentation/common/widgets/date_list_tile.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  List<Request> sentRequests = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        sentRequests = await context.read<RequestCubit>().getSentRequests();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Requests',
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: RequestBar(),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() async {
              sentRequests =
                  await context.read<RequestCubit>().getSentRequests();
            });
          },
          child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: BlocBuilder<RequestCubit, RequestState>(
                  builder: (context, state) {
                    if (state is LoadingRequestState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FailedRequestState) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state is SuccessRequestState &&
                        state.requests.isEmpty) {
                      return const Center(child: Text('No requests found.'));
                    }

                    final receivedRequests = state is SuccessRequestState
                        ? state.requests
                        : <QueryDocumentSnapshot>[];

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: receivedRequests.length,
                      itemBuilder: (context, index) {
                        final requestData = receivedRequests[index].data()
                            as Map<String, dynamic>;
                        final request = Request.fromJson(requestData);
                        final userState =
                            context.read<UserCubit>().state as SuccessUserState;
                        final user = userState.user;

                        return FutureBuilder<RMUser?>(
                          future:
                              FindTools.findUserWithUID(request.requestorUID),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const ListTile(
                                title: Text('Error loading user'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data == null) {
                              return const ListTile(
                                title: Text('User not found'),
                              );
                            } else {
                              final requestorUser = snapshot.data!;
                              return DateListTile(
                                onTap: () {
                                  SendMoneyRoute(
                                    sendMoneyExtra: SendMoneyExtra(
                                        sender: user,
                                        receiverCardNum: '',
                                        receiver: requestorUser,
                                        amount: request.amount,
                                        description:
                                            '${request.description} (Request)',
                                        isRequest: true,
                                        requestId: request.id),
                                  ).push();
                                },
                                icon: Icons.request_page_outlined,
                                title:
                                    'From: ${Formatters.fullName(requestorUser.name, requestorUser.lastName)}',
                                trailing: Text(request.amount.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                date: request.timestamp,
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: sentRequests.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: sentRequests.length,
                        itemBuilder: (context, index) {
                          final request = sentRequests[index];

                          return FutureBuilder<RMUser?>(
                              future: FindTools.findUserWithUID(
                                  request.requesteeUID),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                if (snapshot.hasError) {
                                  return const ListTile(
                                    title: Text('Error loading user'),
                                  );
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return const ListTile(
                                    title: Text('User not found'),
                                  );
                                }
                                final requestee = snapshot.data!;
                                return DateListTile(
                                  onTap: () {},
                                  icon: Icons.request_page_outlined,
                                  title:
                                      'To: ${Formatters.fullName(requestee.name, requestee.lastName)}',
                                  trailing: Text(request.amount.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  date: request.timestamp,
                                );
                              });
                        },
                      )
                    : const Center(
                        child: Text('No requests found.'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
