import 'package:flutter/material.dart'; 

class Week3 extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Colors.blueGrey,
      ),
      
      backgroundColor: Colors.blueGrey[400],
      
      body: Center(

        child: Padding(
    padding: const EdgeInsets.all(16.0), 
    child: Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            CircleAvatar(
              radius: 80.0,
              backgroundImage: NetworkImage(
                'https://scontent.fbkk7-2.fna.fbcdn.net/v/t39.30808-6/534717511_2216662415428745_4001422181947491038_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=y97QhFtDa0QQ7kNvwGgbTAT&_nc_oc=AdkeiaoZttSgVQDiAwvSF1jCtxmo2UC5z5u8MPUqOupuYNpTB5rTg7yxsbg33dLG87Q&_nc_zt=23&_nc_ht=scontent.fbkk7-2.fna&_nc_gid=-mlFI4S0Sf9dMrJX-mfkaQ&oh=00_AfX_e7ISPiZmL8qX-2KtSCW3Vu6DzLj1Br5e6j88GiYZYA&oe=68AEF0E0',
              ),
            ),

  
            SizedBox(height: 24.0),


            Text(
              'Kanokwan Noppun',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8.0),


            Text(
              '660710689',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),

            SizedBox(height: 5.0),


            Text(
              'เทคโนโลยีสารสนเทศ(IT)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),

             Divider(
              height: 30,
              thickness: 1,
              color: Colors.grey[300],
              indent: 20,
              endIndent: 20,
            ),
            

            SizedBox(height: 30.0),

            Text(
              'sawaddeekub hello:-)', 
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blueGrey,
                letterSpacing: 2.5, 
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'i love to listen to music!', 
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blueGrey,
                letterSpacing: 2.5, 
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'music makes me feel not lonely.', 
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blueGrey,
                letterSpacing: 2.5, 
                fontWeight: FontWeight.bold,
              ),
              ),
              ],
              ),
            ),
          ),
        ),
      ),
    ); 
  }
}