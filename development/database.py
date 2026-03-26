import psycopg2
from psycopg2 import Error

DB_CONFIG = {
    "dbname": "practika",
    "user": "postgres",
    "password": "0704", 
    "host": "localhost",
    "port": "5432"
}

class DatabaseManager:
    def __init__(self, config):
        self.config = config

    def execute_query(self, query, params=None, fetch=False):
        connection = None
        try:
            connection = psycopg2.connect(**self.config)
            connection.set_client_encoding('UTF8')
            cursor = connection.cursor()
            cursor.execute(query, params)
            
            result = None
            if fetch:
                result = cursor.fetchall()
            
            connection.commit()
            return result
        except Error as e:
            print(f"Ошибка базы данных: {e}")
            raise e
        finally:
            if connection:
                cursor.close()
                connection.close()

    def get_user_by_login(self, login):
        query = 'SELECT "Пароль", "Роль", "Заблокирован", "КоличествоНеудачныхПопыток" FROM public."Пользователи" WHERE "Логин" = %s'
        res = self.execute_query(query, (login,), fetch=True)
        return res[0] if res else None

    def update_user_status(self, login, fails, blocked=False):
        query = 'UPDATE public."Пользователи" SET "КоличествоНеудачныхПопыток" = %s, "Заблокирован" = %s WHERE "Логин" = %s'
        self.execute_query(query, (fails, blocked, login))