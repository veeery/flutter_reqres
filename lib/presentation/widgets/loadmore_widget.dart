import 'package:flutter/material.dart';

class LoadMoreWidget extends StatefulWidget {
  final Function event;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final bool shrinkWrap;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const LoadMoreWidget({
    super.key,
    required this.event,
    required this.itemCount,
    required this.itemBuilder,
    this.shrinkWrap = true,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  @override
  State<LoadMoreWidget> createState() => _LoadMoreWidgetState();
}

class _LoadMoreWidgetState extends State<LoadMoreWidget> {
  late ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController
      ..removeListener(onScroll)
      ..dispose();
  }

  void onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    // 0.9 can be used to modular as Offset scroll
    if (currentScroll >= maxScroll * 0.9) {
      // // in here u can add context read to triggered event of bloc
      widget.event();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: widget.shrinkWrap,
      itemCount: (widget.isLoadingMore || widget.hasReachedMax) ? widget.itemCount + 1 : widget.itemCount,
      itemBuilder: (context, index) {
        if (index < widget.itemCount) {
          return widget.itemBuilder(context, index);
        } else {
          return widget.isLoadingMore
              ? const Center(child: Text('Loading'))
              : const Center(child: Text('No Data to load'));
        }
      },
    );
  }
}
