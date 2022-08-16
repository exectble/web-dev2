from flask_login import current_user

ID_ADMIN_ROLE = 1
ID_MODERATOR_ROLE = 2
ID_USER_ROLE = 3

def is_admin():
    return current_user.role_id == ID_ADMIN_ROLE


def is_moderator():
    return current_user.role_id == ID_MODERATOR_ROLE


def is_user():
    return current_user.role_id == ID_USER_ROLE



class UsersPolicy:
    def __init__(self, role_id):
        self.role_id = role_id
    
    def create(self):
        return is_admin()


    def delete(self):
        return is_admin()


    def update(self):
        return is_admin() or is_moderator()
