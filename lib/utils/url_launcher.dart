import 'package:url_launcher/url_launcher.dart';

Future launcherWebview({
  required Uri url,
}) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: WebViewConfiguration(enableJavaScript: true));
  }
  throw {"Gagal Launcher"};
}
