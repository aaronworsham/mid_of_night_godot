import sys
import UpdateJson

from PySide6.QtCore import Qt
from PySide6.QtWidgets import (
    QApplication,
    QHBoxLayout,
    QLabel,
    QMainWindow,
    QPushButton,
    QStackedLayout,
    QVBoxLayout,
    QWidget,
    QTabWidget,
    QMessageBox,
    QFileDialog
)
from PySide6.QtGui import (
    QPalette, 
    QColor
)



class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("My App")

        layout = QVBoxLayout()

        button_layout = QHBoxLayout()
        btn = QPushButton("Get JSON")
        btn.clicked.connect(self.press_button_1)
        button_layout.addWidget(btn)
        btn = QPushButton("Dialog")
        btn.clicked.connect(self.press_button_2)
        button_layout.addWidget(btn)


        layout.addLayout(button_layout)

        layout.addWidget(Color('red'))

        widget = QWidget()
        widget.setLayout(layout)
        self.setCentralWidget(widget)

    def press_button_1(self):
        UpdateJson.get_json()

    def press_button_2(self, s):
        filename, filter = QFileDialog.getOpenFileName(parent=self, caption='Open file', dir='.')
        if filename:
            print(filename)

class Color(QWidget):
    def __init__(self, color):
        super().__init__()
        self.setAutoFillBackground(True)

        palette = self.palette()
        palette.setColor(QPalette.Window, QColor(color))
        self.setPalette(palette)

app = QApplication(sys.argv)
window = MainWindow()
window.show()
app.exec()