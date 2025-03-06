import jwt
from fastapi import Header, HTTPException

def auth_middlewares(x_auth_token: str = Header()):
     #get the user token from the headers
    try:
        if not x_auth_token:
            raise HTTPException(status_code=401, detail="No auth token, access denied")
        #decode the token
        verified_token = jwt.decode(x_auth_token, 'password_key', ['HS256'])

        if not verified_token:
            raise HTTPException(status_code=401, detail="Token verification failed, authorization denied")
        #get the user id from the token
        uid = verified_token.get('id')
        return {'uid': uid, 'token': x_auth_token}
        #get the user info from the postgres db
        #return the user info 
    except jwt.PyJWTError:
        raise HTTPException(status_code=401, detail="Token verification failed, authorization denied")
    