import 'package:dart_nats/dart_nats.dart' as nats;

final coupons = <int, bool>{
  101: false,
  102: false,
  103: false,
  104: false,
  105: false,
  106: false,
  107: false,
  108: false,
  109: false,
  110: false,
};
var server = nats.Client();

void main() async {
  await server.connect('localhost');
  print('Starting coupon server');

  var redeemService = server.sub('coupon.redeem');
  redeemService.stream.listen(redeemHandler);
}

void redeemHandler(nats.Message request) {
  print('Redeem: ${request.data[1]}');

  var sucess = false;
  coupons.forEach((coupon, redeemed) {
    if (coupon == request.data[1] && !redeemed) {
      coupons[coupon] = true;
      // forward
      sucess = true;
      server.pub('ticket.issue', request.data, replyTo: request.replyTo);
      return;
    }
  });
  if (!sucess) {
    print('Error');
    server.pub('seat.cancel', request.data, replyTo: request.replyTo);
  }
  print(coupons);
}
