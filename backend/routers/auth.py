# backend/routers/auth.py
from fastapi import APIRouter, HTTPException, Depends, status
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

    token = jwt.encode(
        {"sub": form_data.username, "exp": datetime.utcnow() + timedelta(hours=1)},
        SECRET_KEY,
        algorithm=ALGORITHM
    )
    return {"access_token": token, "token_type": "bearer"}

@router.get("/healthCheck")
def health_check(current_user: str = Depends(get_current_user)):
    # If we got here, the token was valid.
    return {"status": "ok", "user": current_user}
