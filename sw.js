// sw.js - Service Worker for The SQL Path LMS

// Define a cache name, good practice to include version for easy cache busting
const CACHE_NAME = 'sql-path-lms-v1';

// List of core assets to pre-cache.
// This includes the main HTML, CSS, JS, and data files that are essential
// for the application to function offline on first load.
const urlsToCache = [
    '/', // Root path, usually maps to index.html
    'index.html',
    'assets/css/style.css',
    'assets/css/theme.css',
    'assets/js/main.js',
    // Core data files for initial database setup or display
    'assets/data/customers.csv',
    'assets/data/orders.csv',
    'assets/data/products.csv',
    // Chapters - we'll initially cache the landing and introduction.
    // Full chapter content will be lazily loaded or added incrementally.
    'chapters/introduction/index.html',
    // Minimal necessary third-party libraries for core functionality (SQL.js, Monaco)
    // In a real scenario, you'd list the actual paths to their main JS/WASM files
    // Assuming they are placed in assets/js/monaco-editor/ and assets/js/sql.js/
    // For now, these are placeholders; full paths would be added in later phases.
    // 'assets/js/sql.js/dist/sql-wasm.js', // Placeholder for SQL.js WASM
    // 'assets/js/sql.js/dist/sql-wasm.wasm', // Placeholder for SQL.js WASM
    // 'assets/js/monaco-editor/min/vs/loader.js', // Placeholder for Monaco Loader
];

// --- Install Event ---
// This event is fired when the service worker is first registered.
// It's typically used to pre-cache essential assets.
self.addEventListener('install', (event) => {
    // waitUntil ensures the service worker is not installed until the
    // promise passed to it resolves successfully.
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => {
                console.log('[Service Worker] Opened cache:', CACHE_NAME);
                // Add all URLs from the urlsToCache array to the cache.
                // If any of these fetches fail, the entire install step fails.
                return cache.addAll(urlsToCache);
            })
            .catch((error) => {
                console.error('[Service Worker] Cache addAll failed:', error);
            })
    );
});

// --- Activate Event ---
// This event is fired when the service worker activates.
// It's a good place to clean up old caches to save space and avoid conflicts
// with new versions of your app.
self.addEventListener('activate', (event) => {
    // Delete any caches that are not the current one.
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== CACHE_NAME) {
                        console.log('[Service Worker] Deleting old cache:', cacheName);
                        return caches.delete(cacheName);
                    }
                    return Promise.resolve();
                })
            );
        }).then(() => {
            console.log('[Service Worker] Activation complete. Old caches cleaned.');
            // Ensure that the service worker takes control of clients immediately
            // after activation. This means the new service worker will manage
            // all open tabs without requiring a page refresh.
            return self.clients.claim();
        })
    );
});

// --- Fetch Event ---
// This event is fired every time the browser requests a resource.
// Here, we implement a "cache-first, then network" strategy.
// This means the service worker will try to serve content from the cache first.
// If not found in cache, it will then try to fetch from the network.
self.addEventListener('fetch', (event) => {
    event.respondWith(
        caches.match(event.request)
            .then((response) => {
                // If the resource is found in the cache, return it.
                if (response) {
                    console.log('[Service Worker] Serving from cache:', event.request.url);
                    return response;
                }
                // If not found in cache, fetch from the network.
                console.log('[Service Worker] Fetching from network:', event.request.url);
                return fetch(event.request)
                    .then((networkResponse) => {
                        // Check if we received a valid response.
                        // (e.g., status 200 OK, not a network error or opaque response)
                        if (!networkResponse || networkResponse.status !== 200 || networkResponse.type !== 'basic') {
                            return networkResponse;
                        }

                        // IMPORTANT: Clone the response. A response is a stream
                        // and can only be consumed once. We need to consume it
                        // once to return it to the browser and once to cache it.
                        const responseToCache = networkResponse.clone();

                        // Open the cache and add the new response.
                        caches.open(CACHE_NAME)
                            .then((cache) => {
                                // Only cache GET requests to avoid caching POST/PUT/DELETE
                                // and dynamic content unless specifically needed.
                                if (event.request.method === 'GET') {
                                    console.log('[Service Worker] Caching new resource:', event.request.url);
                                    cache.put(event.request, responseToCache);
                                }
                            });

                        return networkResponse;
                    })
                    .catch((error) => {
                        console.error('[Service Worker] Fetch failed for:', event.request.url, error);
                        // You can provide a fallback page here for offline scenarios
                        // like a custom offline.html if the fetch completely fails.
                        // For now, it will just let the browser's default offline page appear.
                        // Example: return caches.match('/offline.html');
                    });
            })
    );
});

// --- Push Event (Optional for PWA, for future notifications) ---
// self.addEventListener('push', (event) => { /* ... */ });

// --- Sync Event (Optional for PWA, for background sync) ---
// self.addEventListener('sync', (event) => { /* ... */ });

