import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

List<Color> colors = [
  Colors.black,
  Colors.purple,
  Colors.blue,
];

class _WalletScreenState extends State<WalletScreen> {
  bool _isExanded = false;

  void _onExpand() {
    setState(() {
      _isExanded = true;
    });
  }

  void _onShrink() {
    setState(() {
      _isExanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onVerticalDragEnd: (_) => _onShrink(),
          onTap: _onExpand,
          child: Column(
            children: [
              for (var index in [0, 1, 2])
                Hero(
                  tag: '$index',
                  child: CreditCard(
                    index: index,
                    isExpanded: _isExanded,
                  )
                      .animate(
                        target: _isExanded ? 0 : 1,
                        delay: 1.5.seconds,
                      )
                      .flipV(
                        end: 0.1,
                      )
                      .slideY(end: -0.7 * index),
                ),
            ]
                .animate(
                  interval: 500.milliseconds,
                )
                .fadeIn(
                  begin: 0,
                )
                .slideX(
                  begin: -1,
                ),
            // NOTE: Same as above but with effects
            // ].animate(
            //   interval: 500.milliseconds,
            //   effects: [
            //     SlideEffect(
            //       begin: Offset(-1, 0),
            //       end: Offset.zero,
            //     ),
            //     FadeEffect(begin: 0, end: 1),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}

class CreditCard extends StatefulWidget {
  final int index;
  final bool isExpanded;

  const CreditCard({
    super.key,
    required this.index,
    required this.isExpanded,
  });

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  void _onTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(
          index: widget.index,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AbsorbPointer(
        absorbing: !widget.isExpanded,
        child: GestureDetector(
          onTap: _onTap,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors[widget.index],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 40,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nomad Coder',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '**** **** **75',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 20,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardDetailScreen extends StatelessWidget {
  final int index;

  const CardDetailScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Hero(
              tag: '$index',
              child: CreditCard(
                index: index,
                isExpanded: false,
              ),
            ),
            ...[
              // ignore: unused_local_variable
              for (var i in [1, 1, 1, 1, 1, 1])
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    tileColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Uniqlo",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Gangnam Branch",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    trailing: Text(
                      "\u20A9167,800",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ]
                .animate(
                  interval: 500.milliseconds,
                )
                .fadeIn(
                  begin: 0,
                )
                .flipV(
                  begin: -0.5,
                  end: 0,
                  curve: Curves.bounceOut,
                ),
          ],
        ),
      ),
    );
  }
}
