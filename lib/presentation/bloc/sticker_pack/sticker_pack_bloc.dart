import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/sticker_pack.dart';
import '../../../domain/repositories/sticker_pack_repository.dart';

// Events
abstract class StickerPackEvent extends Equatable {
  const StickerPackEvent();

  @override
  List<Object?> get props => [];
}

class LoadPopularStickerPacks extends StickerPackEvent {}
class LoadNewestStickerPacks extends StickerPackEvent {}
class LoadStickerPackDetails extends StickerPackEvent {
  final String id;
  const LoadStickerPackDetails(this.id);
}

// States
abstract class StickerPackState extends Equatable {
  const StickerPackState();

  @override
  List<Object?> get props => [];
}

class StickerPackInitial extends StickerPackState {}
class StickerPackLoading extends StickerPackState {}
class StickerPackLoaded extends StickerPackState {
  final List<StickerPack> popularPacks;
  final List<StickerPack> newestPacks;
  final StickerPack? selectedPack;

  const StickerPackLoaded({
    required this.popularPacks,
    required this.newestPacks,
    this.selectedPack,
  });

  @override
  List<Object?> get props => [popularPacks, newestPacks, selectedPack];
}
class StickerPackError extends StickerPackState {
  final String message;
  const StickerPackError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class StickerPackBloc extends Bloc<StickerPackEvent, StickerPackState> {
  final StickerPackRepository repository;

  StickerPackBloc({required this.repository}) : super(StickerPackInitial()) {
    on<LoadPopularStickerPacks>(_onLoadPopularStickerPacks);
    on<LoadNewestStickerPacks>(_onLoadNewestStickerPacks);
    on<LoadStickerPackDetails>(_onLoadStickerPackDetails);
  }

  Future<void> _onLoadPopularStickerPacks(
    LoadPopularStickerPacks event,
    Emitter<StickerPackState> emit,
  ) async {
    try {
      emit(StickerPackLoading());
      final popularPacks = await repository.getPopularStickerPacks();
      final newestPacks = await repository.getNewestStickerPacks();
      emit(StickerPackLoaded(
        popularPacks: popularPacks,
        newestPacks: newestPacks,
      ));
    } catch (e) {
      emit(StickerPackError(e.toString()));
    }
  }

  Future<void> _onLoadNewestStickerPacks(
    LoadNewestStickerPacks event,
    Emitter<StickerPackState> emit,
  ) async {
    try {
      emit(StickerPackLoading());
      final newestPacks = await repository.getNewestStickerPacks();
      final popularPacks = await repository.getPopularStickerPacks();
      emit(StickerPackLoaded(
        popularPacks: popularPacks,
        newestPacks: newestPacks,
      ));
    } catch (e) {
      emit(StickerPackError(e.toString()));
    }
  }

  Future<void> _onLoadStickerPackDetails(
    LoadStickerPackDetails event,
    Emitter<StickerPackState> emit,
  ) async {
    try {
      emit(StickerPackLoading());
      final pack = await repository.getStickerPackDetails(event.id);
      final currentState = state as StickerPackLoaded;
      emit(StickerPackLoaded(
        popularPacks: currentState.popularPacks,
        newestPacks: currentState.newestPacks,
        selectedPack: pack,
      ));
    } catch (e) {
      emit(StickerPackError(e.toString()));
    }
  }
} 