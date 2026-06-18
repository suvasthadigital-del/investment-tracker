import sqlite3

DB = "/data/app.db"

def init_db():
    conn = sqlite3.connect(DB)
    c = conn.cursor()
    c.execute("""
        CREATE TABLE IF NOT EXISTS price_snapshot (
            id INTEGER PRIMARY KEY,
            symbol TEXT,
            price REAL,
            date TEXT
        )
    """)
    conn.commit()
    conn.close()