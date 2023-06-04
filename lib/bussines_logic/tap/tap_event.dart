// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tap_bloc.dart';

abstract class TapEvent extends Equatable {
  const TapEvent();

  @override
  List<Object> get props => [];
}

class UpdateTap extends TapEvent {
  final int index;
  const UpdateTap({
    required this.index,
  });
  @override
  List<Object> get props => [index];
}

class OnLogic extends TapEvent {
  final BuildContext context;
  const OnLogic({
    required this.context,
  });
  @override
  List<Object> get props => [context];
}
