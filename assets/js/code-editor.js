// assets/js/code-editor.js

/**
 * @module CodeEditor
 * @description Handles the loading, initialization, and interaction with the Monaco Editor.
 * This module provides functions to create a new SQL editor instance,
 * set/get its content, and configure basic editor settings.
 */

// Define a global variable for the Monaco editor instance to be accessible
let monacoEditorInstance = null;
let monacoLoaded = false;

/**
 * Dynamically loads the Monaco Editor library.
 * This version loads Monaco from the local `assets/js/monaco-editor/` directory.
 *
 * @returns {Promise<void>} A promise that resolves when Monaco Editor is loaded.
 */
async function loadMonacoEditor() {
    if (monacoLoaded) {
        console.warn('Monaco Editor is already loaded.');
        return;
    }

    console.log('Loading Monaco Editor from local assets...');

    return new Promise((resolve, reject) => {
        // Create a script element for Monaco's AMD loader
        // Adjust the path to where you've placed the 'loader.js' within your assets/js/monaco-editor
        const script = document.createElement('script');
        script.src = 'assets/js/monaco-editor/loader.js'; // Path to the local loader.js
        script.async = true;
        script.onerror = (e) => {
            console.error('Failed to load local Monaco Editor loader:', e);
            reject(new Error('Monaco Editor loader failed to load. Check assets/js/monaco-editor path.'));
        };

        script.onload = () => {
            // Once the loader is loaded, require the editor core
            // Set the base path for Monaco modules to your local 'vs' directory
            require.config({ paths: { 'vs': 'assets/js/monaco-editor/vs' } }); // Path to the local 'vs' folder inside monaco-editor
            require(['vs/editor/editor.main'], () => {
                monacoLoaded = true;
                console.log('Monaco Editor loaded successfully from local assets.');
                resolve();
            });
        };

        document.head.appendChild(script);
    });
}

/**
 * Initializes the Monaco Editor in a specified DOM element.
 * Call this after `loadMonacoEditor()` has resolved.
 *
 * @param {HTMLElement | string} containerId The DOM element or its ID where the editor will be rendered.
 * @param {string} initialContent The initial SQL content for the editor.
 * @param {string} theme The editor theme ('vs-light' or 'vs-dark').
 * @returns {object} The initialized Monaco Editor instance.
 */
function initializeMonacoEditor(containerId, initialContent = '', theme = 'vs-light') {
    if (!monacoLoaded || typeof monaco === 'undefined') {
        console.error('Monaco Editor is not loaded. Call loadMonacoEditor() first.');
        return null;
    }

    const containerElement = typeof containerId === 'string' ? document.getElementById(containerId) : containerId;

    if (!containerElement) {
        console.error('Monaco Editor container element not found:', containerId);
        return null;
    }

    // Ensure the editor instance is destroyed if it already exists in the container
    if (monacoEditorInstance) {
        monacoEditorInstance.dispose();
        monacoEditorInstance = null;
    }

    // Create the editor instance
    monacoEditorInstance = monaco.editor.create(containerElement, {
        value: initialContent,
        language: 'sql', // Set language to SQL for syntax highlighting
        theme: theme, // Set the theme (e.g., 'vs-light', 'vs-dark')
        automaticLayout: true, // Automatically adjust layout upon container resize
        minimap: {
            enabled: false // Disable the minimap for a cleaner look
        },
        fontSize: 14, // Default font size
        scrollBeyondLastLine: false, // Don't allow scrolling past the last line
        readOnly: false, // Allow user input
        tabSize: 4,
        insertSpaces: true,
        wordWrap: 'on', // Wrap long lines
        // Basic auto-completion for SQL (Monaco has built-in support for many languages)
        quickSuggestions: {
            strings: true,
            other: true,
            comments: false,
            functions: true,
            keywords: true,
            variables: false
        },
        // Remove unwanted features for a learning environment
        // contextmenu: false, // Disable right-click context menu if desired
        // lineNumbers: 'off', // Show line numbers
        // folding: false,
        // glyphMargin: false,
        // codeLens: false,
    });

    console.log('Monaco Editor initialized successfully in:', containerId);
    return monacoEditorInstance;
}

/**
 * Gets the current content of the Monaco Editor.
 * @returns {string} The current SQL query string in the editor.
 */
function getEditorContent() {
    if (monacoEditorInstance) {
        return monacoEditorInstance.getValue();
    }
    console.warn('Monaco Editor instance not found. Cannot get content.');
    return '';
}

/**
 * Sets the content of the Monaco Editor.
 * @param {string} content The SQL query string to set.
 */
function setEditorContent(content) {
    if (monacoEditorInstance) {
        monacoEditorInstance.setValue(content);
    } else {
        console.warn('Monaco Editor instance not found. Cannot set content.');
    }
}

/**
 * Sets the editor to read-only mode.
 * @param {boolean} readOnly If true, sets the editor to read-only.
 */
function setEditorReadOnly(readOnly) {
    if (monacoEditorInstance) {
        monacoEditorInstance.updateOptions({ readOnly: readOnly });
    } else {
        console.warn('Monaco Editor instance not found. Cannot set read-only mode.');
    }
}

/**
 * Disposes the Monaco Editor instance to free up resources.
 * Important to call when the editor is no longer needed (e.g., navigating away from a page).
 */
function disposeEditor() {
    if (monacoEditorInstance) {
        monacoEditorInstance.dispose();
        monacoEditorInstance = null;
        console.log('Monaco Editor instance disposed.');
    }
}

/**
 * Adjusts the layout of the Monaco Editor. Useful when the container size changes.
 */
function resizeEditor() {
    if (monacoEditorInstance) {
        monacoEditorInstance.layout();
    }
}

// Export functions for use in other modules
export {
    loadMonacoEditor,
    initializeMonacoEditor,
    getEditorContent,
    setEditorContent,
    setEditorReadOnly,
    disposeEditor,
    resizeEditor
};

