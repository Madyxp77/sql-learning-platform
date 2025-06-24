// assets/js/sql-engine.js

/**
 * @module SQLEngine
 * @description This module handles the core SQL database operations using SQL.js.
 * It is responsible for loading the SQLite database, executing SQL queries,
 * and returning results.
 */

// Global variable to hold the SQL.js database instance
let db = null;
let SQL = null; // Will hold the SQL.js module

/**
 * Dynamically loads the SQL.js library.
 * This version loads SQL.js from the local `assets/js/sql.js/` directory.
 *
 * @returns {Promise<void>} A promise that resolves when SQL.js is loaded.
 */
async function loadSqlJs() {
    if (SQL) {
        console.warn('SQL.js is already loaded.');
        return Promise.resolve();
    }

    console.log('Loading SQL.js from local assets...');
    try {
        // Dynamically import the SQL.js module from your local assets folder.
        // Make sure the path is correct relative to the HTML file that loads main.js.
        const initSqlJs = await import('../../assets/js/sql.js/sql-wasm.js'); // Relative path from a chapter HTML
                                                                             // or 'assets/js/sql.js/sql-wasm.js' if called from index.html directly
                                                                             // For simplicity and assuming most usage will be from chapter pages,
                                                                             // we use the relative path for nested pages.

        SQL = await initSqlJs({
            // Locate the .wasm file relative to where sql-wasm.js is loaded.
            // If sql-wasm.js and sql-wasm.wasm are in the same directory (assets/js/sql.js/),
            // this 'locateFile' function will correctly point to it.
            locateFile: file => `assets/js/sql.js/${file}`
        });
        console.log('SQL.js loaded successfully from local assets.');
    } catch (error) {
        console.error('Failed to load SQL.js:', error);
        throw new Error('Failed to load SQL.js library. Check assets/js/sql.js/ folder.');
    }
}

/**
 * Initializes the SQLite database.
 * This can either create an in-memory database or load from an existing binary file.
 * For this LMS, we'll primarily load from the pre-populated 'databites.db' file.
 *
 * @param {Uint8Array | null} data Optional. A Uint8Array representing a database file.
 * If null, the default 'databites.db' is fetched.
 * @returns {Promise<void>} A promise that resolves when the database is ready.
 */
async function initializeDatabase(data = null) {
    if (!SQL) {
        // Ensure SQL.js is loaded before initializing the database
        await loadSqlJs();
    }

    if (db) {
        console.log('Existing database instance found. Disposing before re-initializing.');
        db.close(); // Close any existing database connection
        db = null;
    }

    try {
        if (data) {
            db = new SQL.Database(data);
            console.log('Database initialized from provided data.');
        } else {
            // If no data provided, try to fetch the default database file
            console.log('Fetching default databites.db...');
            // Path is relative to the root of the website
            const response = await fetch('database/databites.db');
            if (!response.ok) {
                // If fetching the pre-built DB fails, try to build it from schema and inserts
                console.warn('Failed to fetch pre-built databites.db, attempting to build from scratch.');
                await buildDatabaseFromScripts();
                return;
            }
            const buffer = await response.arrayBuffer();
            db = new SQL.Database(new Uint8Array(buffer));
            console.log('Database initialized from databites.db.');
        }
    } catch (error) {
        console.error('Failed to initialize database:', error);
        throw new Error('Database initialization failed.');
    }
}

/**
 * Builds the Databites database from scratch using schema.sql and insert_data.sql.
 * This is a fallback if the pre-built .db file cannot be loaded.
 */
