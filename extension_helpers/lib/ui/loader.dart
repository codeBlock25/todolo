part of 'ui.dart';

buildLoader(BuildContext context, {Brightness? brightness = Brightness.light}) {
  Get.defaultDialog(
    title: 'Loading...',
    backgroundColor: Colors.white,
    barrierDismissible: false,
    titleStyle: context.textTheme.headlineMedium,
    content: Center(
      child: SizedBox(
        width: 100.cl(80, 1000),
        child: LinearProgressIndicator(
          backgroundColor: Colors.black38,
          color: context.theme.primaryColor,
        ),
      ),
    ),
  );
}
