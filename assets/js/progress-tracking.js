// assets/js/progress-tracking.js

/**
 * @module ProgressTracking
 * @description Manages user progress tracking using localStorage.
 * This includes chapter completion, exercise status, personal notes, and bookmarks.
 */

const STORAGE_PREFIX = 'sqlPathLMS_'; // Prefix for all localStorage keys to avoid conflicts

/**
 * Helper function to safely parse JSON from localStorage.
 * @param {string} key The localStorage key.
 * @param {any} defaultValue The value to return if parsing fails or item is not found.
 * @returns {any} The parsed value or defaultValue.
 */
function getFromLocalStorage(key, defaultValue) {
    try {
        const item = localStorage.getItem(key);
        return item ? JSON.parse(item) : defaultValue;
    } catch (e) {
        console.error(`Error parsing localStorage item for key "${key}":`, e);
        return defaultValue;
    }
}

/**
 * Helper function to safely set JSON to localStorage.
 * @param {string} key The localStorage key.
 * @param {any} value The value to store.
 */
function setToLocalStorage(key, value) {
    try {
        localStorage.setItem(key, JSON.stringify(value));
    } catch (e) {
        console.error(`Error setting localStorage item for key "${key}":`, e);
    }
}

// --- Chapter Progress ---

/**
 * Retrieves the completion status for all chapters.
 * @returns {Object.<string, boolean>} An object where keys are chapter IDs and values are boolean (true if completed).
 */
function getChapterProgress() {
    return getFromLocalStorage(`${STORAGE_PREFIX}chapterProgress`, {});
}

/**
 * Sets the completion status for a specific chapter.
 * @param {string} chapterId The unique ID of the chapter (e.g., 'chapter-01', 'introduction').
 * @param {boolean} isCompleted True if the chapter is completed, false otherwise.
 */
function setChapterCompleted(chapterId, isCompleted) {
    const chapterProgress = getChapterProgress();
    chapterProgress[chapterId] = isCompleted;
    setToLocalStorage(`${STORAGE_PREFIX}chapterProgress`, chapterProgress);
    console.log(`Chapter '${chapterId}' completion set to: ${isCompleted}`);
}

/**
 * Checks if a specific chapter is marked as completed.
 * @param {string} chapterId The unique ID of the chapter.
 * @returns {boolean} True if the chapter is completed, false otherwise.
 */
function isChapterCompleted(chapterId) {
    const chapterProgress = getChapterProgress();
    return !!chapterProgress[chapterId]; // Use !! to ensure boolean return
}

// --- Exercise Progress ---

/**
 * Retrieves the completion status for all exercises.
 * @returns {Object.<string, Object.<string, boolean>>} An object where outer keys are chapter/checkpoint IDs,
 * inner keys are exercise IDs, and values are boolean (true if completed).
 */
function getExerciseProgress() {
    return getFromLocalStorage(`${STORAGE_PREFIX}exerciseProgress`, {});
}

/**
 * Sets the completion status for a specific exercise within a chapter/checkpoint.
 * @param {string} parentId The ID of the parent (chapter or skill checkpoint, e.g., 'chapter-01', 'skill-checkpoint-basic-querying-mastery').
 * @param {string} exerciseId The unique ID of the exercise (e.g., 'exercise-1.1', 'exercise-1').
 * @param {boolean} isCompleted True if the exercise is completed, false otherwise.
 */
function setExerciseCompleted(parentId, exerciseId, isCompleted) {
    const exerciseProgress = getExerciseProgress();
    if (!exerciseProgress[parentId]) {
        exerciseProgress[parentId] = {};
    }
    exerciseProgress[parentId][exerciseId] = isCompleted;
    setToLocalStorage(`${STORAGE_PREFIX}exerciseProgress`, exerciseProgress);
    console.log(`Exercise '${exerciseId}' in '${parentId}' completion set to: ${isCompleted}`);
}

/**
 * Checks if a specific exercise is marked as completed.
 * @param {string} parentId The ID of the parent (chapter or skill checkpoint).
 * @param {string} exerciseId The unique ID of the exercise.
 * @returns {boolean} True if the exercise is completed, false otherwise.
 */
