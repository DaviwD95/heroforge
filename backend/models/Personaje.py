from database.base import Base
from sqlalchemy import Column, Integer, String, JSON
from database.base import Base
from sqlalchemy import Column, Integer, String, JSON, Float, Boolean, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from datetime import datetime


#Con esto creo el modelo para subir la tabla a la base de datos


class Personaje(Base):

    __tablename__ = "personajes"

    id = Column(Integer, primary_key=True, index=True)
    id_usuario = Column(Integer, ForeignKey("users.id"), nullable=False)

    # Datos Basico del Personaje

    nombre        = Column(String(100))
    clase         = Column(String(30))
    raza          = Column(String(30))
    trasfondo     = Column(String(30))
    alineamiento  = Column(String(30))

    nombre_jugador = Column(String(100))
    nivel         = Column(Integer, default=1)
    experiencia   = Column(Integer, default=0)
    historia      = Column(String(2000))   
    publicado     = Column(Boolean, default=False)
    fecha_creacion = Column(DateTime, default=datetime.utcnow)

    # Stats: habilidades en cada mbito (sirven para luego las secundarias y tiradas de salvacion)

    fuerza       = Column(Integer, default=10)
    destreza     = Column(Integer, default=10)
    constitucion = Column(Integer, default=10)
    inteligencia = Column(Integer, default=10)
    sabiduria    = Column(Integer, default=10)
    carisma      = Column(Integer, default=10)

    # Atributos para el combate

    clase_armadura    = Column(Integer, default=10)
    puntos_golpe_max  = Column(Integer, default=10)

    # Apariencia
    
    edad      = Column(Integer)
    altura    = Column(Float)
    peso      = Column(Float)
    ojos      = Column(String(50))
    pelo      = Column(String(50))
    piel      = Column(String(50))
    imagen_url = Column(String(255))

    # Personalidad, los guardo como un json, ya que no vale la pena tener 4 tablas extras con fk 
   
    rasgos   = Column(JSON, default=list)
    ideales  = Column(JSON, default=list)
    vinculos = Column(JSON, default=list)
    defectos = Column(JSON, default=list)

    # Habilidadees secundarias como JSON 
    habilidades = Column(JSON, default=dict)

    # Relaciones para poder acceder mas facil a los campos 
    
    ataques   = relationship("Ataque",  back_populates="personaje", cascade="all, delete-orphan")
    hechizos  = relationship("Hechizo", back_populates="personaje", cascade="all, delete-orphan")
    inventario = relationship("Item",   back_populates="personaje", cascade="all, delete-orphan")

