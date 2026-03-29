
from datetime import timedelta

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
import models.User as User, database.session_users as session_users, services.security as security
from pydantic import BaseModel
from services.email import send_reset_email
import requests


router = APIRouter()

class UserLogin(BaseModel):
    email: str
    password: str

class UserSign(BaseModel):
    email: str
    password: str
    full_name: str

class RememberPassword(BaseModel):
    email: str

class ResetPassword(BaseModel):
    token: str
    new_password: str

class GoogleLogin(BaseModel):
    token: str
    
    


#Metodo para obtener la base de datos:
def get_db_user():

    db = session_users.SessionLocal()
    try:
        yield db
    finally:
        db.close()


        




# Login
@router.post("/login")
def login(data: UserLogin, db: Session = Depends(get_db_user)):

    user = db.query(User.User).filter(User.User.email == data.email).first()

    if not user or not security.verify_password(data.password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Credenciales incorrectas")
    
    token = security.create_access_token({"sub": user.email, "role": user.role})
    return {"access_token": token, "token_type": "bearer"}




#Sign in 
@router.post("/signin")
def sign(data: UserSign, db : Session = Depends(get_db_user)):    

    user = User.User(
        email = data.email,        
        hashed_password=security.hash_password(data.password),
        full_name=data.full_name
        )

    userExistente = db.query(User.User).filter(user.email == User.User.email).first() 

    if userExistente: 
        raise HTTPException(status_code=400, detail="El usuario ya existe")
        
    
    db.add(user)    
    db.commit()
    db.refresh(user)

    return {"message": "Usuario creado"}





@router.post("/remember-password")
async def rememberPassword(data : RememberPassword, db : Session = Depends(get_db_user)):

    user = db.query(User.User).filter( User.User.email == data.email).first()
   

    if not user:
     raise HTTPException(status_code=404, detail="Usuario no encontrado")
    
    
    token = security.create_access_token({"sub" : user.email}, expires_delta=timedelta(minutes=15)) #sub(subject pues) = email 

    await send_reset_email(email=str(user.email),token=token)

    return {"message": "Email enviado"}
    

@router.post("/reset-password")
def reset_password(data: ResetPassword, db: Session = Depends(get_db_user)):

    payload = security.verify_token(data.token)

    if not payload:
        raise HTTPException(status_code=401, detail="Token inválido o expirado")

    email = payload.get("sub")

    user = db.query(User.User).filter(User.User.email == email).first()

    if not user:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")

    
    user.hashed_password = str(security.hash_password(data.new_password))  # type: ignore teoricamente funciona pero es cosa de vs code lo tnego que probar 

    db.commit()

    return {"message": "Contraseña actualizada correctamente"}    

    

