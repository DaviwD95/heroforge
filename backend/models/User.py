from database.base import Base
from sqlalchemy import Column, Integer, String

#Con esto creo el modelo para subir la tabla a la base de datos

class User(Base):

    __tablename__ = "users"
    
    idUsuario = Column(Integer, primary_key= True, index = True, autoincrement = True)
    email = Column(String(255), unique=True, index=True, nullable=False)
    hashed_password = Column(String(255), nullable=True)

    full_name = Column(String(255), nullable=True)
    role = Column(String(255), default="user")  
    




