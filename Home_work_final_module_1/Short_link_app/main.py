from fastapi import FastAPI, HTTPException
from fastapi.responses import RedirectResponse
import sqlite3, os, random, string

DB_PATH = "/app/data/shorturl.db"

app = FastAPI()

def get_conn():
    os.makedirs("/app/data", exist_ok=True)
    return sqlite3.connect(DB_PATH, check_same_thread=False)

conn = get_conn()
cursor = conn.cursor()
cursor.execute("""
CREATE TABLE IF NOT EXISTS urls (
    short_id TEXT PRIMARY KEY,
    full_url TEXT NOT NULL
)
""")
conn.commit()

def gen_id():
    return ''.join(random.choices(string.ascii_letters + string.digits, k=6))

@app.post("/shorten")
def shorten(data: dict):
    short_id = gen_id()
    cursor.execute(
        "INSERT INTO urls (short_id, full_url) VALUES (?, ?)",
        (short_id, data["url"])
    )
    conn.commit()
    return {"short_id": short_id}

@app.get("/{short_id}")
def redirect(short_id: str):
    row = cursor.execute(
        "SELECT full_url FROM urls WHERE short_id=?", (short_id,)
    ).fetchone()
    if not row:
        raise HTTPException(404)
    return RedirectResponse(row[0])

@app.get("/stats/{short_id}")
def stats(short_id: str):
    row = cursor.execute(
        "SELECT full_url FROM urls WHERE short_id=?", (short_id,)
    ).fetchone()
    if not row:
        raise HTTPException(404)
    return {"short_id": short_id, "full_url": row[0]}