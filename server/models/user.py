from models.base import Base
from sqlalchemy import Column,  TEXT, VARCHAR,  LargeBinary

class User(Base):
    __tablename__ = "users" #table name 
    id = Column(TEXT, primary_key=True, index=True)
    name = Column(VARCHAR(100))       
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)