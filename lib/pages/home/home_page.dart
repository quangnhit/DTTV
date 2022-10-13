import 'package:dttv/import.dart';
import 'package:dttv/pages/home/home_controller.dart';

class HomePage extends BaseScreen<HomeController> {
  HomePage({super.key});

  @override
  HomeController? putController() => HomeController();

  @override
  Widget builder() {
    return Center(
      child: PageView.builder(
          itemCount: 10,
          onPageChanged: (value) {
            // setState(() {
            //   currentPage = value;
            // });
          },
          controller: controller.pageController,
          itemBuilder: (BuildContext context, int index) {
            var dismissibleKey = GlobalKey<State>();
            return AnimatedBuilder(
              animation: controller.pageController,
              builder: (context, child) {
                double value = 1.0;
                if (controller.pageController.position.haveDimensions) {
                  value = controller.pageController.page! - index;
                  value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
                }

                return Center(
                  child: Container(
                    height: Curves.easeOut.transform(value) * 300,
                    width: Curves.easeOut.transform(value) * 250,
                    child: child,
                  ),
                );
              },
              child: Dismissible(
                key: dismissibleKey,
                direction: DismissDirection.down,
                onDismissed: (DismissDirection direction) {
                  /// Remove item from List
                  // setState(() {
                  //   listItem.removeAt(index);
                  // });
                },
                child: InkWell(
                  onLongPress: () {
                    debugPrint('Delete! $index');
                    // setState(() {
                    //   listItem.removeAt(index);
                    // });
                  },
                  onTap: () {
                    // controller.animateToPage(index,
                    //     duration: Duration(milliseconds: 500), curve: Curves.ease);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    // color: index % 2 == 0 ? Colors.blue : Colors.red,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: color.rdGradientColor,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          tileMode: TileMode.repeated,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            16.0,
                          ),
                        )),
                    child: Center(
                      child: Text('111'),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
