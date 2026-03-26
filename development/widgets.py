import os
import random
from PyQt5.QtWidgets import QLabel, QWidget, QGridLayout
from PyQt5.QtGui import QPixmap
from PyQt5.QtCore import pyqtSignal, Qt

class PuzzlePiece(QLabel):
    clicked = pyqtSignal(int)

    def __init__(self, current_index, pixmap, parent=None):
        super().__init__(parent)
        self.current_index = current_index
        self.setPixmap(pixmap)
        self.setScaledContents(True)
        self.setFixedSize(100, 100)
        self.setCursor(Qt.PointingHandCursor)
        self.setStyleSheet("border: 1px solid #bdc3c7;")

    def mousePressEvent(self, event):
        self.clicked.emit(self.current_index)

class CaptchaPuzzle(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.layout = QGridLayout(self)
        self.correct_order = [0, 1, 2, 3]
        self.current_order = [0, 1, 2, 3]
        self.selected_idx = None
        
        script_dir = os.path.dirname(os.path.abspath(__file__))
        self.pixmaps = []
        for i in range(1, 5):
            path = os.path.join(script_dir, f"{i}.png")
            pix = QPixmap(path)
            if pix.isNull(): # Если картинка не найдена, создаем цветной квадрат
                pix = QPixmap(100, 100)
                pix.fill(Qt.lightGray)
            self.pixmaps.append(pix)
            
        self.shuffle_puzzle()

    def shuffle_puzzle(self):
        while self.current_order == self.correct_order:
            random.shuffle(self.current_order)
        self.draw_puzzle()

    def draw_puzzle(self):
        for i in reversed(range(self.layout.count())): 
            self.layout.itemAt(i).widget().setParent(None)
        
        for i, img_id in enumerate(self.current_order):
            piece = PuzzlePiece(i, self.pixmaps[img_id])
            if self.selected_idx == i:
                piece.setStyleSheet("border: 3px solid #3498db;")
            piece.clicked.connect(self.handle_swap)
            self.layout.addWidget(piece, i // 2, i % 2)

    def handle_swap(self, idx):
        if self.selected_idx is None:
            self.selected_idx = idx
        else:
            self.current_order[self.selected_idx], self.current_order[idx] = \
                self.current_order[idx], self.current_order[self.selected_idx]
            self.selected_idx = None
        self.draw_puzzle()

    def is_correct(self):
        return self.current_order == self.correct_order