function isExerciseCompleted(parentId, exerciseId) {
    const exerciseProgress = getExerciseProgress();
    return !!(exerciseProgress[parentId] && exerciseProgress[parentId][exerciseId]);
}

// --- Personal Notes ---

/**
 * Retrieves all saved personal notes.
 * @returns {Object.<string, string>} An object where keys are content IDs (e.g., chapter-01-section-sql-basics)
 * and values are the note strings.
 */
function getNotes() {
    return getFromLocalStorage(`${STORAGE_PREFIX}notes`, {});
}

/**
 * Saves a personal note for a specific content ID.
 * @param {string} contentId The unique ID for the content section (e.g., 'chapter-01-intro', 'chapter-02-filtering-where').
 * @param {string} noteText The text of the note.
 */
function saveNote(contentId, noteText) {
    const notes = getNotes();
    notes[contentId] = noteText;
    setToLocalStorage(`${STORAGE_PREFIX}notes`, notes);
    console.log(`Note saved for '${contentId}'.`);
}

/**
 * Retrieves a personal note for a specific content ID.
 * @param {string} contentId The unique ID for the content section.
 * @returns {string} The note text, or an empty string if no note exists.
 */
function getNote(contentId) {
    const notes = getNotes();
    return notes[contentId] || '';
}

/**
 * Deletes a personal note for a specific content ID.
 * @param {string} contentId The unique ID for the content section.
 */
function deleteNote(contentId) {
    const notes = getNotes();
    delete notes[contentId];
    setToLocalStorage(`${STORAGE_PREFIX}notes`, notes);
    console.log(`Note deleted for '${contentId}'.`);
}

// --- Bookmarks / Favorite Topics ---

/**
 * Retrieves all saved bookmarks.
 * @returns {Object.<string, Object>} An object where keys are unique bookmark IDs (e.g., chapter-05-join-types)
 * and values are objects containing { title: string, url: string, timestamp: number }.
 */
function getBookmarks() {
    return getFromLocalStorage(`${STORAGE_PREFIX}bookmarks`, {});
}

/**
 * Adds or updates a bookmark.
 * @param {string} bookmarkId A unique ID for the bookmark (e.g., generated from chapter/section ID).
 * @param {string} title The title of the bookmarked section.
 * @param {string} url The URL to the bookmarked section.
 */
function addBookmark(bookmarkId, title, url) {
    const bookmarks = getBookmarks();
    bookmarks[bookmarkId] = {
        title: title,
        url: url,
        timestamp: Date.now() // Record when it was bookmarked
    };
    setToLocalStorage(`${STORAGE_PREFIX}bookmarks`, bookmarks);
    console.log(`Bookmark added/updated for '${bookmarkId}'.`);
}

/**
 * Removes a bookmark.
 * @param {string} bookmarkId The unique ID of the bookmark to remove.
 */
function removeBookmark(bookmarkId) {
    const bookmarks = getBookmarks();
    delete bookmarks[bookmarkId];
    setToLocalStorage(`${STORAGE_PREFIX}bookmarks`, bookmarks);
    console.log(`Bookmark removed for '${bookmarkId}'.`);
}

// --- Global Progress Management (for future reset functionality) ---

/**
 * Clears all stored user progress, notes, and bookmarks.
 */
function clearAllProgress() {
    localStorage.removeItem(`${STORAGE_PREFIX}chapterProgress`);
    localStorage.removeItem(`${STORAGE_PREFIX}exerciseProgress`);
    localStorage.removeItem(`${STORAGE_PREFIX}notes`);
    localStorage.removeItem(`${STORAGE_PREFIX}bookmarks`);
    console.warn('All user progress data has been cleared from localStorage.');
}


// Export all functions for use in other modules
export {
    getChapterProgress,
    setChapterCompleted,
    isChapterCompleted,
    getExerciseProgress,
    setExerciseCompleted,
    isExerciseCompleted,
    getNotes,
    saveNote,
    getNote,
    deleteNote,
    getBookmarks,
    addBookmark,
    removeBookmark,
    clearAllProgress
};

