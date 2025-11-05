Tugas 7

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

    Widget tree adalah struktur hierarki yang menggambarkan semua widget yang digunakan untuk membangun tampilan aplikasi Flutter. Setiap elemen di layar merupakan node dalam pohon ini. Widget yang membungkus widget lain disebut parent, sedangkan yang berada di dalamnya disebut child. Hubungan ini menentukan bagaimana tampilan dan perilaku widget diatur. Parent memberikan constraints, batas ukuran dan posisi, ke child, lalu child menentukan ukuran sesuai batas tersebut dan melapor kembali ke parent. Contohnya, Scaffold menjadi parent dari AppBar dan body, lalu body bisa berisi Column yang di dalamnya terdapat Row, Container, atau Text. Struktur seperti ini membuat Flutter fleksibel dan modular.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

    Dalam proyek ini, saya menggunakan berbagai widget untuk membentuk tampilan aplikasi Sultan Sports secara utuh. Struktur utamanya dimulai dari Scaffold, yang berfungsi sebagai kerangka halaman tempat semua elemen diletakkan. Di bagian atas terdapat AppBar yang menampilkan judul aplikasi “Sultan Sports” dengan warna latar belakang sesuai tema. Seluruh isi halaman diletakkan di dalam properti body, yang dibungkus dengan Padding agar konten tidak menempel pada tepi layar. Di dalamnya, elemen-elemen disusun secara vertikal menggunakan Column, yang berisi kombinasi antara Row, SizedBox, dan Center untuk mengatur tata letak secara proporsional.

    Pada bagian atas body, terdapat Row yang menampilkan tiga buah InfoCard secara horizontal. Setiap InfoCard merupakan komponen kustom yang dibangun menggunakan Card, Container, dan Text. Di dalam InfoCard, elemen teks seperti judul dan isi ditata secara vertikal menggunakan Column, dengan SizedBox untuk memberikan jarak di antaranya. Ukuran kartu diatur menggunakan MediaQuery agar proporsional dengan lebar layar perangkat. Setelah itu, terdapat teks sambutan yang ditampilkan di tengah layar menggunakan Center dan Text, kemudian diikuti oleh daftar menu utama yang ditampilkan dalam bentuk grid menggunakan GridView.count. Grid ini menampilkan tiga menu utama yang diambil dari daftar objek ItemHomepage.

    Setiap item menu direpresentasikan oleh widget kustom ItemCard, yang berfungsi menampilkan ikon dan nama menu di dalam kartu berwarna. Komponen ini memanfaatkan Material dan InkWell untuk memberikan efek ripple saat ditekan. Ketika pengguna menekan salah satu kartu, muncul SnackBar di bagian bawah layar yang menampilkan pesan sesuai nama item yang ditekan. Di dalam ItemCard, ikon ditampilkan menggunakan Icon, dan teks nama menu menggunakan Text, keduanya disusun secara vertikal di tengah kartu dengan bantuan Column dan Center.

    Keseluruhan widget tersebut membentuk satu widget tree yang terorganisasi rapi, di mana widget tingkat atas (seperti Scaffold dan Column) bertindak sebagai parent yang memberikan batas ukuran (constraints) dan posisi kepada child-nya (seperti Row, InfoCard, dan ItemCard). Hubungan hierarkis ini mencerminkan prinsip layout Flutter yang menekankan bahwa constraints mengalir dari atas ke bawah, sementara ukuran dikembalikan dari bawah ke atas, sehingga tampilan aplikasi menjadi responsif, teratur, dan mudah dikembangkan.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

    MaterialApp berfungsi sebagai pembungkus utama (root) dari aplikasi Flutter yang menggunakan desain Material. Widget ini penting karena menyediakan pengaturan global seperti tema warna, font, navigasi antar halaman, dan efek animasi bawaan. Tanpa MaterialApp, banyak widget lain seperti Scaffold atau SnackBar tidak akan berfungsi dengan baik karena mereka membutuhkan konteks dari Material Design. Itu sebabnya MaterialApp hampir selalu ditempatkan di bagian paling atas aplikasi.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

    Perbedaan utama antara StatelessWidget dan StatefulWidget ada pada apakah tampilan bisa berubah atau tidak. StatelessWidget digunakan untuk tampilan yang tidak berubah, misalnya teks, ikon, atau halaman statis. Sementara StatefulWidget digunakan jika tampilan perlu berubah karena ada data atau keadaan baru, misalnya ketika pengguna menekan tombol dan angka bertambah. Dalam proyek ini saya memakai StatelessWidget karena halaman yang saya buat hanya menampilkan informasi tetap dan tidak memiliki perubahan data selama aplikasi berjalan.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

    BuildContext adalah objek yang menandai posisi suatu widget di dalam widget tree. Flutter menggunakan BuildContext untuk mengetahui di mana widget itu berada dan agar widget bisa berinteraksi dengan widget lain di atasnya. Misalnya, ketika saya menampilkan SnackBar, saya perlu BuildContext dari Scaffold agar Flutter tahu di layar mana notifikasi itu harus muncul. Karena itu, setiap metode build selalu memiliki parameter BuildContext context, dan konteks inilah yang digunakan untuk membangun tampilan widget tersebut.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

    Hot reload adalah fitur di Flutter yang memungkinkan kita memperbarui tampilan aplikasi tanpa memulai ulang seluruh aplikasi. Biasanya digunakan saat kita mengubah tampilan, warna, atau teks supaya perubahan langsung terlihat tanpa kehilangan posisi aplikasi. Sedangkan hot restart memulai ulang aplikasi dari awal dan menghapus semua data atau state yang sedang berjalan. Hot restart digunakan kalau kita mengubah struktur kode besar atau variabel global yang tidak bisa diperbarui hanya dengan hot reload.

7. Jelaskan bagaimana kamu menambahkan navigasi untuk berpindah antar layar di aplikasi Flutter.

    Untuk navigasi antar layar pada aplikasi Flutter, saya menggunakan Navigator, yaitu widget yang bekerja seperti tumpukan (stack) untuk mengatur perpindahan halaman. Ketika pengguna ingin membuka halaman baru, Flutter menumpuk layar baru di atas layar yang sedang aktif. Hal ini dilakukan menggunakan perintah Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanBaru()));. Dengan cara ini, aplikasi tetap mempertahankan halaman sebelumnya di memori, sehingga pengguna dapat kembali ke halaman awal tanpa kehilangan data atau struktur tampilan.

    Sebaliknya, untuk kembali ke halaman sebelumnya, digunakan perintah Navigator.pop(context); yang berfungsi menghapus halaman teratas dari tumpukan dan menampilkan halaman di bawahnya. Mekanisme ini membuat perpindahan antar layar menjadi mulus dan efisien, karena Flutter tidak perlu memuat ulang seluruh aplikasi. Selain itu, BuildContext yang dibawa oleh setiap widget memastikan bahwa proses navigasi dilakukan pada konteks halaman yang tepat, sehingga tampilan baru dapat ditampilkan dengan benar di dalam struktur widget tree. Dengan sistem berbasis stack ini, Flutter memudahkan pengembang untuk mengatur alur berpindah antar halaman tanpa kehilangan kendali terhadap state maupun tampilan utama aplikasi.