async function buildDatabaseFromScripts() {
    if (!SQL) {
        await loadSqlJs();
    }

    // Create an empty in-memory database
    db = new SQL.Database();
    console.log('Creating new in-memory database.');

    try {
        // Fetch schema.sql (path is relative to the root of the website)
        const schemaResponse = await fetch('database/schema.sql');
        if (!schemaResponse.ok) throw new Error(`Failed to fetch schema.sql: ${schemaResponse.statusText}`);
        const schemaSql = await schemaResponse.text();
        db.run(schemaSql);
        console.log('Schema applied.');

        // Fetch insert_data.sql (path is relative to the root of the website)
        const insertDataResponse = await fetch('database/insert_data.sql');
        if (!insertDataResponse.ok) throw new Error(`Failed to fetch insert_data.sql: ${insertDataResponse.statusText}`);
        const insertDataSql = await insertDataResponse.text();
        db.run(insertDataSql);
        console.log('Initial data inserted.');

        console.log('Database successfully built from scripts.');
    } catch (error) {
        console.error('Failed to build database from scripts:', error);
        // Fallback to a completely empty database if scripts fail, or re-throw
        db = new SQL.Database();
        console.warn('Database could not be built from scripts. An empty database is now active.');
        throw new Error(`Failed to build database from SQL scripts: ${error.message}`);
    }
}


/**
 * Executes a SQL query against the initialized database.
 * Handles both SELECT and DML (INSERT, UPDATE, DELETE) statements.
 *
 * @param {string} sqlQuery The SQL query string to execute.
 * @returns {object} An object containing results:
 * - {Array<Array<any>>} rows: Array of arrays for SELECT statement results.
 * - {Array<string>} columns: Array of column names for SELECT statements.
 * - {number} changes: Number of rows affected for DML statements.
 * - {string} error: Error message if execution fails.
 * - {boolean} isSelect: True if the query was a SELECT statement.
 */
function executeSql(sqlQuery) {
    if (!db) {
        return { error: 'Database not initialized. Please load or build the database first.' };
    }

    // Trim and normalize whitespace
    const normalizedQuery = sqlQuery.trim();

    // Determine if it's a SELECT statement (simplistic check)
    // Case-insensitive check for common DML operations as well.
    const isSelect = normalizedQuery.toUpperCase().startsWith('SELECT');
    const isDML = normalizedQuery.toUpperCase().startsWith('INSERT') ||
                  normalizedQuery.toUpperCase().startsWith('UPDATE') ||
                  normalizedQuery.toUpperCase().startsWith('DELETE');
    const isDDL = normalizedQuery.toUpperCase().startsWith('CREATE') ||
                  normalizedQuery.toUpperCase().startsWith('ALTER') ||
                  normalizedQuery.toUpperCase().startsWith('DROP');


    try {
        if (isSelect) {
            // For SELECT statements, use db.exec to get structured results
            const result = db.exec(normalizedQuery);
            if (result.length > 0) {
                // db.exec returns an array of result objects. For a single SELECT,
                // we usually only care about the first element.
                return {
                    rows: result[0].values,
                    columns: result[0].columns,
                    isSelect: true
                };
            } else {
                // No rows returned (e.g., SELECTing from an empty table, or a valid query that returns no data)
                return {
                    rows: [],
                    columns: [],
                    isSelect: true
                };
            }
        } else if (isDML || isDDL) {
            // For DML/DDL statements, use db.run.
            // db.run is simpler for statements that don't return rows.
            db.run(normalizedQuery);
            // db.getRowsModified() only applies to DML, not DDL.
            const changes = isDML ? db.getRowsModified() : 0;
            return {
                changes: changes,
                isSelect: false,
                message: isDML ? `${changes} row(s) affected.` : 'Command executed successfully.'
            };
        } else {
            // For other commands (e.g., PRAGMA, `.tables` which might be in SQLite shell but not standard SQL)
            // or if the query isn't clearly SELECT, DML, or DDL, just run it.
            db.run(normalizedQuery);
            return {
                changes: 0, // No changes counted for non-DML
                isSelect: false,
                message: 'Command executed successfully.'
            };
        }
    } catch (e) {
        console.error('SQL execution error:', e);
        return { error: e.message };
    }
}

/**
 * Closes the database connection.
 * Important to call when the application is shutting down or changing databases
 * to free up memory.
 */
function closeDatabase() {
    if (db) {
        db.close();
        db = null;
        console.log('Database closed successfully.');
    }
}

// Export functions for use in other modules
export {
    loadSqlJs,
    initializeDatabase,
    buildDatabaseFromScripts, // Expose for specific use cases or debugging
    executeSql,
    closeDatabase
};
