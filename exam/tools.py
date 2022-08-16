from models import Cover, Book
import hashlib
from werkzeug.utils import secure_filename
import os
import uuid
from app import app, db

class ImageServer:
    def __init__(self, file):
        self.file = file

    def save(self):
        self.img = self.__find_by_md5_hash()
        if self.img is not None:
            return self.img
        file_name = secure_filename(self.file.filename)
        self.img = Cover(id=str(uuid.uuid4()), file_name=file_name, mime_type=self.file.mimetype, md5_hash=self.md5_hash)
        self.file.save(os.path.join(app.config['UPLOAD_FOLDER'], self.img.storage_filename))
        db.session.add(self.img)
        db.session.commit()
        return self.img
    
    def __find_by_md5_hash(self):
        self.md5_hash = hashlib.md5(self.file.read()).hexdigest()
        self.file.seek(0)
        return Cover.query.filter(Cover.md5_hash==self.md5_hash).first()

    def bind_to_object(self, obj):
        self.img.object_type = obj.__tablename__
        self.img.book_id = obj.id
        self.img.active = True
        db.session.add(self.img)
        db.session.commit()

    def delete_img(self, id):
        self.img = Cover.query.get(id)
        os.remove(os.path.join(app.config['UPLOAD_FOLDER'], self.img.storage_filename))
        