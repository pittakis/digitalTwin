from fastapi import UploadFile, File, Response, APIRouter
from fastapi.responses import JSONResponse
import os

router = APIRouter()

MODEL_PATH = "saved_model.glb"

@router.get("/model")
def get_model():
    if os.path.exists(MODEL_PATH):
        with open(MODEL_PATH, "rb") as f:
            return Response(content=f.read(), media_type="model/gltf-binary")
    return JSONResponse(content={"detail": "No model found"}, status_code=404)

@router.post("/upload")
async def upload_model(file: UploadFile = File(...)):
    contents = await file.read()
    with open(MODEL_PATH, "wb") as f:
        f.write(contents)
    return {"message": "Model saved"}
