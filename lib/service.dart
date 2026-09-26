import 'exception.dart';
import 'model.dart';

class OrderService {
  
  Future<Order> processOrder(Order order) async {
    print(' Sedang memproses pesanan #${order.orderId}...');
    
    // Simulasi delay jaringan
    await Future.delayed(Duration(seconds: 2));

    // Validasi aturan bisnis
    if (order.status == OrderStatus.cancelled) {
      throw InvalidOrderException('Pesanan yang dibatalkan tidak dapat diproses!');
    }
    
    return order.copyWith(status: OrderStatus.preparing);
  }
}
