final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).displayResult(0);
  }
  
  ________________________________
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: new IconButton(
          icon: new Icon(
            FontAwesomeIcons.arrowLeft,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w700),
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: new Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFFF9D29),
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Consumer2<TotalAmount, CartItemCounter>(
          builder: (context, amountProvider, cartProvider, c) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: InkWell(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Amount: ",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      r"₹ ",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${amountProvider.totalAmount.toString()}",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Consumer2<TotalAmount, CartItemCounter>(
            builder: (context, amountProvider, cartProvider, c) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection("products")
                                    .where("productId",
                                    whereIn: GrayBird.sharedPreferences
                                        .getStringList(GrayBird.userCartList))
                                    .snapshots(),
                                builder: (BuildContext c,
                                    AsyncSnapshot<QuerySnapshot> snap) {
                                  return !snap.hasData
                                      ? CircularProgressIndicator()
                                      : snap.data.documents.length == 0
                                      ? beginBuildingCart()
                                      : ListView.builder(
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snap.hasData
                                        ? snap.data.documents.length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      ItemModel model =
                                      ItemModel.fromJson(snap.data
                                          .documents[index].data);

                                      if (index == 0) {
                                        totalAmount = 0;
                                        totalAmount =
                                            model.price + totalAmount;
                                      } else {
                                        totalAmount =
                                            model.price + totalAmount;
                                      }

                                      if (snap.data.documents.length -
                                          1 ==
                                          index) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((t) {
                                          Provider.of<TotalAmount>(
                                              context,
                                              listen: false)
                                              .displayResult(
                                              totalAmount);
                                        });
                                      }
                                      return sourceInfo(model, context,
                                          removeCartFunction: () =>
                                              removeItemFromUserCart(
                                                  model.productId,
                                                  context));
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
    );
  }



__________________________________

body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: StreamBuilder(
                            stream: Firestore.instance
                                .collection("products")
                                .where("category", isEqualTo: itemHolder)
                                .snapshots(),
                            builder: (BuildContext c,
                                AsyncSnapshot<QuerySnapshot> snap) {
                              return !snap.hasData
                                  ? CircularProgressIndicator()
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        ItemModel model = ItemModel.fromJson(
                                            snap.data.documents[index].data);
                                        //    print(itemHolder);
                                        //    print(snap.data.documents.length);
                                        return sourceInfo(model, context);
                                      },
                                      itemCount: snap.data.documents.length,
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
