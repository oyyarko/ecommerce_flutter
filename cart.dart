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
