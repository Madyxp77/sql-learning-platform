// assets/js/utils.js

/**
 * @module Utils
 * @description Provides a collection of general-purpose utility functions
 * for DOM manipulation, data handling, and other common tasks within the LMS.
 */

/**
 * Safely gets an HTML element by its ID.
 * Logs an error if the element is not found.
 * @param {string} id The ID of the HTML element.
 * @returns {HTMLElement | null} The found HTML element or null if not found.
 */
function getElementById(id) {
    const element = document.getElementById(id);
    if (!element) {
        console.error(`Error: Element with ID '${id}' not found in the DOM.`);
    }
    return element;
}

/**
 * Safely gets the first HTML element matching a CSS selector.
 * Logs an error if the element is not found.
 * @param {string} selector The CSS selector string.
 * @param {HTMLElement | Document} [parent=document] The parent element to search within.
 * @returns {HTMLElement | null} The found HTML element or null if not found.
 */
function querySelector(selector, parent = document) {
    const element = parent.querySelector(selector);
    if (!element) {
        console.warn(`Warning: Element matching selector '${selector}' not found.`);
    }
    return element;
}

/**
 * Safely gets all HTML elements matching a CSS selector.
 * Returns an empty array if no elements are found.
 * @param {string} selector The CSS selector string.
 * @param {HTMLElement | Document} [parent=document] The parent element to search within.
 * @returns {NodeListOf<HTMLElement>} A NodeList of found HTML elements.
 */
function querySelectorAll(selector, parent = document) {
    return parent.querySelectorAll(selector);
}

/**
 * Creates a new HTML element with optional classes, attributes, and text content.
 * @param {string} tagName The tag name of the element to create (e.g., 'div', 'p', 'button').
 * @param {object} [options={}] An object with properties:
 * @param {string|string[]} [options.classes] One or more class names to add.
 * @param {object} [options.attributes] An object of key-value pairs for attributes (e.g., { id: 'myId', 'data-type': 'example' }).
 * @param {string} [options.textContent] The text content for the element.
 * @param {HTMLElement[]} [options.children] An array of child HTML elements to append.
 * @returns {HTMLElement} The newly created HTML element.
 */
function createElement(tagName, options = {}) {
    const element = document.createElement(tagName);

    if (options.classes) {
        if (Array.isArray(options.classes)) {
            element.classList.add(...options.classes);
        } else {
            element.classList.add(options.classes);
        }
    }

    if (options.attributes) {
        for (const key in options.attributes) {
            if (Object.prototype.hasOwnProperty.call(options.attributes, key)) {
                element.setAttribute(key, options.attributes[key]);
            }
        }
    }

    if (options.textContent) {
        element.textContent = options.textContent;
    }

    if (options.children && Array.isArray(options.children)) {
        options.children.forEach(child => {
            if (child instanceof HTMLElement) {
                element.appendChild(child);
            } else {
                console.warn('Attempted to append a non-HTMLElement child:', child);
            }
        });
    }

    return element;
}

/**
 * Empties all child nodes from a given HTML element.
 * @param {HTMLElement} element The HTML element to empty.
 */
function emptyElement(element) {
    if (element) {
        while (element.firstChild) {
            element.removeChild(element.firstChild);
        }
    }
}

/**
 * Capitalizes the first letter of a string.
 * @param {string} string The input string.
 * @returns {string} The string with its first letter capitalized.
 */
function capitalizeFirstLetter(string) {
    if (typeof string !== 'string' || string.length === 0) {
        return '';
    }
    return string.charAt(0).toUpperCase() + string.slice(1);
}

/**
 * Debounces a function, ensuring it's not called too frequently.
 * Useful for events like resizing or input typing.
 * @param {Function} func The function to debounce.
 * @param {number} delay The debounce delay in milliseconds.
 * @returns {Function} The debounced function.
 */
function debounce(func, delay) {
    let timeout;
    return function(...args) {
        const context = this;
        clearTimeout(timeout);
        timeout = setTimeout(() => func.apply(context, args), delay);
    };
}

/**
 * Throttles a function, ensuring it's called at most once within a given time frame.
 * Useful for scroll or mouse events.
 * @param {Function} func The function to throttle.
 * @param {number} limit The throttle limit in milliseconds.
 * @returns {Function} The throttled function.
 */
function throttle(func, limit) {
    let inThrottle;
    let lastResult;
    return function(...args) {
        const context = this;
        if (!inThrottle) {
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
            lastResult = func.apply(context, args);
        }
        return lastResult;
    };
}

/**
 * Simple data validation function for non-empty strings.
 * @param {string} value The string to validate.
 * @returns {boolean} True if the string is not empty or just whitespace, false otherwise.
 */
function isValidString(value) {
    return typeof value === 'string' && value.trim().length > 0;
}

/**
 * Converts a string to a URL-friendly slug.
 * @param {string} text The input text.
 * @returns {string} The URL slug.
 */
function slugify(text) {
    return text
        .toString()
        .normalize('NFD') // Normalize diacritics
        .replace(/[\u0300-\u036f]/g, '') // Remove diacritics
        .toLowerCase()
        .trim()
        .replace(/\s+/g, '-') // Replace spaces with -
        .replace(/[^\w-]+/g, '') // Remove all non-word chars
        .replace(/--+/g, '-'); // Replace multiple - with single -
}


// Export all utility functions for modular use
export {
    getElementById,
    querySelector,
    querySelectorAll,
    createElement,
    emptyElement,
    capitalizeFirstLetter,
    debounce,
    throttle,
    isValidString,
    slugify
};
