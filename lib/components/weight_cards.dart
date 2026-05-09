import 'package:flutter/material.dart';

class WeightCards extends StatelessWidget {
  const WeightCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        spacing: 10,
        children: [
          Expanded(child: Container(
            height: 200,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF18181C),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "550",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600
                            )
                        ),
                        TextSpan(
                            text: "Calories",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                            )
                        )
                      ]
                  ),
                ),
                Text("1950 Remaining", style: TextStyle(
                    color: Color(0xFFA4A4A4),
                    fontSize: 14,
                  fontWeight: FontWeight.w500
                ),),
                Spacer(),
                Row(
                  children: [
                    Text("0", style: TextStyle(
                        color: Color(0xFF7E7E7E),
                      fontWeight: FontWeight.w600,
                      fontSize: 14
                    ),),
                    Spacer(),
                    Text("2500", style: TextStyle(
                        color: Color(0xFF7E7E7E),
                        fontWeight: FontWeight.w600,
                        fontSize: 14
                    ),),
                  ],
                ),
                SizedBox(height: 3,),
                SizedBox(
                  height: 6,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),

                      FractionallySizedBox(
                        widthFactor: 550 / 2500,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF7BBDE2),
                                Color(0xFF69C0B1),
                                Color(0xFF60C198),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
          Expanded(child: Container(
            height: 200,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF18181C),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "75",
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: .w700
                            )
                        ),
                        TextSpan(
                            text: "kg",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: .w500,
                              color: Colors.white
                            )
                        )
                      ]
                  ),
                ),
                Row(
                  spacing: 5,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xFF154124)
                      ),
                      child: Transform.rotate(
                        angle: -0.785398,
                        child: const Icon(Icons.arrow_forward, color: Colors.green,),
                      ),
                    ),
                    Text("+1.6kg", style: TextStyle(
                        color: Color(0xFFA4A4A4),
                        fontSize: 14,
                      fontWeight: .w500,
                    ),),
                  ],
                ),
                Spacer(),
                Text("Weight", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: .w700),),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
