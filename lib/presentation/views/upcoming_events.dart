import 'package:flutter/material.dart';
import 'package:nftickets/data/models/event_model.dart';
import 'package:nftickets/utils/constants.dart';
import 'dart:ui' as ui;
import 'package:nftickets/utils/theme.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({Key? key, required this.events}) : super(key: key);

  final List<Event> events;

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  late final PageController _cardPageController;
  late final PageController _detailsPageController;

  double _cardPage = 0.0;
  double _detailsPage = 0.0;
  int _cardIndex = 0;
  final _showDetails = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _cardPageController = PageController(viewportFraction: 0.77)
      ..addListener(_cardPagePercentListener);
    _detailsPageController = PageController()
      ..addListener(_detailsPagePercentListener);
  }

  _cardPagePercentListener() {
    setState(() {
      _cardPage = _cardPageController.page!;
      _cardIndex = _cardPageController.page!.round();
    });
  }

  _detailsPagePercentListener() {
    setState(() {
      _detailsPage = _detailsPageController.page!;
    });
  }

  @override
  void dispose() {
    _cardPageController
      ..removeListener(_cardPagePercentListener)
      ..dispose();
    _detailsPageController
      ..removeListener(_detailsPagePercentListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: h / 1.8,
          width: w,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: PageView.builder(
              controller: _cardPageController,
              clipBehavior: Clip.none,
              itemCount: widget.events.length,
              onPageChanged: (page) {
                _detailsPageController.animateToPage(
                  page,
                  duration: const Duration(milliseconds: 500),
                  curve: const Interval(0.25, 1, curve: Curves.decelerate),
                );
              },
              itemBuilder: (_, index) {
                final item = widget.events[index];
                final progress = (_cardPage - index);
                final scale = ui.lerpDouble(1, .8, progress.abs())!;
                final isCurrentPage = index == _cardIndex;
                final isScrolling =
                    _cardPageController.position.isScrollingNotifier.value;
                final isFirstPage = index == 0;

                return Transform.scale(
                  alignment: Alignment.lerp(
                    Alignment.topLeft,
                    Alignment.center,
                    -progress,
                  ),
                  scale: isScrolling && isFirstPage ? 1 - progress : scale,
                  child: GestureDetector(
                    onTap: () {
                      _showDetails.value = !_showDetails.value;
                      const transitionDuration = Duration(milliseconds: 550);
                      /*Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: transitionDuration,
                          reverseTransitionDuration: transitionDuration,
                          pageBuilder: (_, animation, ___) {
                            return FadeTransition(
                              opacity: animation,
                              //child: InfoScreen(food: _foodList[0]),
                            );
                          },
                        ),
                      );*/
                      Future.delayed(transitionDuration, () {
                        _showDetails.value = !_showDetails.value;
                      });
                    },
                    child: Hero(
                      tag: item.image,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        transform: Matrix4.identity()
                          ..translate(
                            isCurrentPage ? 0.0 : -20.0,
                            isCurrentPage ? 0.0 : 60.0,
                          ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppSizes.kradius)),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              offset: const Offset(5, 25),
                              color: Colors.white.withOpacity(.08),
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage('$kbaseUrl${item.image}'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: AppSizes.khugeSpace),
        Expanded(
          child: PageView.builder(
            controller: _detailsPageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.events.length,
            itemBuilder: (_, index) {
              final item = widget.events[index];
              final opacity = (index - _detailsPage).clamp(0.0, 1.0);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace),
                // TODO Remove this widget
                child: Opacity(
                  opacity: 1 - opacity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: item.name,
                        child: Text(
                          item.name,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _showDetails,
                        builder: (_, value, __) {
                          return Visibility(
                            visible: value,
                            child: Text(
                              item.convertDate(),
                              style: theme.textTheme.bodySmall,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
