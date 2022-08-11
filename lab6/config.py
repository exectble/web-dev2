import os

SECRET_KEY = b'\xeal\xcf]\xfftx\xec\xadb\xd7\xa8S\xd4i\x82'
MYSQL_USER = 'std_1947_lab6'
MYSQL_HOST = 'std-mysql.ist.mospolytech.ru'
MYSQL_DATABASE = 'std_1947_lab6'
MYSQL_PASSWORD = 'webwebweb'

SQLALCHEMY_DATABASE_URI = 'mysql+mysqlconnector://std_1947_lab6:webwebweb@std-mysql.ist.mospolytech.ru/std_1947_lab6'
# SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(os.path.dirname(os.path.abspath(__file__)), 'develop.db')
SQLALCHEMY_TRACK_MODIFICATIONS = False

UPLOAD_FOLDER = os.path.join(
    os.path.dirname(os.path.abspath(__file__)), 
    'media/images'
)