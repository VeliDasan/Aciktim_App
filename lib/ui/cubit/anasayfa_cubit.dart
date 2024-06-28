import 'package:aciktim_app/data/entity/yemekler.dart';
import 'package:aciktim_app/data/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit():super(<Yemekler>[]);

  var yfrepo = YemeklerdaoRepository();

  Future<void> yemekleriYukle() async{
    var liste= await yfrepo.yemekleriYukle();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async {
    var liste = await yfrepo.ara(aramaKelimesi);
    emit(liste);
  }
}
