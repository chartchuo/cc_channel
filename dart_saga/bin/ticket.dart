import 'dart:typed_data';

import 'package:dart_nats/dart_nats.dart' as nats;

final tickets = <int, int>{};
var server = nats.Client();

var ticketId = 200;

void main() async {
  await server.connect('localhost');
  print('Starting ticket server');

  var ticketService = server.sub('ticket.issue');
  ticketService.stream.listen(ticketHandler);
}

void ticketHandler(nats.Message request) {
  print('Issue ticket: ${request.data[0]}');

  tickets[ticketId] = request.data[0];
  request.respond(Uint8List.fromList([ticketId, tickets[ticketId]]));
  ticketId++;
  print(tickets);
}
