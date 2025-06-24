// assets/js/main.js

/**
 * @module Main Application Logic
 * @description This module initializes the core functionalities of the SQL Learning Platform.
 * It includes theme toggling, service worker registration, and other global setups.
 */

// Import necessary modules
// No imports yet as code-editor.js, sql-engine.js, etc., will be used on chapter pages.
// This main.js handles global application features like theme and PWA.

/**
 * Toggles between dark and light themes.
 * Stores the user's preference in localStorage.
 */
function setupThemeToggle() {
    const themeToggleBtn = document.getElementById('theme-toggle');
    if (!themeToggleBtn) {
        console.error('Theme toggle button not found.');
        return;
    }

    const htmlElement = document.documentElement; // The <html> element

    // Function to set the theme
    const setTheme = (theme) => {
        htmlElement.setAttribute('data-theme', theme);
        localStorage.setItem('theme', theme);
        // Update the icon based on the theme
        const iconSpan = themeToggleBtn.querySelector('.icon');
        if (iconSpan) {
            iconSpan.textContent = theme === 'dark' ? '☀️' : '💡'; // Sun for dark, Lightbulb for light
            themeToggleBtn.setAttribute('aria-label', theme === 'dark' ? 'Switch to light theme' : 'Switch to dark theme');
        }
    };

    // Get the saved theme preference from localStorage or default to 'light'
    const savedTheme = localStorage.getItem('theme') || 'light';
    setTheme(savedTheme); // Apply the saved or default theme immediately

    // Add event listener to the button
    themeToggleBtn.addEventListener('click', () => {
        const currentTheme = htmlElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        setTheme(newTheme);
        console.log(`Theme switched to: ${newTheme}`);
    });
}

/**
 * Registers the Service Worker for PWA functionality.
 * This enables offline capabilities and allows the app to be "installed" on devices.
 */
function registerServiceWorker() {
    if ('serviceWorker' in navigator) {
        window.addEventListener('load', () => {
            // Register the service worker from the root of the application
            // The scope defaults to the directory containing the service worker.
            navigator.serviceWorker.register('/sw.js')
                .then(registration => {
                    console.log('Service Worker registered with scope:', registration.scope);
                })
                .catch(error => {
                    console.error('Service Worker registration failed:', error);
                });
        });
    } else {
        console.warn('Service Workers are not supported by this browser.');
    }
}

/**
 * Sets the current year in the footer.
 */
function setFooterCurrentYear() {
    const yearSpan = document.getElementById('current-year');
    if (yearSpan) {
        yearSpan.textContent = new Date().getFullYear();
    }
}

/**
 * Initializes all core application functionalities when the DOM is fully loaded.
 */
document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM Content Loaded. Initializing application...');

    setupThemeToggle();
    registerServiceWorker(); // Call this here to ensure it runs when the page loads
    setFooterCurrentYear();

    console.log('Application initialization complete.');
});

// Any other global helper functions or event listeners can go here.

