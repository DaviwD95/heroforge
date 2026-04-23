from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from database.base import Base
from dotenv import load_dotenv
import os


load_dotenv()
#PARA QUE FUNCIONE TIENE QUE PONAR AQUI SU 
DATABASE_URL = os.getenv("HEROFORGE_DATABASE_URL")


if DATABASE_URL is None:
    raise ValueError("Error, no hay una base de datos especificada")

engine =create_engine(DATABASE_URL, echo=True)


SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# función para crear la base de datos
def init_db_users():    

    #Las importo para que sean como "reconocidas" de esta manera se crearan las tablas 
    from models.Personaje import Personaje
    from models.Ataques import Ataque
    from models.Hechizos import Hechizo
    from models.Item import Item    
    from models.User import User

    Base.metadata.create_all(bind=engine) #Esto crea las tablas que esten relacionadas con el base (que hereden de ella)