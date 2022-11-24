
class RestaurantModel {
  final double rating;
  final String title;
  final String deskripsi;
  final String image;
  RestaurantModel({
    required this.rating,
    required this.title,
    required this.deskripsi, 
    required this.image,   
  });
}

List<RestaurantModel> restaurantList = [
  RestaurantModel(
    rating: 4.6,
    title: "Chatime",
    deskripsi: "Chatime merupakan penyedia minuman brewed tea asal Taiwan yang menghadirkan lebih dari 50 varian rasa. \nDi Indonesia, Chatime merupakan bagian dari F&B Indonesia, induk perusahaan yang sejak tahun 2011 menaungi seluruh portofolio pilar bisnis food & beverage Kawan Lama Group.",
    image: "image/1.jpg",
    ),
  RestaurantModel(
    rating: 4.9,
    title: "KFC",
    deskripsi: "KFC adalah merek restoran ayam global dengan sejarah kesuksesan dan inovasi yang kaya selama puluhan tahun. Semuanya dimulai dengan seorang juru masak, Kolonel Harland Sanders, yang menciptakan resep enak lebih dari 75 tahun yang lalu—daftar 11 bumbu dan rempah rahasia yang tergores di belakang pintu dapurnya. Hari ini, kami masih mengikuti formula kesuksesannya, dengan koki sungguhan yang memasak dan menyiapkan ayam lezat kami dengan tangan di lebih dari 25.000 restoran di lebih dari 145 negara dan wilayah di seluruh dunia.",
    image: "image/2.jpg",
    ),
  RestaurantModel(
    rating: 4.7,
    title: "Starbucks Coffee",
    deskripsi: "Dibutuhkan banyak tangan untuk membuat secangkir kopi yang sempurna – dari petani yang merawat buah kopi merah matang, hingga pemanggang utama yang membujuk yang terbaik dari setiap biji, dan hingga barista yang menyajikannya dengan hati-hati. Kami berkomitmen pada standar kualitas dan layanan tertinggi, merangkul warisan kami sambil berinovasi untuk menciptakan pengalaman baru untuk dinikmati.",
    image: "image/3.png",
    ),
  RestaurantModel(
    rating: 4.7,
    title: "McDonald's",
    deskripsi: "McDonald’s merupakan restoran fast food terbesar di dunia yang diawali pada tahun 1955 di California, Amerika Serikat. Dengan produk unggulan berupa Burger bernama Bigmac, McDonald’s hingga saat ini telah memiliki ribuan restoran yang tersebar di lebih dari 100 negara, salah satunya Indonesia. McDonald’s pertama kali masuk ke Indonesia pada tahun 1991 dengan membuka restoran pertamanya di Sarinah, Thamrin.",
    image: "image/4.jpg",
    ),
  RestaurantModel(
    rating: 4.9,
    title: "Coca-Cola",
    deskripsi: "The Coca-Cola Company (NYSE: KO) adalah perusahaan minuman total dengan produk yang dijual di lebih dari 200 negara dan wilayah.\nTujuan perusahaan kami adalah untuk menyegarkan dunia dan membuat perbedaan. Portofolio merek kami meliputi Coca-Cola, Sprite, Fanta, dan minuman ringan bersoda lainnya. Merek hidrasi, olahraga, kopi, dan teh kami meliputi Dasani, smartwater, vitaminwater, Topo Chico, Powerade, Costa, Georgia, Gold Peak, Ayataka, dan BodyArmor. Merek nutrisi, jus, susu, dan minuman nabati kami meliputi Minute Maid, Simply, innocent, Del Valle, fairlife, dan AdeS.",
    image: "image/5.png",
    ),
];
