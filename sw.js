const CACHE_NAME = 'balance-scanner-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/manifest.json'
];

// External resources - cache if possible but don't fail if not
const externalResources = [
  'https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@4.11.0/dist/tf.min.js',
  'https://cdn.jsdelivr.net/npm/@tensorflow-models/blazeface@0.0.7/dist/blazeface.js'
];

// Install service worker
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('Opened cache');
        // Cache essential files
        return cache.addAll(urlsToCache).catch((error) => {
          console.error('Failed to cache essential files:', error);
        });
      })
      .then(() => {
        // Try to cache external resources but don't fail if unsuccessful
        return caches.open(CACHE_NAME).then((cache) => {
          return Promise.all(
            externalResources.map(url => 
              fetch(url, { mode: 'cors', cache: 'reload' })
                .then(response => cache.put(url, response))
                .catch(err => console.log('Failed to cache:', url, err))
            )
          );
        });
      })
      .catch((error) => {
        console.error('Cache installation failed:', error);
      })
  );
  self.skipWaiting();
});

// Fetch with network-first strategy for better updates
self.addEventListener('fetch', (event) => {
  // Skip non-GET requests
  if (event.request.method !== 'GET') {
    return;
  }

  event.respondWith(
    fetch(event.request)
      .then((response) => {
        // Check if valid response
        if (!response || response.status !== 200 || response.type === 'error') {
          return response;
        }

        // Clone the response
        const responseToCache = response.clone();
        
        caches.open(CACHE_NAME)
          .then((cache) => {
            // Only cache same-origin requests
            if (event.request.url.startsWith(self.location.origin)) {
              cache.put(event.request, responseToCache);
            }
          })
          .catch(err => console.log('Cache put failed:', err));
        
        return response;
      })
      .catch(() => {
        // If network fails, try cache
        return caches.match(event.request).then(cachedResponse => {
          if (cachedResponse) {
            return cachedResponse;
          }
          // Return a basic offline page or error
          return new Response('Offline - please connect to the internet', {
            status: 503,
            statusText: 'Service Unavailable',
            headers: new Headers({
              'Content-Type': 'text/plain'
            })
          });
        });
      })
  );
});

// Activate and clean up old caches
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log('Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  self.clients.claim();
});
