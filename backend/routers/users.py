# backend/routers/users.py
from fastapi import APIRouter, HTTPException, Depends
from utils.security import get_current_user
from utils.db_utils import connect_to_db
import json
from pydantic import BaseModel

router = APIRouter(tags=["Users"])


@router.get("/getAllUsers")
def get_users(current_user: str = Depends(get_current_user)):
    conn = connect_to_db()
    if not conn:
        raise HTTPException(status_code=403, detail="Database connection failed")
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT id, username FROM users ORDER BY id")
        users = [{"id": u[0], "username": u[1]} for u in cursor.fetchall()]
        # Pending approval users from temp table
        cursor.execute("SELECT id, data FROM temp WHERE request='approve_user'")
        pending = [{"id": t[0], **(json.loads(t[1]) if isinstance(t[1], str) else t[1])} for t in cursor.fetchall()]
        return {"users": users, "pending": pending}
    finally:
        cursor.close()
        conn.close()

class UserAction(BaseModel):
    temp_id: int
    approve: bool

@router.post("/users/action")
def user_action(action: UserAction, current_user: str = Depends(get_current_user)):
    conn = connect_to_db()
    if not conn:
        raise HTTPException(status_code=403, detail="Database connection failed")
    cursor = conn.cursor()
    try:
        cursor.execute(
            "SELECT data FROM temp WHERE id = %s AND request='approve_user'",
            (action.temp_id,)
        )
        row = cursor.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="User request not found")

        # Convert to dict if it's a JSON string
        user_data = row[0]
        if isinstance(user_data, str):
            user_data = json.loads(user_data)

        if action.approve:
            # Insert into users table
            cursor.execute(
                "INSERT INTO users (username, password, building_id) VALUES (%s, %s, 1)",
                (user_data["username"], user_data["password"])
            )

        # Remove from temp table
        cursor.execute("DELETE FROM temp WHERE id = %s", (action.temp_id,))
        conn.commit()
        return {"success": True}

    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()

class DeleteUserRequest(BaseModel):
    user_id: int
    username: str

@router.post("/users/delete")
def delete_user(request: DeleteUserRequest, current_user: str = Depends(get_current_user)):
    # Optional: prevent deleting yourself
    if current_user == "admin":
        pass  # allow admin to delete anyone

    if current_user == request.username:
        return {"success": False, "message": "Cannot delete yourself"}
    conn = connect_to_db()
    if not conn:
        raise HTTPException(status_code=403, detail="Database connection failed")
    cursor = conn.cursor()
    try:
        # Check if user exists
        cursor.execute("SELECT id FROM users WHERE id = %s", (request.user_id,))
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail="User not found")

        # Delete user
        cursor.execute("DELETE FROM users WHERE id = %s", (request.user_id,))
        conn.commit()
        return {"success": True, "message": "User deleted successfully"}
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()
