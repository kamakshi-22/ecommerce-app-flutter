import 'package:ecommerce_app/models/Product.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsBody extends StatelessWidget {
  final Product product;
  const DetailsBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  //height: 500,
                  padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      ColorsAndSize(product: product),
                      SizedBox(
                        height: kDefaultPaddin / 2,
                      ),
                      Description(product: product),
                      SizedBox(
                        height: kDefaultPaddin / 2,
                      ),
                      CounterWithFavBtn(),
                      AddToCart(product: product)
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AddToCart extends StatelessWidget {
  const AddToCart({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(color: product.color)),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/add_to_cart.svg"),
              color: product.color,
            ),
          ),
          Expanded(
            child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: product.color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    onPressed: () {},
                    child: Text("Buy now".toUpperCase(),
                        style: AppTextStyles.titleMedium
                            .copyWith(color: Colors.white)))),
          )
        ],
      ),
    );
  }
}

class CounterWithFavBtn extends StatelessWidget {
  const CounterWithFavBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CartCounter(),
        Container(
          padding: EdgeInsets.all(8.0),
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Colors.pink,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset("assets/icons/heart.svg"),
        )
      ],
    );
  }
}

class CartCounter extends StatefulWidget {
  const CartCounter({super.key});

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildOutlinedButton(
            icon: Icons.remove,
            press: () {
              setState(() {
                if (numOfItems > 1) numOfItems--;
              });
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            numOfItems.toString().padLeft(2, "0"),
            style: AppTextStyles.bodyLarge,
          ),
        ),
        buildOutlinedButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
            }),
      ],
    );
  }

  Widget buildOutlinedButton(
      {required IconData icon, required Function() press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
          style: ButtonStyle(
              padding: MaterialStatePropertyAll(
            EdgeInsets.zero,
          )),
          onPressed: press,
          child: Icon(icon)),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        product.description,
        style: AppTextStyles.bodyMedium,
      ),
    );
  }
}

class ColorsAndSize extends StatelessWidget {
  const ColorsAndSize({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Colors",
                style: AppTextStyles.bodyLarge,
              ),
              Row(
                children: [
                  ColorsDot(
                    color: product.color,
                    isSelected: true,
                  ),
                  ColorsDot(color: Colors.deepOrange),
                  ColorsDot(color: Colors.green),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
              text: TextSpan(children: [
            TextSpan(text: "Size\n", style: AppTextStyles.bodyLarge),
            TextSpan(
                text: "${product.size} cm", style: AppTextStyles.titleLarge)
          ])),
        )
      ],
    );
  }
}

class ColorsDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorsDot({
    super.key,
    required this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(top: kDefaultPaddin / 4, right: kDefaultPaddin / 2),
      padding: EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? color : Colors.transparent)),
      child: DecoratedBox(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    );
  }
}

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aristocratic Hand Bag",
            style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
          ),
          Text(
            product.title,
            style: AppTextStyles.displayLarge.copyWith(color: Colors.white),
          ),
          SizedBox(
            height: kDefaultPaddin / 2,
          ),
          Row(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: "Price\n"),
                TextSpan(
                    text: "\$${product.price}",
                    style: AppTextStyles.displayMedium
                        .copyWith(color: Colors.white)),
              ])),
              SizedBox(
                width: kDefaultPaddin,
              ),
              Expanded(
                  child: Hero(
                      tag: "${product.id}", child: Image.asset(product.image)))
            ],
          )
        ],
      ),
    );
  }
}
