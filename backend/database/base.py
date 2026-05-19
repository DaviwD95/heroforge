
from sqlalchemy.orm import declarative_base
import os
from dotenv import load_dotenv

load_dotenv()

BASE_URL = os.getenv("BASE_URL", "http://localhost:8000")


Base = declarative_base()