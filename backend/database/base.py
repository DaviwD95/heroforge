
from sqlalchemy.orm import declarative_base
import os


BASE_URL = os.getenv("BASE_URL", "http://localhost:8000")


Base = declarative_base()