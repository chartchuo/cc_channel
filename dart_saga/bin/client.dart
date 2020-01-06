import 'dart:typed_data';

import 'package:dart_nats/dart_nats.dart' as nats;

///Request Transaction [seat number,coupon code]
///Response [ticket number,seat number] or [0,0] if error
void main(List<String> args) async {
  var client = nats.Client();
  await client.connect('localhost');

  var seat = int.parse(args[0]);
  var coupon = int.parse(args[1]);
  var m = await client.request('seat.book', Uint8List.fromList([seat, coupon]));
  if (m.data[0] == 0) {
    print('Error');
  } else {
    print('got: ${m.data}');
  }
  client.close();
}
