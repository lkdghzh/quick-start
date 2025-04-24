import 'package:flutter/material.dart';

class SwipeableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;

  const SwipeableCard({
    super.key,
    required this.child,
    this.onLike,
    this.onDislike,
  });

  @override
  State<SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotateAnimation;
  Offset _dragOffset = Offset.zero;
  double _angle = 0;
  bool _isDragging = false;
  bool _isScrolling = false;
  Offset _dragStart = Offset.zero;
  Offset _dragTotal = Offset.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.addListener(() {
      setState(() {
        _dragOffset = _slideAnimation.value;
        _angle = _rotateAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _resetCard() {
    _slideAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _rotateAnimation = Tween<double>(begin: _angle, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward(from: 0).then((_) {
      setState(() {
        _isDragging = false;
        _isScrolling = false;
        _dragTotal = Offset.zero;
      });
    });
  }

  void _swipeCard(bool isRight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final endOffset = Offset(
      isRight ? screenWidth * 1.5 : -screenWidth * 1.5,
      _dragOffset.dy,
    );

    _slideAnimation = Tween<Offset>(begin: _dragOffset, end: endOffset).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _rotateAnimation = Tween<double>(begin: _angle, end: _angle * 2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward(from: 0).then((_) {
      if (isRight && widget.onLike != null) {
        widget.onLike!();
      } else if (!isRight && widget.onDislike != null) {
        widget.onDislike!();
      }
      setState(() {
        _dragOffset = Offset.zero;
        _angle = 0;
        _isDragging = false;
        _isScrolling = false;
        _dragTotal = Offset.zero;
      });
    });
  }

  bool _shouldStartDragging(Offset delta) {
    if (_isScrolling) return false;

    _dragTotal += delta;

    // 如果水平移动大于垂直移动，判定为拖动
    if (_dragTotal.dx.abs() > _dragTotal.dy.abs()) {
      return true;
    }

    // 如果垂直移动大于水平移动，判定为滚动
    if (_dragTotal.dy.abs() > _dragTotal.dx.abs()) {
      setState(() {
        _isScrolling = true;
      });
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dragThreshold = screenWidth * 0.4;
    final rotationFactor = 0.0008;

    return GestureDetector(
      onPanStart: (details) {
        _dragStart = details.localPosition;
        _dragTotal = Offset.zero;
      },
      onPanUpdate: (details) {
        final delta = details.delta;

        if (!_isDragging && !_isScrolling) {
          if (_shouldStartDragging(delta)) {
            setState(() {
              _isDragging = true;
            });
          }
        }

        if (_isDragging) {
          setState(() {
            _dragOffset += delta;
            if (details.localPosition.dy <
                MediaQuery.of(context).size.height / 2) {
              _angle = _dragOffset.dx * rotationFactor;
            } else {
              _angle = -_dragOffset.dx * rotationFactor;
            }
          });
        }
      },
      onPanEnd: (_) {
        if (_isDragging) {
          if (_dragOffset.dx.abs() > dragThreshold) {
            _swipeCard(_dragOffset.dx > 0);
          } else {
            _resetCard();
          }
        }
        setState(() {
          _isDragging = false;
          _isScrolling = false;
          _dragTotal = Offset.zero;
        });
      },
      child: Transform.translate(
        offset: _dragOffset,
        child: Transform.rotate(angle: _angle, child: widget.child),
      ),
    );
  }
}
