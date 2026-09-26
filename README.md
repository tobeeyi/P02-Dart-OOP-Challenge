# Model Domain Pemesanan Makanan Online

# Domain Overview
Domain ini memodelkan sistem pesanan makanan online sederhana. Aturan utamanya adalah:
1. Pesanan tidak boleh dibuat tanpa ada item makanan di dalamnya.
2. Harga dasar makanan tidak boleh bernilai nol atau negatif.
3. Pesanan yang statusnya dibatalkan ('cancelled') tidak boleh diproses oleh 'OrderService'.

# Alasan Pemodelan & Jawaban Rubrik

1. Relasi 3 Kelas: Memisahkan 'MenuItem' (abstrak), 'FoodItem' (konkret), dan 'Order'. 'Order' memuat daftar 'FoodItem', bukan sekadar field tunggal, karena satu transaksi pesanan mencakup banyak barang sekaligus.
2. Pewarisan vs Komposisi: Menggunakan pewarisan ('FoodItem' extends 'MenuItem') karena 'FoodItem' merupakan varian spesifik dari item menu. Menggunakan komposisi pada 'Order' yang memiliki daftar 'FoodItem'.
3. Mixin ('Discountable'): Digunakan untuk berbagi fungsi perhitungan diskon yang bisa diterapkan pada item makanan maupun produk lain di masa depan tanpa memperkeruh hierarki kelas utama.
4. Enum ('OrderStatus'): Menggunakan enum agar nilai status pesanan terbatas hanya pada 'pending', 'preparing', 'delivered', dan 'cancelled' untuk menghindari bug typo string.
5. Null Safety: Field 'note' pada 'Order' bersifat nullable ('String') karena pembeli tidak diwajibkan mengisi catatan pesanan. Field lain bersifat non-nullable.
6. Custom Exception ('InvalidOrderException'): Menghentikan alur program secara tegas jika ada upaya pembuatan pesanan kosong atau pemrosesan pesanan yang dibatalkan.
