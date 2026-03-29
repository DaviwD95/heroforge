


from passlib.context import CryptContext
from datetime import datetime, timedelta
from jose import jwt

from dotenv import load_dotenv
import os

load_dotenv()

# hashing
pwd_context = CryptContext(schemes=["argon2"], deprecated="auto")

SECRET_KEY = os.getenv("SECRET_KEY")  # Tengo aun que crear un  .env un archivo apafte con la clave
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60




#Para cifrar y comprobar
def hash_password(password: str):
    return pwd_context.hash(password)

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

#Para los tokens de acceso

def create_access_token(data: dict, expires_delta: timedelta | None = None):
    
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    to_encode.update({"exp": expire})

    if SECRET_KEY is None:
        raise ValueError("SECRET_KEY no está definida en el archivo .env")

    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM) #jwt es para crear el token 

#Verifico el token 
def verify_token(token: str):

    try:

        #Si no pongo el if se queja porque puede no esta definido 

        if SECRET_KEY is None:
            raise ValueError("SECRET_KEY no está definida en el archivo .env")
        
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload

    except Exception:
        return None