import os
from dotenv import load_dotenv
import psycopg2

load_dotenv()

# Load environment variables
dbname = os.getenv("DB_NAME")
user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
host = os.getenv("DB_HOST")
port = os.getenv("DB_PORT")

def connect_to_db():
    # Database connection
    try:
        conn = psycopg2.connect(
            dbname=dbname,
            user=user,
            password=password,
            host=host,
            port=port
        )
        # print("Database connection established.")
        return conn
    except Exception as e:
        print(f"Error connecting to the database: {e}")