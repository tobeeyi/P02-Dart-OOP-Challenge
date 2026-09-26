import '../lib/exception.dart';
import '../lib/model.dart';
import '../lib/service.dart';

void main() async {
  print('=== DEMO MODEL DOMAIN PEMESANAN MAKANAN ===\n');

  final service = OrderService();

  final item1 = FoodItem(id: 'F1', name: 'Ayam Geprek', basePrice: 20000, spicyLevel: 'Pedas Sedang');
  final item2 = FoodItem(id: 'F2', name: 'Nasi Goreng', basePrice: 25000, spicyLevel: 'Tidak Pedas');

  final orderAwal = Order(
    orderId: 'ORD-101',
    items: [item1, item2],
    note: 'Bungkus terpisah',
  );

  print('1. Pesanan Berhasil Dibuat:');
  print('   ID: ${orderAwal.orderId}');
  print('   Status: ${orderAwal.status.name}');
  print('   Catatan: ${orderAwal.note ?? "Tidak ada catatan"}');
  print('   Total Harga (Diskon 10%): Rp${orderAwal.calculateTotal(10)}\n');

  print('2. Uji copyWith & Serialization (toJson/fromJson):');
  final json = orderAwal.toJson();
  print('   JSON Result: $json');
  
  final restoredOrder = Order.fromJson(json);
  print('   Restored Order ID: ${restoredOrder.orderId}\n');

  print('3. Memproses Pesanan secara Async:');
  try {
    final updatedOrder = await service.processOrder(orderAwal);
    print('    Pesanan Berhasil Diproses! Status Baru: ${updatedOrder.status.name}\n');
  } catch (e) {
    print('Gagal Memproses: $e\n');
  }

  print('4. Memperlihatkan Pelanggaran Aturan Domain (Exception Handling):');
  
  try {
    Order(orderId: 'ORD-ERR1', items: []);
  } catch (e) {
    print('Tangkapan Error 1: $e');
  }

  try {
    final cancelledOrder = orderAwal.copyWith(status: OrderStatus.cancelled);
    await service.processOrder(cancelledOrder);
  } catch (e) {
    print('Tangkapan Error 2: $e');
  }

  print('\n=== DEMO SELESAI ===');
}
