import 'package:flutter/material.dart';

class DrugDetails extends StatelessWidget {

  Color color = Color.fromRGBO(17, 24, 39, 1);
  FontWeight weight700 = FontWeight.w700;
  String fontFamily = "Manrope";
  final Color bgColor;

  DrugDetails({super.key, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Drug Details", style: TextStyle(fontSize: 18, color: color, fontFamily: fontFamily, fontWeight: weight700, height: 1.75),),
        centerTitle: true,
      ),

      body: DrugDetailsBody(),
    );
  }
}

class DrugDetailsBody extends StatelessWidget {

  Color color = Color.fromRGBO(17, 24, 39, 1);
  FontWeight weight700 = FontWeight.w700;
  String fontFamily = "Manrope";
  Color contentColor = Color.fromRGBO(75, 85, 99, 1);

  DrugDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                Row(
                  children: <Widget>[
                    Image.network('https://lh3.googleusercontent.com/aida-public/AB6AXuBbgIltdKNPgEOVrGZ6LUPNomvgwP-eZ2GGSkk8lOp_OMbprxiSffBF12XZ_Xi7hZPPCAazP7kUeSDMHJLB1CkqqMg9hHpnRMJIqD31OW9uYdR4bjioOiGPbL0GepTXz9RtR-Mn07D6KD-Pm9V8Py1lh9nxbYUJBhly5DndRTlyWZ9_TkMDOj4q3Qt7KDNfk9TYnaC9-Ac53pagY9vmgqPXeJAtz2XlnXRKoUf0GUJXoDtWmC4NiTZBhtttVCrLqAzL8Ay3MYE7TY8', width: 80, height: 80,),
                    SizedBox(width: 16,),
                    RichText(
                      text: TextSpan(
                        text: "Acetaminophen\n",
                        style: TextStyle(color: color, fontFamily: fontFamily, fontWeight: weight700, fontSize: 24),
                        children: <InlineSpan>[
                          TextSpan(
                            text: "500mg",
                            style: TextStyle(color: Color.fromRGBO(19, 164, 236, 1), fontSize: 18, height: 1.75, fontWeight: FontWeight.w600)
                          )
                        ]
                      ),
                    ),
                    SizedBox(width: 16,),
                  ],
                ),
            
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: "Dosage\n",
                          style: TextStyle(fontSize: 18, color: color, fontFamily: fontFamily, fontWeight: weight700, height: 1.75),
                          children: <InlineSpan> [
                            TextSpan(
                              text: "Take one tablet every 4-6 hours as needed for pain. Do not exceed 6 tablets in 24 hours.",
                              style: TextStyle(fontFamily: fontFamily, color: contentColor, fontSize: 16, fontWeight: FontWeight.normal)
                            )
                          ]
                        )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24,),
        
                Container(
                  padding: EdgeInsetsGeometry.all(16),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(19, 164, 236, 0.1),
                    border: Border(
                      left: BorderSide(
                        color: Color.fromRGBO(19, 164, 236, 1),
                        width: 4
                      )
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16), topRight: Radius.circular(8), bottomRight: Radius.circular(8))
                  ),
                  child: Column(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: "Warnings\n",
                          style: TextStyle(color: color, fontWeight: weight700, fontSize: 18, fontFamily: fontFamily, height: 1.75),
                          children: <InlineSpan> [
                            TextSpan(
                              text: "Severe liver damage may occur if you take more than 4,000 mg of acetaminophen in 24 hours, with other drugs containing acetaminophen, or have 3 or more alcoholic drinks every day while using this product.",
                              style: TextStyle(color: contentColor, fontSize: 16, fontWeight: FontWeight.normal)
                            )
                          ]
                        ),
                      )
                    ],
                  ),
                ),
        
                SizedBox(height: 24,),
        
                RichText(
                  text: TextSpan(
                    text: "Side Effects\n",
                    style: TextStyle(color: color, fontWeight: weight700, fontSize: 18, height: 1.75, fontFamily: fontFamily),
                    children: <InlineSpan> [
                      TextSpan(
                        text: "Common side effects may include nausea, stomach pain, loss of appetite, itching, rash, headache, dark urine, clay-colored stools, or jaundice (yellowing of the skin or eyes).",
                        style: TextStyle(color: contentColor, fontFamily: fontFamily, fontWeight: FontWeight.normal, fontSize: 16),
                      )
                    ]  
                  )
                ),
        
                SizedBox(height: 24,),
        
                Text("Manufacturer", style: TextStyle(color: color, fontWeight: weight700, fontSize: 18, fontFamily: fontFamily, height: 1.75),),
        
                SizedBox(height: 16,),
        
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuA8hVJPxNVCFs4XR3XbFU2hVFRDPA7tcLOsL9u_TF4EH_hkbIUHhdnMHkvaLAueh0nhe14Ndm4IFz4jFHtm7FTF-khHQ_Zcq-6SizZ_tjXzlrjjV-TV5F_RrTGM8J0ZIN1tqGqYxd1O-Jb5IqmUs4ir8N0nuBO0lbcJ-NEj_ePxZ7Qbmg2XEeB_6g8sDXNXrV_uMQcxzzsnW-OSl5Q1uSKL5wDrRJ6Dt4PXTbS--13426oTmK5gIjO58-EUD2klmNACUaaLIfiWubc',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("HealthCorp Pharmaceuticals", style: TextStyle(color: color, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
                  subtitle: Text("A trusted name in healthcare", style: TextStyle(color: Color.fromRGBO(107, 114, 128, 1), fontSize: 14, height: 1.25, fontFamily: fontFamily),),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}