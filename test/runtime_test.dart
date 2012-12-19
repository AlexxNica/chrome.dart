part of harness_browser;

class RuntimeTest {
  Logger logger = new Logger("RuntimeTest");
  
  void main() {
    group('chrome.runtime', () {
      test('lastError', () {
        var lastError = Runtime.lastError;
        logger.fine("lastError = ${lastError}");
        expect(lastError.message.isEmpty, isTrue);
      });
      
      test('id', () {
        String id = Runtime.id;
        logger.fine("id = ${id}");
        expect(id is String, isTrue);
      });
      
      test('getBackgroundPage()', () {
        Runtime runtime = new Runtime();
        runtime.getBackgroundPage().then(expectAsync1((backgroundPage) {
          logger.fine("backgroundPage = ${backgroundPage}");
          logger.fine("backgroundPage = ${backgroundPage.location.href}");

          // Example href would be 
          // chrome-extension://kcphnlopknifelmkjhgnkhmmnnohngpp/_generated_background_page.html 
          expect(backgroundPage is js.Proxy, isTrue);
          expect(backgroundPage.location.href is String, isTrue);
          expect(backgroundPage.location.href.startsWith('chrome-extension://'), isTrue);
          expect(backgroundPage.location.href.endsWith('.html'), isTrue);
        }));
      });
      
      test('getManifest()', () {
        Runtime runtime = new Runtime();
        var manifest = runtime.getManifest();
        logger.fine("manifest = ${manifest}");
        expect(manifest is Map, isTrue);
        expect(manifest["manifest_version"], equals(2));
        expect(manifest["name"], equals("chrome.dart - test"));
        expect(manifest["version"], equals("1"));
        expect(manifest["minimum_chrome_version"], equals("23"));
        expect(manifest.containsKey("app"), isTrue);
        expect(manifest["app"].containsKey("background"), isTrue);
        expect(manifest["app"]["background"].containsKey("scripts"), isTrue);
        expect(manifest["app"]["background"]["scripts"], equals(["main.js"]));
      });
      
      test('getURL(String path)', () {
        Runtime runtime = new Runtime();
        var path = runtime.getURL("some/path");
        logger.fine("getURL = ${path}");
        expect(path is String, isTrue);
        expect(path.startsWith('chrome-extension://'), isTrue);
        expect(path.endsWith('/some/path'), isTrue);
      });
      
//      test('reload()', () {
//        // we pass this or else we would just continue to reload the app. 
//        expect(true, isTrue);
//      });
      
      test('requestUpdateCheck()', () {
        Runtime runtime = new Runtime();
        runtime.requestUpdateCheck().then(expectAsync1((update) {
          logger.fine("update = ${update}");
          
          expect(update is Map, isTrue);
          expect(update.containsKey('status'), isTrue);
          expect(update.containsKey('details'), isTrue);
          expect(update['status'], equals('no_update'));
          expect(update['details'], isNull);
        }));
      });
      
//      test('onStartup(Function listener)', () {   
//        Runtime runtime = new Runtime();
//        runtime.onStartup(expectAsync0(() {
//          expect(true, isTrue);
//        }, 1));
//      });
//      
//      test('onInstalled(Function listener)', () {
//        Runtime runtime = new Runtime();
//        runtime.onInstalled(expectAsync1((Map m) {
//          expect(true, isTrue);
//        }));
//      });
//      
//      test('onSuspend(Function listener)', () {
//        Runtime runtime = new Runtime();
//        runtime.onStartup(expectAsync0(() {
//          expect(true, isTrue);
//        }, 1));
//      });
//      
//      test('onSuspendCanceled(Function listener)', () {
//        Runtime runtime = new Runtime();
//        runtime.onStartup(expectAsync0(() {
//          expect(true, isTrue);
//        }, 1));
//      });
//      
//      test('onUpdateAvailable(Function listener)', () {
//        Runtime runtime = new Runtime();
//        runtime.onUpdateAvailable(expectAsync1((Map m) {
//          expect(true, isTrue);
//        }));
//      });
      
    });
  }
}
