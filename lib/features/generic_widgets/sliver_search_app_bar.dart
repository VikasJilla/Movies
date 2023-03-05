import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A sliver app bar with [CupertinoSearchTextField]
// ignore: must_be_immutable
class SliverSearchAppBar extends StatelessWidget {
  SliverSearchAppBar(
    this.title,
    this.onTextChange,
    this.onSubmitted, {
    super.key,
    this.actionWidgets = const [],
    this.searchPlaceholder =
        'Search', //we could pass search key and then read it from translations
    this.controller,
  });

  final String title;
  final void Function(BuildContext context, String query) onTextChange;
  final void Function(BuildContext context, String query) onSubmitted;
  final String searchPlaceholder;
  final List<Widget> actionWidgets;
  final TextEditingController? controller;

  /// Used for calculating height for search bar based on device's text scaling settings
  double? _scaleFactor;

  /// calculated using [_scaleFactor]
  double? _searchBarHeight;

  /// Used for providing [PreferredSize] to [SliverAppBar.bottom]
  double? _preferredSize;

  @override
  Widget build(BuildContext context) {
    _scaleFactor ??= MediaQuery.of(context).textScaleFactor;
    _searchBarHeight ??= 36 * _scaleFactor!;
    _preferredSize ??= 20 + _searchBarHeight!;

    return SliverAppBar(
      elevation: 4,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        maxLines: 1,
        softWrap: true,
        style: const TextStyle(color: Color(0xff2a303d)),
      ),
      pinned: true,
      floating: true,
      snap: true,
      actions: actionWidgets,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_preferredSize!),
        child: Padding(
          /// used this padding for calculating [_preferredSize]
          padding: const EdgeInsets.only(bottom: 12, top: 8),
          child: SizedBox(
            height: _searchBarHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: CupertinoSearchTextField(
                    controller: controller,
                    backgroundColor: const Color(0xffe1e5eb),
                    itemColor: const Color(0xff2a303d),
                    placeholder: searchPlaceholder,
                    onChanged: (String value) =>
                        onTextChange(context, value.trim()),
                    onSubmitted: (String value) =>
                        onSubmitted(context, value.trim()),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
