import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kopi/services/klasifikasi_services.dart';

part 'klasifikasi_event.dart';
part 'klasifikasi_state.dart';

class KlasifikasiBloc extends Bloc<KlasifikasiEvent, KlasifikasiState> {
  KlasifikasiBloc() : super(KlasifikasiInitial()) {
    on<KlasifikasiEvent>((event, emit) async {
      if (event is KlasifikasiCheck) {
        try {
          emit(KlasifikasiLoading());
          //membuat variable untuk menyimpan nilai kembalian dari service
          final res = await KlasifikasiServices().klasifikasi(event.gambar);
          if (res != null) {
            emit(KlasifikasiSucces());
          } else {
            emit(KlasifikasiFailed("Gagal Klasifikasi"));
          }
        } catch (e) {
          emit(KlasifikasiFailed(e.toString()));
        }
      }
    });
  }
}
