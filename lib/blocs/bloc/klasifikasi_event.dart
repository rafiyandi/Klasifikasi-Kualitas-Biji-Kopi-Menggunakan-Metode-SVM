part of 'klasifikasi_bloc.dart';

abstract class KlasifikasiEvent extends Equatable {
  const KlasifikasiEvent();

  @override
  List<Object> get props => [];
}

class KlasifikasiCheck extends KlasifikasiEvent {
  XFile gambar;
  KlasifikasiCheck(this.gambar);

  @override
  List<Object> get props => [gambar];
}
