# backend/routers/auth.py
from fastapi import APIRouter, HTTPException, Depends, status, Form
import json
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import jwt, JWTError, ExpiredSignatureError
from datetime import datetime, timedelta
from utils.security import get_current_user, SECRET_KEY, ALGORITHM
from utils.db_utils import connect_to_db

router = APIRouter(tags=["Authentication"])

@router.post("/login")
def login(form_data: OAuth2PasswordRequestForm = Depends()):
    conn = connect_to_db()
    if not conn:
        raise HTTPException(status_code=403, detail="Database connection failed")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE username = %s", (form_data.username,))
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if form_data.username != user[1] or form_data.password != user[2]:
        raise HTTPException(status_code=401, detail="Invalid credentials")

    # Determine role
    role = "admin" if form_data.username == "admin" else "user"

    token = jwt.encode(
        {
            "sub": form_data.username, 
            "exp": datetime.utcnow() + timedelta(hours=1), 
            "role": role
         },
        SECRET_KEY,
        algorithm=ALGORITHM
    )
    return {"access_token": token, "token_type": "bearer", "role": role}

@router.post("/signup")
def signup(username: str = Form(...), password: str = Form(...)):
    """
    Stores a signup request in the temp table with separate columns
    for request type and JSON data (for admin approval).
    """
    conn = connect_to_db()
    if not conn:
        raise HTTPException(status_code=403, detail="Database connection failed")
    cursor = conn.cursor()

    try:
        # Check if username already exists in users
        cursor.execute("SELECT * FROM users WHERE username = %s", (username,))
        existing_user = cursor.fetchone()
        if existing_user:
            raise HTTPException(status_code=400, detail="Username already exists")

        # Build JSON data payload
        data_payload = {
            "username": username,
            "password": password,  # consider hashing later
            "requested_at": datetime.utcnow().isoformat()
        }

        # Insert into temp table
        cursor.execute(
            "INSERT INTO temp (request, data) VALUES (%s, %s)",
            ("approve_user", json.dumps(data_payload))
        )
        conn.commit()

    finally:
        cursor.close()
        conn.close()

    return {"message": "Account request submitted. Waiting for admin approval."}

@router.get("/signupRequests")
def get_signup_requests(current_user: str = Depends(get_current_user)):
    conn = connect_to_db()
    if not conn:
        raise HTTPException(status_code=403, detail="Database connection failed")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM temp WHERE request = %s", ("approve_user",))
    requests = cursor.fetchall()
    cursor.close()
    conn.close()
    return {"signup_requests": requests}

@router.get("/healthCheck")
def health_check(current_user: str = Depends(get_current_user)):
    # If we got here, the token was valid.
    return {"status": "ok", "user": current_user}
