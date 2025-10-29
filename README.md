Tugas 7

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.

    Widget tree pada Flutter bisa diibaratkan seperti struktur pohon yang berisi semua widget dalam sebuah aplikasi. Setiap widget bisa memiliki widget lain di dalamnya yang disebut sebagai child, dan widget yang membungkusnya disebut parent. Hubungan parent-child ini menentukan bagaimana tampilan dibangun dan ditata di layar. Misalnya, dalam proyek saya, widget Scaffold menjadi parent dari AppBar dan body. Di dalam body ada Column, lalu di dalamnya lagi terdapat Row, Card, dan Text. Semua itu membentuk satu susunan yang teratur, di mana parent mengatur posisi, ukuran, dan perilaku dari anak-anaknya.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

    Dalam proyek ini saya menggunakan cukup banyak widget, dan masing-masing punya fungsi yang berbeda. Widget MaterialApp digunakan sebagai pembungkus utama aplikasi agar semua tampilan mengikuti gaya Material Design. Lalu ada Scaffold yang menyediakan struktur dasar halaman, seperti tempat untuk AppBar, body, dan SnackBar. Widget AppBar dipakai untuk menampilkan judul di bagian atas layar.
    
    Kemudian, Padding, Column, dan Row digunakan untuk mengatur tata letak supaya widget tersusun rapi dan tidak menempel di pinggir layar. Widget Card dan Container dipakai untuk menampilkan kotak informasi, misalnya untuk NPM, nama, dan kelas. Ada juga Text untuk menampilkan tulisan, serta Icon untuk menampilkan ikon seperti bola atau pensil. Untuk menampilkan menu utama, saya menggunakan GridView.count agar tampilannya berupa tiga kotak sejajar. Selain itu, saya memakai Material dan InkWell supaya tiap kartu punya efek sentuhan, dan SnackBar untuk menampilkan notifikasi kecil ketika kartu ditekan.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

    MaterialApp berfungsi sebagai pembungkus utama (root) dari aplikasi Flutter yang menggunakan desain Material. Widget ini penting karena menyediakan pengaturan global seperti tema warna, font, navigasi antar halaman, dan efek animasi bawaan. Tanpa MaterialApp, banyak widget lain seperti Scaffold atau SnackBar tidak akan berfungsi dengan baik karena mereka membutuhkan konteks dari Material Design. Itu sebabnya MaterialApp hampir selalu ditempatkan di bagian paling atas aplikasi.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

    Perbedaan utama antara StatelessWidget dan StatefulWidget ada pada apakah tampilan bisa berubah atau tidak. StatelessWidget digunakan untuk tampilan yang tidak berubah, misalnya teks, ikon, atau halaman statis. Sementara StatefulWidget digunakan jika tampilan perlu berubah karena ada data atau keadaan baru, misalnya ketika pengguna menekan tombol dan angka bertambah. Dalam proyek ini saya memakai StatelessWidget karena halaman yang saya buat hanya menampilkan informasi tetap dan tidak memiliki perubahan data selama aplikasi berjalan.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

    BuildContext adalah objek yang menandai posisi suatu widget di dalam widget tree. Flutter menggunakan BuildContext untuk mengetahui di mana widget itu berada dan agar widget bisa berinteraksi dengan widget lain di atasnya. Misalnya, ketika saya menampilkan SnackBar, saya perlu BuildContext dari Scaffold agar Flutter tahu di layar mana notifikasi itu harus muncul. Karena itu, setiap metode build selalu memiliki parameter BuildContext context, dan konteks inilah yang digunakan untuk membangun tampilan widget tersebut.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

    Hot reload adalah fitur di Flutter yang memungkinkan kita memperbarui tampilan aplikasi tanpa memulai ulang seluruh aplikasi. Biasanya digunakan saat kita mengubah tampilan, warna, atau teks supaya perubahan langsung terlihat tanpa kehilangan posisi aplikasi. Sedangkan hot restart memulai ulang aplikasi dari awal dan menghapus semua data atau state yang sedang berjalan. Hot restart digunakan kalau kita mengubah struktur kode besar atau variabel global yang tidak bisa diperbarui hanya dengan hot reload.

7. Jelaskan bagaimana kamu menambahkan navigasi untuk berpindah antar layar di aplikasi Flutter.

    Untuk berpindah antar layar di Flutter, saya menggunakan widget Navigator. Cara kerjanya seperti tumpukan (stack), di mana layar baru ditumpuk di atas layar sebelumnya. Saat ingin pindah ke halaman lain, saya menggunakan kode seperti Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanBaru()));. Jika ingin kembali ke halaman sebelumnya, saya cukup memanggil Navigator.pop(context);. Dengan cara ini, Flutter bisa berpindah antar halaman dengan mulus tanpa kehilangan struktur aplikasi utama.