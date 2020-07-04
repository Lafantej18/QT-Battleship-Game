/**
 * main.qml
 *
 * \brief Qml main file
 *
 * This is the main Qml file.
 *
 */

import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.2
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.1
import QtBattleship 1.0
import "UILogic.js" as UILogic


ApplicationWindow {
    id: mainWindow
    width: 400
    height: 100
    visible: true
    title: qsTr("QtBattleship")

    onClosing: {
        close.accepted = false;
        exitDialog.open();
    }

    MessageDialog {
        id: exitDialog
        title: "Wyjście"
        text: "Narawdę zamknąć grę?"
        icon: StandardIcon.Question
        standardButtons: StandardButton.Ok | StandardButton.Cancel
        onAccepted: {
            Settings.save();
            engine.stop();
            Qt.quit();
        }
        onRejected: {
            exitDialog.close();
        }

        Component.onCompleted: visible = false
    }
            Image {
                anchors.fill: parent
            }

               RowLayout {
                    id: boardLayout
                    visible: false
                    anchors.fill: parent

                    Rectangle {
                        id: playerBoardRect
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    Rectangle {
                        id: opponentBoardRect
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }

               RowLayout {
                   anchors.horizontalCenter: parent.horizontalCenter
                   Button {
                       id: createNewGameButton
                       text: qsTr("Create game")
                       onClicked: {
                           Settings.numFields = 10;
                           ApplicationWindow.visible = false;

                           engine.playerField.initialize();
                           engine.placeShipsRandom(engine.playerFieldName());
                           UILogic.createBattleField("playerboard", playerBoardRect, true);

                           engine.opponentField.initialize();
                           engine.placeShipsRandom(engine.opponentFieldName());
                           engine.opponentField.hideImages(true);
                           UILogic.createBattleField("opponentboard", opponentBoardRect, false);

                           createNewGameButton.visible = false;
                           boardLayout.visible = true;
                       }
                   }
               }
            }





