
from database.base import Base
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship


class Hechizo(Base):
 
    __tablename__ = "hechizos"
 
    id           = Column(Integer, primary_key=True, index=True)
    personaje_id = Column(Integer, ForeignKey("personajes.id"), nullable=False)
 
    nombre      = Column(String(100))
    nivel       = Column(Integer, default=0)   # 0 = truco
    escuela     = Column(String(50))           # evocación, ilusión etc 
    descripcion = Column(String(500))          # 100 era poco
 
    personaje = relationship("Personaje", back_populates="hechizos")