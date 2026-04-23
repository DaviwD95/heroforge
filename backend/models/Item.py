from database.base import Base
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship



class Item(Base):
 
    __tablename__ = "inventario"
 
    id           = Column(Integer, primary_key=True, index=True)
    personaje_id = Column(Integer, ForeignKey("personajes.id"), nullable=False)
 
    nombre      = Column(String(100))
    cantidad    = Column(Integer, default=1)
    peso        = Column(Integer, default=0)   # para calcular carga total — faltaba esto
    descripcion = Column(String(500))          # 100 era poco
 
    personaje = relationship("Personaje", back_populates="inventario")