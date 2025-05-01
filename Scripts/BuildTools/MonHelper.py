import sys
import UpdateJson

from PySide6.QtCore import Qt, QDir
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
    QFileDialog,
    QLineEdit
)
from PySide6.QtGui import (
    QPalette, 
    QColor
)



class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("My App")

        ## Variables
        self.imnDir = "..."
        self.apiURL = "..."

        ## Layout
        self.layout = QVBoxLayout()
        self.layout.addWidget(QLabel("Getting JSON from Strapi"))
        self.layout.addWidget(QLabel("IMN Directory"))

        ## IMN Directory
        self.directory = QLineEdit()
        self.directory.setMaxLength(255)
        self.directory.setPlaceholderText(self.imnDir)
        self.layout.addWidget(self.directory)
        self.findDirBtn = QPushButton("Find Directory")
        self.findDirBtn.clicked.connect(self.find_dir)
        self.layout.addWidget(self.findDirBtn)

        ## Strapi URL
        self.layout.addWidget(QLabel("Strapi URL (http://NordMagicUrl)"))
        self.apiURLEdit = QLineEdit()
        self.apiURLEdit.setMaxLength(255)
        self.apiURLEdit.setPlaceholderText(self.apiURL)
        self.layout.addWidget(self.apiURLEdit)


        ## Get JSON
        self.getJsonBtn = QHBoxLayout()
        self.getJsonBtn = QPushButton("Get JSON")
        self.getJsonBtn.clicked.connect(self.get_json)
        self.layout.addWidget(self.getJsonBtn)

        ## Add all to Widget
        widget = QWidget()
        widget.setLayout(self.layout)
        self.setCentralWidget(widget)

    def get_json(self):
        UpdateJson.test_json(self.imnDir, self.apiURL)

    def find_dir(self, s):
        options = QFileDialog.ShowDirsOnly
        self.imnDir = QFileDialog.getExistingDirectory(self, "Select Directory",  QDir.homePath(), options=options)
        if self.imnDir:
            print(self.imnDir)
            self.directory.setPlaceholderText(self.imnDir)


app = QApplication(sys.argv)
window = MainWindow()
window.show()
app.exec()