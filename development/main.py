import sys
from PyQt5.QtWidgets import (QApplication, QWidget, QVBoxLayout, QLineEdit, QPushButton, 
                             QLabel, QMessageBox, QGroupBox, QTableWidget, QTableWidgetItem, 
                             QHBoxLayout, QComboBox, QHeaderView)
from PyQt5.QtCore import Qt
from database import DatabaseManager, DB_CONFIG
from widgets import CaptchaPuzzle

PINK_STYLE = """
    QWidget { background-color: #fff5f8; color: #4a4a4a; font-family: 'Segoe UI'; }
    QLineEdit { background-color: white; border: 2px solid #f8bbd0; border-radius: 5px; padding: 5px; }
    QLineEdit:focus { border: 2px solid #f06292; }
    QPushButton { background-color: #f48fb1; color: white; border-radius: 5px; font-weight: bold; border: none; padding: 10px; }
    QPushButton:hover { background-color: #f06292; }
    QPushButton:pressed { background-color: #d81b60; }
    QTableWidget { background-color: white; border: 1px solid #f8bbd0; gridline-color: #f8bbd0; }
    QHeaderView::section { background-color: #f8bbd0; border: 1px solid #fff; padding: 5px; font-weight: bold; }
    QGroupBox { font-weight: bold; border: 2px solid #f8bbd0; border-radius: 8px; margin-top: 10px; }
"""

class AdminWindow(QWidget):
    def __init__(self, db_manager):
        super().__init__()
        self.db = db_manager
        self.setWindowTitle("Мебельная фабрика - Панель Администратора")
        self.setMinimumSize(800, 500)
        self.setStyleSheet(PINK_STYLE)
        self.initUI()

    def initUI(self):
        layout = QVBoxLayout(self)
        self.table = QTableWidget(0, 5)
        self.table.setHorizontalHeaderLabels(["ID", "Логин", "Роль", "Блок", "Попытки"])
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        layout.addWidget(self.table)

        ctrl = QGroupBox("Управление персоналом")
        l_ctrl = QHBoxLayout()
        self.in_l, self.in_p = QLineEdit(), QLineEdit()
        self.in_l.setPlaceholderText("Логин"); self.in_p.setPlaceholderText("Пароль")
        self.c_role = QComboBox(); self.c_role.addItems(["Пользователь", "Администратор"])
        btn_a = QPushButton("Добавить"); btn_a.clicked.connect(self.add_u)
        l_ctrl.addWidget(self.in_l); l_ctrl.addWidget(self.in_p); l_ctrl.addWidget(self.c_role); l_ctrl.addWidget(btn_a)
        ctrl.setLayout(l_ctrl)
        layout.addWidget(ctrl)

        btns = QHBoxLayout()
        b_unl = QPushButton("Снять блокировку"); b_unl.clicked.connect(self.unlock)
        b_ref = QPushButton("Обновить"); b_ref.clicked.connect(self.load)
        btns.addWidget(b_unl); btns.addWidget(b_ref)
        layout.addLayout(btns)
        self.load()

    def load(self):
        try:
            users = self.db.execute_query('SELECT "id_Пользователя", "Логин", "Роль", "Заблокирован", "КоличествоНеудачныхПопыток" FROM public."Пользователи" ORDER BY 1', fetch=True)
            self.table.setRowCount(0)
            for r_idx, row in enumerate(users):
                self.table.insertRow(r_idx)
                for c_idx, val in enumerate(row): self.table.setItem(r_idx, c_idx, QTableWidgetItem(str(val)))
        except: pass

    def add_u(self):
        l, p = self.in_l.text(), self.in_p.text()
        if l and p:
            if self.db.execute_query('SELECT 1 FROM public."Пользователи" WHERE "Логин" = %s', (l,), fetch=True):
                QMessageBox.warning(self, "Ошибка", "Логин занят!")
            else:
                self.db.execute_query('INSERT INTO public."Пользователи" ("Логин", "Пароль", "Роль") VALUES (%s, %s, %s)', (l, p, self.c_role.currentText()))
                self.load()

    def unlock(self):
        curr = self.table.currentRow()
        if curr >= 0:
            uid = self.table.item(curr, 0).text()
            self.db.execute_query('UPDATE public."Пользователи" SET "Заблокирован" = false, "КоличествоНеудачныхПопыток" = 0 WHERE "id_Пользователя" = %s', (uid,))
            self.load()

class LoginWindow(QWidget):
    def __init__(self, db_manager):
        super().__init__()
        self.db = db_manager
        self.setWindowTitle("Мебельная фабрика - Авторизация")
        self.setFixedSize(400, 620)
        self.setStyleSheet(PINK_STYLE)
        self.initUI()

    def initUI(self):
        layout = QVBoxLayout(self)
        title = QLabel("МЕБЕЛЬНАЯ ФАБРИКА"); title.setAlignment(Qt.AlignCenter)
        title.setStyleSheet("font-size: 20px; font-weight: bold; color: #d81b60; margin-bottom: 10px;")
        layout.addWidget(title)

        self.edit_l = QLineEdit(); self.edit_l.setPlaceholderText("Логин")
        self.edit_p = QLineEdit(); self.edit_p.setPlaceholderText("Пароль")
        self.edit_p.setEchoMode(QLineEdit.Password)
        
        layout.addWidget(QLabel("Логин:")); layout.addWidget(self.edit_l)
        layout.addWidget(QLabel("Пароль:")); layout.addWidget(self.edit_p)
        layout.addWidget(QLabel("Соберите пазл:")); self.cap = CaptchaPuzzle(); layout.addWidget(self.cap)

        btn = QPushButton("ВОЙТИ"); btn.clicked.connect(self.auth)
        layout.addWidget(btn)

    def auth(self):
        l, p = self.edit_l.text(), self.edit_p.text()
        if not l or not p:
            QMessageBox.warning(self, "Ошибка", "Поля Логин и Пароль обязательны!")
            return

        user = self.db.get_user_by_login(l)
        if not user:
            QMessageBox.warning(self, "Ошибка", "Вы ввели неверный логин или пароль. Пожалуйста проверьте ещё раз введенные данные")
            return

        pw, role, block, fails = user
        if block:
            QMessageBox.critical(self, "Блок", "Вы заблокированы. Обратитесь к администратору")
            return

        if p == pw and self.cap.is_correct():
            self.db.update_user_status(l, 0, False)
            QMessageBox.information(self, "Успех", "Вы успешно авторизовались")
            if role == "Администратор":
                self.adm = AdminWindow(self.db); self.adm.show(); self.close()
            else: QMessageBox.information(self, "Вход", f"Добро пожаловать, {l}")
        else:
            new_f = fails + 1
            is_b = new_f >= 3
            self.db.update_user_status(l, new_f, is_b)
            msg = "Вы заблокированы. Обратитесь к администратору" if is_b else "Вы ввели неверный логин или пароль. Пожалуйста проверьте ещё раз введенные данные"
            QMessageBox.critical(self, "Ошибка", msg)
            self.cap.shuffle_puzzle()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    app.setStyle("Fusion")
    manager = DatabaseManager(DB_CONFIG)
    win = LoginWindow(manager)
    win.show()
    sys.exit(app.exec_())