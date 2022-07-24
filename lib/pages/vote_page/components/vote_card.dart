import 'package:flutter/material.dart';

import '../../../shared/utils/custom_colors.dart';

class VoteCard extends StatefulWidget {
  final String description;
  final String? subtitle;
  final String imageUrl;
  final Future<void> Function()? onVote;
  final String actionText;
  final bool showDeleteButton;
  final Future<void> Function()? onDelete;

  const VoteCard({
    super.key,
    required this.onVote,
    required this.description,
    this.subtitle,
    required this.imageUrl,
    required this.actionText,
    this.showDeleteButton = false,
    this.onDelete,
  });

  @override
  State<VoteCard> createState() => _VoteCardState();
}

class _VoteCardState extends State<VoteCard> {
  bool isLoadingVote = false;
  bool isLoadingDelete = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        const Positioned.fill(
          top: 90,
          child: SizedBox(
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
              if (widget.subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(widget.subtitle!),
                ),
              Container(
                constraints: const BoxConstraints(minWidth: 250, minHeight: 48),
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
              if (widget.showDeleteButton)
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  constraints: const BoxConstraints(
                    minWidth: 250,
                    minHeight: 48,
                  ),
                  child: ElevatedButton(
                    onPressed: widget.onDelete == null ? null : _onTapDelete,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                        ((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey;
                          }
                          return Colors.red;
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
                        : const Text('DELETAR'),
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

  Future<void> _onTapDelete() async {
    if (isLoadingDelete) return;
    setState(() => isLoadingDelete = true);
    try {
      await widget.onDelete?.call();
    } catch (_) {
    } finally {
      setState(() => isLoadingDelete = false);
    }
  }
}
