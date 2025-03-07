import uuid
from fastapi import APIRouter, UploadFile, File, Form, Depends
from database import get_db
from middleware.auth_middleware import auth_middlewares
from sqlalchemy.orm import Session
import cloudinary
import cloudinary.uploader
from cloudinary.utils import cloudinary_url


router = APIRouter()


# Configuration       
cloudinary.config( 
    cloud_name = "dfepkxvvu", 
    api_key = "257314624641823", 
    api_secret = "XW1nOOIVzEk7tmUGkN9CJf-8Qxw", # Click 'View API Keys' above to copy your API secret
    secure=True
)

@router.post("/upload")
#to fetch file you can't create a pydantic schema but have to manually parse the request
def upload_song(song: UploadFile = File(...), 
                thumbnail:  UploadFile = File(...), 
                artist: str = Form(...), 
                song_name: str = Form(...), 
                hex_code: str = Form(...), 
                db: Session = Depends(get_db),
                auth_dict = Depends(auth_middlewares) ):
    
        # Upload an songs
        song_id = str(uuid.uuid4())
        song_res = cloudinary.uploader.upload(song.file,resource_type='auto', folder=f"songs/{song_id}")
        print(song_res)

        thumbnail_res = cloudinary.uploader.upload(thumbnail.file,resource_type='image', folder=f"songs/{song_id}")
        print(thumbnail_res)

        #STORE IN DATABASE
        return 'uploaded'
       
                    
        pass