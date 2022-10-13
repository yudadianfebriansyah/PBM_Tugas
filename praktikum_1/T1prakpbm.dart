void main(){
    // membuat variabel dengan tipe data
    String nama = "Yuda Dian Febriansyah";
    int npm = 2010631170159;
    double tinggi = 173.43;
    bool lulus = false;

    // membuat veriabel dengan kata kunci var
    var kampus = "Universitas Singaperbangsa Karawang";

    // mencetak variabel
    print("Nama saya $nama. Nomor NPM saya $npm .");
    print("Tinggi sekitar $tinggi cm.");
    print("Status kelulusan: $lulus");
    print("Nama Kampus: $kampus");



    for(int i=0;i<=10;i++){
        print("*" * i);
     }  
    // list
     List<String> duit = ["seribu", "dua ribu", "lima ribu", "sepuluh ribu", "dua puluh ribu"];
     for (int i = 0; i < duit.length; i++) {
    print(duit[i]);
    }
    // map
    var uang = Map<int, String>();
      uang[1000] = 'Ini adalah uang seribu';
      uang[2000] = 'Ini adalah uang dua ribu';
      uang[5000] = 'ini adalah uang lima ribu';
      uang[10000] = 'Ini adalah uang sepuluh ribu';
      uang[20000] = 'ini adalah uang dua puluh ribu';
    
      print(uang);

    // sets
    print(uang.length);


    double nilai = 4.0;
  
    if (nilai >= 3.5) {
      print("cumlaude");
    } else{
      print("tidak cumlaude");
    } 
}
