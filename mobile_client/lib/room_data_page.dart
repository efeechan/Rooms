import 'package:flutter/material.dart';
import 'package:mobile_client/RoomData.dart';

class RoomDataPage extends StatelessWidget {
  final RoomData roomData;

  RoomDataPage({required this.roomData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (roomData.occupants.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Occupants:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: roomData.occupants.length,
                    itemBuilder: (context, index) {
                      final occupant = roomData.occupants[index];
                      return ListTile(
                        title: Text(
                            '${occupant.title} ${occupant.name} ${occupant.surname}'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            const Text(
              'Room Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DataTable(
              columns: const [
                DataColumn(label: SizedBox.shrink()),
                DataColumn(label: SizedBox.shrink()),
              ],
              rows: [
                buildDataRow("Purpose", roomData.purpose),
                buildDataRow("Temperature", '${roomData.temperature}°C'),
                buildDataRow("Humidity", '${roomData.humidity}%'),
                if (roomData.occupants.isEmpty && roomData.seats != 0)
                  buildDataRow("Seats", '${roomData.seats}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DataRow buildDataRow(String parameter, String value) {
    return DataRow(
      cells: [
        DataCell(Text(parameter)),
        DataCell(Text(value)),
      ],
    );
  }
}
