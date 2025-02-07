import 'package:flutter/material.dart';
import 'package:food_delievery_app/constants.dart';

class RestaurantDetails extends StatelessWidget {
  final int index;
  const RestaurantDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            height: 50,
            decoration: BoxDecoration(
              color: kPrimaryColour,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColour.withOpacity(.23),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Order Now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: MainScreen(
          index: index,
        ));
  }
}

class MainScreen extends StatelessWidget {
  final int index;
  const MainScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 50),
      height: he.height,
      width: he.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromARGB(255, 83, 69, 164),
            const Color.fromARGB(255, 66, 53, 165).withOpacity(.8),
            const Color.fromARGB(255, 75, 53, 165).withOpacity(.6),
            const Color.fromARGB(255, 121, 112, 159).withOpacity(.4),
            const Color.fromARGB(255, 70, 53, 165).withOpacity(.2),
            const Color(0xFF6F35A5).withOpacity(.1),
            const Color(0xFF6F35A5).withOpacity(.05),
            const Color(0xFF6F35A5).withOpacity(.025),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopImage(index: index),
            Rating(index: index),
            FoodDescription(index: index),
           MenuItems(restaurantId: index,),
          ],
        ),
      ),
    );
  }
}


class MenuItems extends StatefulWidget {
  final int restaurantId; // Pass the unique restaurant ID

  MenuItems({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  void _increaseQuantity(int index) {
    setState(() {
      restaurantMenus[widget.restaurantId]![index].quantity++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (restaurantMenus[widget.restaurantId]![index].quantity > 0) {
        restaurantMenus[widget.restaurantId]![index].quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var menu = restaurantMenus[widget.restaurantId] ?? [];

    return Column(
      children: [
        for (int i = 0; i < menu.length; i++)
          Container(
            padding: const EdgeInsets.only(top: 6, left: 25, right: 25),
            height: size.height * 0.06,
            width: size.width,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(0.01),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(menu[i].name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
                Row(
                  children: [
                    Text(
                      menu[i].price,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _decreaseQuantity(i),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(216, 245, 205, 236),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${menu[i].quantity}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _increaseQuantity(i),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(216, 245, 205, 236),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
      ],
    );
  }
}

class TopImage extends StatefulWidget {
  final int index;
  const TopImage({super.key, required this.index});

  @override
  State<TopImage> createState() => _TopImageState();
}

class _TopImageState extends State<TopImage> {
  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    return Container(
      height: he.height * 0.3,
      width: he.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        image: DecorationImage(
            image: NetworkImage(restaurantList[widget.index].imageUrl),
            fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Colors.black,
                  ))),
          Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    size: 28,
                    color: Colors.redAccent,
                  ))),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurantList[widget.index].title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  restaurantList[widget.index].locations,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Rating extends StatelessWidget {
  final int index;
  const Rating({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      height: he.height * .1,
      width: he.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Column(
  children: [
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green, // Green background
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Text(
        restaurantList[index].rating, // Place text inside the container
        style: const TextStyle(
          color: Colors.white, // White text for contrast
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    
  ],
),

            const Text(
              "Rating",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              "${restaurantList[index].price} for two",
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              "Delivery Time: 30 min",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class FoodDescription extends StatefulWidget {
  const FoodDescription({super.key, required this.index});
  final int index;
  @override
  State<FoodDescription> createState() => _FoodDescriptionState();
}

class _FoodDescriptionState extends State<FoodDescription> {
  bool _showFullText = false;
  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      width: he.width,
      child: Expanded(
          child: Column(
        children: [
          _showFullText
              ? Text(
                  restaurantList[widget.index].description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Text(
                  restaurantList[widget.index].description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          _buildButton(),
        ],
      )),
    );
  }

  Widget _buildButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            _showFullText = !_showFullText;
          });
        },
        child: Text(_showFullText ? "Show less" : "Show more"));
  }
}