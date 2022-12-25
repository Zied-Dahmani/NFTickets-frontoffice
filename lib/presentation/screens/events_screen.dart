import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nftickets/logic/cubits/event/event_cubit.dart';
import 'package:nftickets/logic/cubits/event/event_state.dart';
import 'package:nftickets/presentation/views/upcoming_events.dart';
import 'package:nftickets/utils/strings.dart';
import 'package:nftickets/utils/theme.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.kupcomingEvents,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: AppSizes.khugeSpace),
          child: BlocBuilder<EventCubit, EventState>(builder: (context, state) {
            return state is EventLoadSuccess
                ? UpcomingEvents(events: state.events)
                : state is EventLoadInProgress
                    ? const Center(child: CircularProgressIndicator())
                    : state is EventLoadFailure
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: AppSizes.khugeSpace),
                              // TODO Display an image
                              const SizedBox(height: AppSizes.kbigSpace),
                              Center(
                                child: Text(state.error,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              ),
                            ],
                          )
                        : const SizedBox();
          }),
        ),
      ),
    );
  }
}
