import sys, os, random, psycopg2
from PyQt5.QtWidgets import *
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QPixmap

DB_CONFIG = {"dbname": "practika", "user": "postgres", "password": "0704", "host": "localhost", "port": "5432"}

class DB:
    @staticmethod
    def ex(q, p=None, f=False):
        # Универсальный метод для работы с БД: f=True для получения данных, f=False для фиксации изменений
        with psycopg2.connect(**DB_CONFIG) as c:
            c.set_client_encoding('UTF8')
            with c.cursor() as cur:
                cur.execute(q, p)
                return cur.fetchall() if f else c.commit()

class Captcha(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.l, self.cor, self.cur, self.sel = QGridLayout(self), [0,1,2,3], [0,1,2,3], None
        self.l.setSpacing(2)
        self.pix = [QPixmap(os.path.join(os.path.dirname(__file__), f"{i}.png")) for i in range(1,5)]
        self.shuf()

    def shuf(self):
        # Алгоритм перемешивания: цикл гарантирует, что пазл не будет собран сразу после генерации
        while self.cur == self.cor: 
            random.shuffle(self.cur)
        self.draw()

    def draw(self):
        for i in reversed(range(self.l.count())): self.l.itemAt(i).widget().setParent(None)
        for i, img in enumerate(self.cur):
            lbl = QLabel()
            pixmap = self.pix[img] if not self.pix[img].isNull() else QPixmap(150,150)
            lbl.setPixmap(pixmap)
            lbl.setFixedSize(150,150)
            lbl.setScaledContents(True)
            lbl.setStyleSheet(f"border: {'3px solid #3498db' if self.sel == i else '1px solid #ccc'}")
            lbl.mousePressEvent = lambda e, idx=i: self.sw(idx)
            self.l.addWidget(lbl, i//2, i%2)

    def sw(self, i):
        # Логика обмена фрагментов: первый клик выбирает элемент, второй — меняет его с текущим
        if self.sel is None: 
            self.sel = i
        else: 
            self.cur[self.sel], self.cur[i] = self.cur[i], self.cur[self.sel]
            self.sel = None
        self.draw()

class UserDlg(QDialog):
    def __init__(self, p, t, uid=None):
        super().__init__(p)
        self.uid = uid
        self.setWindowTitle(t)
        l = QVBoxLayout(self)
        self.f = {"Логин": QLineEdit(), "Пароль": QLineEdit(), "Роль": QComboBox()}
        self.f["Роль"].addItems(["Пользователь","Администратор"])
        for k,v in self.f.items(): l.addWidget(QLabel(k)); l.addWidget(v)
        b = QPushButton("Сохранить")
        b.clicked.connect(self.save)
        l.addWidget(b)
        if uid:
            d = DB.ex('SELECT "Логин","Пароль","Роль" FROM public."Пользователи" WHERE "id_Пользователя"=%s', (uid,), 1)[0]
            self.f["Логин"].setText(d[0]); self.f["Пароль"].setText(d[1]); self.f["Роль"].setCurrentText(d[2])

    def save(self):
        v = (self.f["Логин"].text(), self.f["Пароль"].text(), self.f["Роль"].currentText())
        if not v[0] or not v[1]: return
        if self.uid: DB.ex('UPDATE public."Пользователи" SET "Логин"=%s,"Пароль"=%s,"Роль"=%s WHERE "id_Пользователя"=%s', v+(self.uid,))
        else: DB.ex('INSERT INTO public."Пользователи" ("Логин","Пароль","Роль") VALUES (%s,%s,%s)', v)
        self.parent().load(); self.close()

class UserWindow(QWidget):
    def __init__(self, name):
        super().__init__()
        self.setWindowTitle("Рабочее место")
        self.resize(600,400)
        l = QVBoxLayout(self)
        info = QLabel(f"Авторизован: {name}")
        info.setAlignment(Qt.AlignRight)
        l.addWidget(info)
        l.addStretch()
        title = QLabel("ПОЛЬЗОВАТЕЛЬСКИЙ ИНТЕРФЕЙС СИСТЕМЫ")
        title.setAlignment(Qt.AlignCenter)
        title.setStyleSheet("font-size:18px;font-weight:bold;color:#34495e;")
        l.addWidget(title)
        l.addStretch()
        btn = QPushButton("Выйти из системы")
        btn.setFixedWidth(200)
        btn.clicked.connect(self.logout)
        l.addWidget(btn, alignment=Qt.AlignCenter)
    def logout(self): self.w = LoginWin(); self.w.show(); self.close()

class AdminWin(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Админ-панель")
        self.resize(850,500)
        l = QVBoxLayout(self)
        self.t = QTableWidget(0,5)
        self.t.setHorizontalHeaderLabels(["ID","Логин","Роль","Блок","Попытки"])
        self.t.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        l.addWidget(self.t)
        bl = QHBoxLayout()
        for txt,fn in [("Добавить", lambda: UserDlg(self,"Новый").exec_()), ("Изменить", self.edit), ("Разблокировать", self.unl)]:
            b = QPushButton(txt); b.clicked.connect(fn); bl.addWidget(b)
        self.br = QPushButton("ОБНОВИТЬ")
        self.br.clicked.connect(self.load)
        bl.addWidget(self.br)
        bl.addStretch()
        out = QPushButton("Выход")
        out.clicked.connect(self.logout)
        bl.addWidget(out)
        l.addLayout(bl)
        self.load()

    def load(self):
        # Визуальная индикация процесса обновления данных из PostgreSQL
        self.br.setText("ОБНОВЛЯЮ..."); self.br.setEnabled(False)
        data = DB.ex('SELECT "id_Пользователя","Логин","Роль","Заблокирован","КоличествоНеудачныхПопыток" FROM public."Пользователи" ORDER BY 1', None, 1)
        self.t.setRowCount(0)
        for r,row in enumerate(data or []):
            self.t.insertRow(r)
            for c,v in enumerate(row): self.t.setItem(r,c,QTableWidgetItem(str(v)))
        QTimer.singleShot(400, lambda: (self.br.setText("ОБНОВИТЬ"), self.br.setEnabled(True)))

    def edit(self):
        if self.t.currentRow() >= 0: UserDlg(self, "Правка", self.t.item(self.t.currentRow(),0).text()).exec_()

    def unl(self):
        if self.t.currentRow() >= 0:
            DB.ex('UPDATE public."Пользователи" SET "Заблокирован"=false,"КоличествоНеудачныхПопыток"=0 WHERE "id_Пользователя"=%s', (self.t.item(self.t.currentRow(),0).text(),))
            self.load()

    def logout(self): self.w = LoginWin(); self.w.show(); self.close()

class LoginWin(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Вход")
        self.setFixedWidth(360)
        l = QVBoxLayout(self)
        self.log = QLineEdit(); self.log.setPlaceholderText("Логин"); l.addWidget(self.log)
        self.pas = QLineEdit(); self.pas.setPlaceholderText("Пароль"); self.pas.setEchoMode(QLineEdit.Password); l.addWidget(self.pas)
        self.cap = Captcha(); l.addWidget(self.cap)
        b = QPushButton("ВОЙТИ"); b.setFixedHeight(40); b.clicked.connect(self.auth); l.addWidget(b)

    def auth(self):
        # Многоуровневая проверка: Пустые поля -> Существование -> Блокировка -> Пароль -> Капча
        if not self.log.text() or not self.pas.text():
            return QMessageBox.warning(self, "Ошибка", "Необходимо заполнить пустые поля")

        u = DB.ex('SELECT "Пароль","Роль","Заблокирован","КоличествоНеудачныхПопыток" FROM public."Пользователи" WHERE "Логин"=%s', (self.log.text(),), 1)
        msg_err = "Вы ввели неверный логин или пароль. Пожалуйста, проверьте ещё раз введенные данные"
        
        if not u: 
            return QMessageBox.warning(self, "Ошибка", msg_err)
        
        pw, role, block, fails = u[0]
        
        if block: 
            return QMessageBox.critical(self, "Блок", "Вы заблокированы. Обратитесь к администратору")
        
        if self.pas.text() != pw: 
            self.fail(fails, msg_err)
        elif self.cap.cur != self.cap.cor: 
            self.fail(fails, "Капча не собрана")
        else:
            # Сброс счетчика при успешном входе
            DB.ex('UPDATE public."Пользователи" SET "КоличествоНеудачныхПопыток"=0 WHERE "Логин"=%s', (self.log.text(),))
            QMessageBox.information(self, "Успех", "Вы успешно авторизовались")
            self.w = AdminWin() if role == "Администратор" else UserWindow(self.log.text())
            self.w.show(); self.close()

    def fail(self, f, m):
        # Логика обработки ошибок: инкремент попыток и триггер блокировки при достижении порога (3)
        nf = f + 1
        b = nf >= 3
        DB.ex('UPDATE public."Пользователи" SET "КоличествоНеудачныхПопыток"=%s,"Заблокирован"=%s WHERE "Логин"=%s', (nf, b, self.log.text()))
        if b:
            QMessageBox.critical(self, "Ошибка", "Вы заблокированы. Обратитесь к администратору")
        else:
            QMessageBox.warning(self, "Ошибка", m)
        self.cap.shuf() # Обязательное перемешивание капчи после любой ошибки

if __name__ == "__main__":
    app = QApplication(sys.argv)
    app.setStyle("Fusion")
    w = LoginWin(); w.show()
    sys.exit(app.exec_())