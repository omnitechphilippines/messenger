'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"assets/packages/line_icons/lib/assets/fonts/LineIcons.ttf": "bcaf3ba974cf7900b3c158ca593f4971",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "551fbdd0a87debed9a8e444a6cf7e0d9",
"assets/packages/awesome_notifications/test/assets/images/test_image.png": "c27a71ab4008c83eba9b554775aa12ca",
"assets/AssetManifest.bin": "c2f673527d7d21a6ab3621047d4192ab",
"assets/fonts/SFProText-Regular.ttf": "85bd46c1cff02c1d8360cc714b8298fa",
"assets/fonts/MaterialIcons-Regular.otf": "1e88a56ebd7be6a2316cf52993ee555d",
"assets/fonts/SFProText-Medium.ttf": "a260cbc18870da144038776461d9df28",
"assets/fonts/SFProText-Bold.ttf": "d6079ef01292c4bc84dce33988641530",
"assets/AssetManifest.json": "4d0521c2a2d6ef25e0ff7f685bea437f",
"assets/FontManifest.json": "1b76d4088174aafa8784afb353aec1d0",
"assets/assets/images/handcuffs.png": "cb582d6701e2821850000da5e546186c",
"assets/assets/images/logo.png": "e40ed8cbde988e7813bb6b65b2e220af",
"assets/assets/images/persons/william-david.jpg": "bb8309a5630a80a152cff9806ba2f9b0",
"assets/assets/images/persons/v%25C3%25A4in%25C3%25B6-huotari.png": "9f9d5554c7f6d31ef66806615ddc252d",
"assets/assets/images/persons/alisa-niva.jpg": "31e047f39b8fef4bf7d92eab71d08366",
"assets/assets/images/persons/necati-nalbanto%25C4%259Flu.jpg": "e89022feb98cc08cf4886a2297f322ee",
"assets/assets/images/persons/helena-wirth.jpg": "c46df603f7ccfe6228349d6f92858874",
"assets/assets/images/persons/sol%25C3%25A8ne-lemaire.jpg": "52ddbad0a792523b2e9f9b0a390da26b",
"assets/assets/images/persons/sheryl-carr.jpg": "7004fabbdb67e146f09a72497c6a75cb",
"assets/assets/images/persons/my-day.png": "8be70e9aadc1c9f60ba702103a867e84",
"assets/assets/images/persons/julia-cano.jpg": "9bf3916588af86636cd9ca30d6cb3c0f",
"assets/assets/images/persons/rick-rolland.webp": "91d42dcc32543b9c4b6b966326099ad0",
"assets/assets/images/persons/sarina-koti.jpg": "7e46e8671823334f540c3d9a61949a22",
"assets/assets/images/persons/melissa-fleming.png": "b927791bc3eedfc238c1a454051ae5be",
"assets/assets/images/persons/romnick-mua%25C3%25B1a.png": "ca04b9f5c74a04821f9766b033a142c1",
"assets/assets/images/high-five.png": "cf5f7f7fcbeffeeceee572e8524e54b5",
"assets/assets/images/map.png": "0e4572e1e8b960d98b9b80e9cf169b37",
"assets/assets/images/network.png": "1ca20b856937757ac10859a58a2c0219",
"assets/assets/images/ph-flag.webp": "803e55650f31f688ff3d146571a0e387",
"assets/assets/lotties/loader.json": "9d9d1885d3cb4acfa6edac4a52bd11a7",
"assets/assets/lotties/wave.json": "a2abcf405a441fe3ea194398a6e60428",
"assets/assets/lotties/lock.json": "58bb291ad30e4ffe9f26d676896467c0",
"assets/NOTICES": "021749676c0a20adb08a8c65c6b97729",
"assets/AssetManifest.bin.json": "d6fc35b156b63b964ebc5db2d2ed8782",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"manifest.json": "8af759d4516e2eeb072ea6f93a3dce3e",
"index.html": "f9028ca42399863b30bf7dd2f9709ccf",
"/": "f9028ca42399863b30bf7dd2f9709ccf",
"version.json": "b49362e1787f5bad1d6c9115b44ad102",
"flutter_bootstrap.js": "1481b90c010b3ffb4c5143337f9b741c",
"main.dart.js": "e942e4c8057f82be598da70a79ae93a1",
"favicon.png": "e40ed8cbde988e7813bb6b65b2e220af"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
