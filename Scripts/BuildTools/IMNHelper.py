import sys
import UpdateJson

import pickle
from os.path import exists

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

        settings.start_message = "New Message"
        print(settings.start_message)
        
        self.setWindowTitle("My App")

        ## Layout
        self.layout = QVBoxLayout()
        self.layout.addWidget(QLabel("Getting JSON from Strapi"))
        self.layout.addWidget(QLabel("IMN Directory"))

        ## IMN Directory
        self.directory = QLineEdit()
        self.directory.setMaxLength(255)
        self.directory.setText(settings.imnDir)
        self.layout.addWidget(self.directory)
        self.findDirBtn = QPushButton("Find Directory")
        self.findDirBtn.clicked.connect(self.find_dir)
        self.layout.addWidget(self.findDirBtn)

        ## Strapi URL
        self.layout.addWidget(QLabel("Strapi URL (http://NordMagicUrl:1337/api/)"))
        self.apiURLEdit = QLineEdit()
        self.apiURLEdit.setMaxLength(255)
        self.apiURLEdit.setText(settings.apiURL)
        self.layout.addWidget(self.apiURLEdit)

        ## Save Settings
        self.saveSettingsBtn = QHBoxLayout()
        self.saveSettingsBtn = QPushButton("Save Settings")
        self.saveSettingsBtn.clicked.connect(self.save_settings)
        self.layout.addWidget(self.saveSettingsBtn)


        ## Get JSON
        self.getJsonBtn = QHBoxLayout()
        self.getJsonBtn = QPushButton("Get JSON")
        self.getJsonBtn.clicked.connect(self.get_json)
        self.layout.addWidget(self.getJsonBtn)

        ## Add all to Widget
        widget = QWidget()
        widget.setLayout(self.layout)
        self.setCentralWidget(widget)

    def save_settings(self):
        settings.apiURL = self.apiURLEdit.text()
        settings.imnDir = self.directory.text()
        settings.save(settingsFileName)

    def get_json(self):
        UpdateJson.get_json(settings.imnDir, self.apiURLEdit.text())

    def find_dir(self, s):
        options = QFileDialog.Options()
        options |= QFileDialog.DontUseNativeDialog
        options |= QFileDialog.ShowDirsOnly
        settings.imnDir = QFileDialog.getExistingDirectory(self, "Select Directory",  QDir.homePath(), options=options)
        if settings.imnDir:
            self.directory.setText(settings.imnDir)



class App_Settings:

    # Set initial settings here.
    def __init__(self):
        self._start_message = "Hello World"
        self.imnDir = "/home/aaronw/Development/mid_of_night_godot"
        self.apiURL = "http://NordMagicUrl:1337/api/"

    # Property Getter and Setters to allow the application to
    # access the settings and change them
    @property
    def start_message(self):
        return self._start_message

    @start_message.setter
    def start_message(self, value):
        self._start_message = value

    #Methods to save the settings to a file and load them from a file
    def save(self, filename):
        with open(filename, 'wb') as fo:
            pickle.dump(self, fo)

    def load(self, filename):
        if exists(filename):
            with open(filename, 'rb') as fi:
                newObj = pickle.load(fi)
            self.__dict__.update(newObj.__dict__)


app = QApplication(sys.argv)

### Settings
settingsFileName = "imn_helper_settings.pickle"
settings = App_Settings()
settings.load(settingsFileName)


window = MainWindow()
window.show()
app.exec()