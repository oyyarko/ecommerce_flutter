import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              top : 25.0,
              bottom : 10.0
            ),
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.red, Colors.red],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
            ),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  elevation: 8.0,
                  child: Container(
                    height: 160.0,
                    width: 160.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontFamily: "Signatra"
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
            ),
            child: Column(
              children: [
                //1
                ListTile(
                  leading: Icon(Icons.home, color: Colors.red,),
                  title: Text("Home", style: TextStyle(color: Colors.grey),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c) => StoreHome());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.grey, thickness: 0.5,),
                //2
                ListTile(
                  leading: Icon(Icons.shopping_bag, color: Colors.red,),
                  title: Text("My Orders", style: TextStyle(color: Colors.grey),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c) => MyOrders());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.grey, thickness: 0.5,),
                //3
                ListTile(
                  leading: Icon(Icons.shopping_basket, color: Colors.red,),
                  title: Text("My Cart", style: TextStyle(color: Colors.grey),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c) => CartPage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.grey, thickness: 0.5,),
                //4
                ListTile(
                  leading: Icon(Icons.search, color: Colors.red,),
                  title: Text("Search", style: TextStyle(color: Colors.grey),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c) => SearchProduct());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.grey, thickness: 0.5,),
                //5
                ListTile(
                  leading: Icon(Icons.add, color: Colors.red,),
                  title: Text("Add New Address", style: TextStyle(color: Colors.grey),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c) => AddAddress());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.grey, thickness: 0.5,),

                //6
                ListTile(
                  leading: Icon(Icons.remove, color: Colors.red,),
                  title: Text("Logout", style: TextStyle(color: Colors.grey),),
                  onTap: (){
                    EcommerceApp.auth.signOut().then((c){
                      Route route = MaterialPageRoute(builder: (c) => AuthenticScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
