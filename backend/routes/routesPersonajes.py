
from datetime import timedelta
from database.base import BASE_URL as baseUrl
from models.Personaje import Personaje
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
import models.User as User, database.session_heroForge as session_heroForge, services.security as security

#Libreria para poder hacer el get de manera segura
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials

security_scheme = HTTPBearer()


router = APIRouter()

#Metodo para obtener la base de datos:
def get_db_personajes():

    db = session_heroForge.SessionLocal()
    try:
        yield db
    finally:
        db.close()



@router.get("/Personajes/get")
def getPersonajes(db : Session = Depends(get_db_personajes), credentials: HTTPAuthorizationCredentials = Depends(security_scheme)):

    #Primero comprobamos el token

    token = credentials.credentials  

    payload = security.verify_token(token)

    if not payload:
     raise HTTPException(status_code=404,detail="Error,el token no es valido")  

    #Sacamos el email
    email = payload.get("sub")

    user = db.query(User.User).filter(User.User.email == email).first()

    if not user: 
        raise HTTPException(status_code=404, detail="Error, usuario no encontrado")
    

    personajes = db.query(Personaje).filter(Personaje.id_usuario == user.id).all()

    return personajes





