import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../consumer_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassCountTEController =
      TextEditingController(text: '1');
  List<WaterConsume> WaterConsumeList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff080847),
        foregroundColor: Colors.white,
        title: const Text('Water Tracker'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _trackerTapButton(),
                _trackerInputField(),
                const SizedBox(
                  height: 50,
                ),
                _trackerHistoryNav(),
                const Divider(
                  height: 10,
                ),
                _trackerBuilder()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _trackerInputField() {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: _glassCountTEController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            hintText: "Enter Glass", labelText: 'Enter Glass'),
      ),
    );
  }

  Widget _trackerHistoryNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('History'),
        Text('Total: ${_getTotalcount()}'),
      ],
    );
  }

  Widget _trackerBuilder() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: WaterConsumeList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(DateFormat.yMEd().add_jms().format(DateTime.now())),
          leading: CircleAvatar(
            child: Text('${index + 1}'),
          ),
          trailing: Text(WaterConsumeList[index].glasscount.toString()),
        );
      },
    );
  }

  Widget _trackerTapButton() {
    return GestureDetector(
      onTap: () {
        _addwaterConsume();
      },
      child: Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  "https://static.vecteezy.com/system/resources/previews/007/126/517/non_2x/water-droplet-icon-free-vector.jpg",
                ),
                fit: BoxFit.contain)),
        child: const Text('Tap Here'),
      ),
    );
  }

  void _addwaterConsume() {
    int glassCount = int.tryParse(_glassCountTEController.text) ?? 1;
    WaterConsume waterConsume =
        WaterConsume(time: DateTime.now(), glasscount: glassCount);

    WaterConsumeList.add(waterConsume);
    setState(() {});
  }

  int _getTotalcount() {
    int totalCount = 0;
    for (WaterConsume waterConsume in WaterConsumeList) {
      totalCount += waterConsume.glasscount;
    }
    return totalCount;
  }
}
