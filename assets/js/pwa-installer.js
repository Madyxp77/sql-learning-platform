// assets/js/pwa-installer.js

/**
 * @module PWAInstaller
 * @description This module is responsible for registering the Service Worker
 * for the Progressive Web App (PWA) functionality.
 * It should be imported and called early in your main application logic.
 */

/**
 * Registers the Service Worker.
 * If Service Workers are supported by the browser, it attempts to register
 * the `sw.js` file located at the root of the application.
 *
 * @returns {Promise<ServiceWorkerRegistration|undefined>} A promise that resolves
 * with the ServiceWorkerRegistration object if successful, or undefined if
 * Service Workers are not supported or registration fails.
 */
function registerPwaServiceWorker() {
    // Check if the browser supports Service Workers
    if ('serviceWorker' in navigator) {
        // Use the 'load' event to defer registration until the page is fully loaded.
        // This prevents the Service Worker from competing for bandwidth with other
        // critical resources during the initial page load.
        window.addEventListener('load', () => {
            // Register the service worker.
            // The path '/sw.js' assumes that sw.js is located in the root directory
            // of your web application, which determines its scope.
            navigator.serviceWorker.register('/sw.js')
                .then(registration => {
                    // Service worker registration was successful
                    console.log('PWAInstaller: Service Worker registered successfully with scope:', registration.scope);
                    return registration;
                })
                .catch(error => {
                    // Service worker registration failed
                    console.error('PWAInstaller: Service Worker registration failed:', error);
                    // Return undefined or throw an error to indicate failure
                    return undefined;
                });
        });
    } else {
        console.warn('PWAInstaller: Service Workers are not supported in this browser. Offline features will be unavailable.');
        return Promise.resolve(undefined); // Resolve with undefined if not supported
    }
}

// Export the registration function so it can be called from main.js or other entry points.
export {
    registerPwaServiceWorker
};
