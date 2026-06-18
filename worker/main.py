from db import init_db
import sqlite3
from datetime import datetime

init_db()

conn = sqlite3.connect("/data/app.db")
cursor = conn.cursor()

cursor.execute(
    "INSERT INTO price_snapshot (symbol, price, date) VALUES (?, ?, ?)",
    ("TEST", 100, datetime.utcnow().isoformat())
)

conn.commit()
conn.close()

print("Python worker ran successfully")