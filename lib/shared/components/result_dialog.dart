import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:voting_system/shared/entity/candidate.dart';
import 'package:voting_system/shared/entity/voting.dart';

class ResultDialog extends StatelessWidget {
  final Voting voting;

  const ResultDialog({super.key, required this.voting});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: const Icon(Icons.close),
          splashRadius: 24,
          onPressed: () => Get.back(),
        ),
      ),
      content: SizedBox(
        height: Get.height * 0.8,
        width: Get.width * 0.8,
        child: SfCartesianChart(
          title: ChartTitle(text: 'Votação para ${voting.name}'),
          primaryXAxis: CategoryAxis(),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            header: '',
            format: 'point.y',
          ),
          series: <ChartSeries<Candidate, String>>[
            BarSeries<Candidate, String>(
              dataSource: voting.candidates,
              xValueMapper: (candidate, _) => candidate.name,
              yValueMapper: (candidate, _) => candidate.votes,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              dataLabelMapper: (candidate, _) {
                if (voting.totalVotes == 0) return '0%';
                final value = candidate.votes / voting.totalVotes * 100;

                return '${value.toStringAsFixed(2)}%';
              },
              enableTooltip: true,
            ),
          ],
        ),
      ),
    );
  }
}
