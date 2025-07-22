"""
Enhanced Resume Agent - Main FastAPI Application
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
import os
import logging

# Load environment variables
load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="Enhanced Resume Agent API",
    description="AI-powered resume and cover letter generation service",
    version="1.0.0",
    docs_url="/docs" if os.getenv("ENVIRONMENT", "development") == "development" else None,
    redoc_url="/redoc" if os.getenv("ENVIRONMENT", "development") == "development" else None,
)

# CORS middleware
allowed_origins = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
    "https://*.web.app",
    "https://*.firebaseapp.com",
]

# Allow all origins in development
if os.getenv("ENVIRONMENT", "development") == "development":
    allowed_origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {
        "message": "Enhanced Resume Agent API is running!",
        "version": "1.0.0",
        "status": "healthy",
        "docs": "/docs" if os.getenv("ENVIRONMENT", "development") == "development" else "disabled"
    }

@app.get("/health")
async def health_check():
    return {
        "status": "healthy", 
        "version": "1.0.0",
        "environment": os.getenv("ENVIRONMENT", "development")
    }

@app.get("/api/v1/status")
async def api_status():
    """API status endpoint for monitoring"""
    return {
        "api_status": "operational",
        "version": "1.0.0",
        "endpoints": [
            "/health",
            "/api/v1/status",
            "/docs" if os.getenv("ENVIRONMENT", "development") == "development" else None
        ]
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
