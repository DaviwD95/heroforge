
from database.base import Base
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship


class Ataque(Base):
 
    __tablename__ = "ataques"
 
    id           = Column(Integer, primary_key=True, index=True)
    personaje_id = Column(Integer, ForeignKey("personajes.id"), nullable=False)
 
    nombre = Column(String(100))
    bonus  = Column(Integer, default=0)
    dano   = Column(String(30))   #  "1d6+3" 
    tipo   = Column(String(50))   # contundente, cortante, fuego...
 
    personaje = relationship("Personaje", back_populates="ataques")