from fastapi import HTTPException, APIRouter, Depends, Header
from pydantic_schemas.user_create import UserCreate
from models.user import User 
from pydantic_schemas.user_login import UserLogin
from middleware.auth_middleware import auth_middleware
from sqlalchemy.orm import Session
from database import get_db

import uuid
import bcrypt
import jwt


router = APIRouter()
@router.post("/signup", status_code=201)

# SIGNUP USER API
def signup_user(user: UserCreate, db: Session= Depends(get_db)):
  
    #extract data coming from req
    #check if the user already exist in db

    user_db = db.query(User).filter(User.email == user.email).first()
    if user_db:
        raise HTTPException(status_code=400, detail="User already exist")
    pass
    #if not, create a new user
    hashed_pw = bcrypt.hashpw(user.password.encode('utf-8'), bcrypt.gensalt())  
    user_db = User(id=str(uuid.uuid4()), name=user.name, email=user.email, password= hashed_pw)
    #add user to db
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    pass
    return user_db


# LOGIN USER API

@router.post("/login")
def login_user(user: UserLogin, db: Session= Depends(get_db)):
  
    #extract data coming from req
    #check if the user already exist in db
    user_db = db.query(User).filter(User.email == user.email).first()
    if not user_db:
        raise HTTPException(status_code=400, detail="This user does not exist")
    # check password match
    is_match = bcrypt.checkpw(user.password.encode('utf-8'), user_db.password)
    
    if not is_match:
        raise HTTPException(status_code=400, detail="Invalid credentials")

    token = jwt.encode({'id': user_db.id}, 'password_key')
    return {'token': token, 'user': user_db}

@router.get('/')
def current_user_data(db: Session= Depends(get_db), user_dict: dict = Depends(auth_middleware)):
     
    user = db.query(User).filter(User.id == user_dict['uid']).first()
    # uid = user_dict.get('uid')
    # user = db.query(User).filter(User.id == uid).first()

    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

