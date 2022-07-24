import 'package:flutter/material.dart';

import '../../../shared/utils/custom_colors.dart';

class VoteCard extends StatefulWidget {
  final String description;
  final String imageUrl;
  final Future<void> Function()? onVote;
  final String actionText;

  const VoteCard({
    super.key,
    required this.onVote,
    required this.description,
    required this.imageUrl,
    required this.actionText,
  });

  @override
  State<VoteCard> createState() => _VoteCardState();
}

class _VoteCardState extends State<VoteCard> {
  bool isLoadingVote = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        const Positioned(
          top: 90,
          child: SizedBox(
            width: 300,
            height: 210,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SizedBox(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                shape: const CircleBorder(),
                elevation: 4,
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10), // Border radius
                    child: ClipOval(
                      child: Image.network(
                        widget.imageUrl,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/default-placeholder.png',
                          width: 240,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.description,
                style: textTheme.headline6?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 36,
                width: 250,
                child: ElevatedButton(
                  onPressed: widget.onVote == null ? null : _onTapVote,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      ((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey;
                        }
                        return CustomColors.green;
                      }),
                    ),
                  ),
                  child: isLoadingVote
                      ? const SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(widget.actionText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onTapVote() async {
    if (isLoadingVote) return;
    setState(() => isLoadingVote = true);
    try {
      await widget.onVote?.call();
    } catch (_) {
    } finally {
      setState(() => isLoadingVote = false);
    }
  }
}
