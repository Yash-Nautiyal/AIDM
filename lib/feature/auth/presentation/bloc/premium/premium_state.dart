import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_session.dart';

sealed class PremiumState extends Equatable {
  const PremiumState();

  @override
  List<Object?> get props => [];
}

final class PremiumInitial extends PremiumState {
  const PremiumInitial();
}

final class PremiumEntering extends PremiumState {
  const PremiumEntering();
}

/// Session is ready — dispatch [SessionSignedIn] to enter the dashboard.
final class PremiumEnterAppReady extends PremiumState {
  const PremiumEnterAppReady(this.session);

  final UserSession session;

  @override
  List<Object?> get props => [session];
}

/// Reserved for a future subscribe / payment flow on this page.
final class PremiumSubscribing extends PremiumState {
  const PremiumSubscribing();
}

final class PremiumFailure extends PremiumState {
  const PremiumFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
