import 'package:flutter/material.dart';

class HydrationCard extends StatelessWidget {
  final int currentMl;
  final int goalMl;

  const HydrationCard({
    super.key,
    this.currentMl = 500,
    this.goalMl = 2000,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentMl / goalMl).clamp(0.0, 1.0);
    final percentage = (progress * 100).toInt();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF18181C)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 24, 24, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$percentage%',
                        style: const TextStyle(
                          fontSize: 40,
                          height: 1,
                          fontWeight: .w600,
                          color: Color(0xFF48A4E5),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Hydration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        currentMl == 0 ? 'Log Now' : '$currentMl ml consumed',
                        style: const TextStyle(
                          color: Color(0xFFA4A4A4),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 170,
                  height: 150,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          '${goalMl ~/ 1000} L',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: .w600
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: const Text(
                          '0 L',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: .w600
                          ),
                        ),
                      ),

                      Positioned(
                        top: 8,
                        bottom: 8,
                        left: 48,
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: List.generate(10, (index) {
                            final active = index >=
                                (10 - (progress * 10).ceil());

                            return Container(
                              width: active ? 20 : 8,
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(999),
                                color: active
                                    ? const Color(0xFF49A8FF)
                                    : const Color(0xFF17324D),
                              ),
                            );
                          }),
                        ),
                      ),

                      Positioned(
                        bottom: 8,
                        left: 56,
                        right: 0,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.white24,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              '${currentMl}ml',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: .w600
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 22),
            decoration: const BoxDecoration(
              color: Color(0xFF1B3D45),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Center(
              child: Text(
                '$currentMl ml added to water log',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}