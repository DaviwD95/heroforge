from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from database.base import Base
from dotenv import load_dotenv
import os



load_dotenv()
#PARA QUE FUNCIONE TIENE QUE PONAR AQUI SU 
DATABASE_URL = os.getenv("USER_DATABASE_URL")


if DATABASE_URL is None:
    raise ValueError("Error, no hay una base de datos especificada")

engine =create_engine(DATABASE_URL, echo=True)


SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# función para crear la base de datos
def init_db_users():
    
    import models.User as User  
    Base.metadata.create_all(bind=engine)