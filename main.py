# main.py
from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordBearer
from fastapi.security import OAuth2PasswordBearer
from pymongo import MongoClient
from bson import ObjectId
from pydantic import BaseModel
from typing import Optional
import jwt
import bcrypt
from datetime import datetime, timedelta

app = FastAPI()

# CORS middleware to allow requests from your iOS app
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, replace with your actual domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# MongoDB connection
client = MongoClient('mongodb://localhost:27017/')
db = client['mediconnect']
users_collection = db['users']

# JWT settings
SECRET_KEY = "your-secret-key"  # In production, use environment variable
ALGORITHM = "HS256"

class UserCreate(BaseModel):
    email: str
    phone: Optional[str] = None
    password: str

class UserLogin(BaseModel):
    email_or_phone: str
    password: str

def create_jwt_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(hours=24)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

@app.post("/register")
async def register(user: UserCreate):
    # Check if user already exists
    if users_collection.find_one({"$or": [
        {"email": user.email},
        {"phone": user.phone}
    ]}):
        raise HTTPException(status_code=400, detail="User already exists")
    
    # Hash the password
    hashed_password = bcrypt.hashpw(user.password.encode('utf-8'), bcrypt.gensalt())
    
    # Create user document
    user_doc = {
        "email": user.email,
        "phone": user.phone,
        "password": hashed_password,
        "created_at": datetime.utcnow()
    }
    
    # Insert into database
    try:
        users_collection.insert_one(user_doc)
        return {"message": "User created successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/login")
async def login(user: UserLogin):
    # Find user by email or phone
    db_user = users_collection.find_one({
        "$or": [
            {"email": user.email_or_phone},
            {"phone": user.email_or_phone}
        ]
    })
    
    if not db_user:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    # Verify password
    if not bcrypt.checkpw(user.password.encode('utf-8'), db_user['password']):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    # Create access token
    token = create_jwt_token({"user_id": str(db_user['_id'])})
    
    return {
        "message": "Login successful",
        "token": token
    }

# Example protected route
async def get_current_user(token: str = Depends(OAuth2PasswordBearer(tokenUrl="login"))):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id = payload.get("user_id")
        if user_id is None:
            raise HTTPException(status_code=401, detail="Invalid token")
    except jwt.PyJWTError:
        raise HTTPException(status_code=401, detail="Invalid token")
    
    user = users_collection.find_one({"_id": ObjectId(user_id)})
    if user is None:
        raise HTTPException(status_code=401, detail="User not found")
    
    return user

@app.get("/protected")
async def protected_route(current_user: dict = Depends(get_current_user)):
    return {"message": "Access granted", "user_email": current_user['email']}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)