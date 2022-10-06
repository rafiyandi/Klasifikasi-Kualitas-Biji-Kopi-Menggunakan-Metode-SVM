import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'klasifikasi_event.dart';
part 'klasifikasi_state.dart';

class KlasifikasiBloc extends Bloc<KlasifikasiEvent, KlasifikasiState> {
  KlasifikasiBloc() : super(KlasifikasiInitial()) {
    on<KlasifikasiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
