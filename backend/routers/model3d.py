import os
from fastapi import APIRouter, HTTPException
from fastapi.responses import FileResponse

router = APIRouter()

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
IFC_FILE_PATH = os.path.abspath(os.path.join(BASE_DIR, "../../../digitalTwin/fasada_tester.ifc"))

@router.get("/3dmodel")
async def get_3d_model():
    print("Serving IFC file from:", IFC_FILE_PATH)
    print("File exists?", os.path.exists(IFC_FILE_PATH))
    print("Current working directory:", os.getcwd())
    print("__file__ is:", __file__)
    print("BASE_DIR is:", BASE_DIR)

    if not os.path.exists(IFC_FILE_PATH):
        raise HTTPException(status_code=404, detail="IFC file not found.")
    return FileResponse(IFC_FILE_PATH)
