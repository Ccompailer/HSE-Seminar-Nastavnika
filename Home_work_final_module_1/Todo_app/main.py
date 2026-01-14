from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import sqlite3
import os

DB_PATH = "/app/data/todo.db"

app = FastAPI()

def get_conn():
    os.makedirs("/app/data", exist_ok=True)
    return sqlite3.connect(DB_PATH, check_same_thread=False)

conn = get_conn()
cursor = conn.cursor()
cursor.execute("""
CREATE TABLE IF NOT EXISTS items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    completed BOOLEAN NOT NULL
)
""")
conn.commit()

class Item(BaseModel):
    title: str
    description: str | None = None
    completed: bool = False

@app.post("/items")
def create_item(item: Item):
    cursor.execute(
        "INSERT INTO items (title, description, completed) VALUES (?, ?, ?)",
        (item.title, item.description, item.completed)
    )
    conn.commit()
    return {"id": cursor.lastrowid, **item.dict()}

@app.get("/items")
def get_items():
    return cursor.execute("SELECT * FROM items").fetchall()

@app.get("/items/{item_id}")
def get_item(item_id: int):
    row = cursor.execute(
        "SELECT * FROM items WHERE id=?", (item_id,)
    ).fetchone()
    if not row:
        raise HTTPException(404)
    return row

@app.put("/items/{item_id}")
def update_item(item_id: int, item: Item):
    cursor.execute(
        "UPDATE items SET title=?, description=?, completed=? WHERE id=?",
        (item.title, item.description, item.completed, item_id)
    )
    conn.commit()
    return {"id": item_id, **item.dict()}

@app.delete("/items/{item_id}")
def delete_item(item_id: int):
    cursor.execute("DELETE FROM items WHERE id=?", (item_id,))
    conn.commit()
    return {"status": "deleted"}