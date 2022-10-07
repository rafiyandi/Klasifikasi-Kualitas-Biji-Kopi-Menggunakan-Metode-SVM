part of 'klasifikasi_bloc.dart';

abstract class KlasifikasiState extends Equatable {
  const KlasifikasiState();

  @override
  List<Object> get props => [];
}

class KlasifikasiInitial extends KlasifikasiState {}

class KlasifikasiLoading extends KlasifikasiState {}

class KlasifikasiFailed extends KlasifikasiState {
  String e;
  KlasifikasiFailed(this.e);
  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class KlasifikasiSucces extends KlasifikasiState {
  KlasifikasiModel hasil;
  KlasifikasiSucces(this.hasil);
}
