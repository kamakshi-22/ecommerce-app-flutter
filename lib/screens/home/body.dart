import 'package:ecommerce_app/models/Product.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:ecommerce_app/utils/textstyles.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            "Women",
            style: AppTextStyles.displayMedium,
          ),
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin),
                itemBuilder: (context, index) {
                  return ItemCard(
                    product: products[index],
                  );
                }),
          ),
        )
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  final Product? product;
  final Function? press;
  const ItemCard({
    super.key,
    this.product,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(kDefaultPaddin),
            decoration: BoxDecoration(
                color: product!.color, borderRadius: BorderRadius.circular(16)),
            child: Image.asset(product!.image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
          child: Text(
            product!.title,
            style: AppTextStyles.bodyMedium,
          ),
        ),
        Text(
          "\$${product!.price}",
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;
  List<String> categories = ["Handbag", "Jewellry", "Footwear", "Dresses"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return buildCategory(index);
            }),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categories[index],
              style: selectedIndex == index
                  ? AppTextStyles.bodyLarge
                      .copyWith(fontWeight: FontWeight.bold)
                  : AppTextStyles.bodyLarge,
            ),
            Container(
              margin: const EdgeInsets.only(top: kDefaultPaddin / 4),
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
