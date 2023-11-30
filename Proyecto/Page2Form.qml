import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Page {
    id: page2
    width: 450
    height: 500
    visible: true
    property alias textGastoTotal: textGastoTotal.text
    property alias listView: listView
    property alias buttonAnyadir: roundButton
    property alias modelo: listView.model
    property bool deletion: false
    signal eliminar(int indice)
    signal editar(int indice)

    Rectangle {
        id: cellDescripcion
        width: 122
        height: 40
        border.color: "black"
        border.width: 1
        color: "lavenderblush"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 34
        anchors.topMargin: 30
        Text {
            text: "Descripción"
            font.pixelSize: 18
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            font.bold: true
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: cellValor
        x: 151
        width: 84
        height: 40
        border.color: "black"
        border.width: 1
        color: "lavenderblush"
        anchors.top: parent.top
        anchors.topMargin: 30
        Text {
            text: "Valor"
            font.pixelSize: 18
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            font.bold: true
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: cellOpciones
        width: 191
        height: 40
        border.color: "black"
        border.width: 1
        color: "lavenderblush"
        anchors.left: cellValor.right
        anchors.top: parent.top
        anchors.leftMargin: -1
        anchors.topMargin: 30
        Text {
            text: "Opciones"
            font.pixelSize: 18
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            font.bold: true
            anchors.centerIn: parent
        }
    }

    ListView {
        id: listView
        width: 400
        height: 223
        currentIndex: -1
        anchors.top: cellValor.bottom
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 55
        model: ListModel {
        }
        delegate:  Item {
            x: 5
            width: listView.width
            height: 50
            Row {
                id: row1
                spacing: 10
                Rectangle {
                    width: 115
                    height: 40
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        text: descripcion
                        font.bold: true
                        font.pixelSize: 18
                        color: "indianred"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: 75
                    height: 40
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        text: valor + " €"
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                        font.pixelSize: 18
                        color: "seagreen"
                        anchors.centerIn: parent
                    }
                }

                Button {
                    id: editButton
                    width: 86
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Editar")
                    Material.background: "lightblue"
                    onClicked: page2.editar(index)
                }

                Button {
                    id: deleteButton
                    width: 87
                    anchors.verticalCenter: parent.verticalCenter
                    Material.background: "lightblue"
                    text: "Borrar"
                    onClicked: page2.eliminar(index)
                }
            }
        }
    }

    Rectangle {
        id: cellTotal
        width: 122
        height: 40
        border.color: "black"
        border.width: 1
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.leftMargin: 34
        color: "lavenderblush"
        Text {
            text: "Total"
            font.pixelSize: 18
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            font.bold: true
            anchors.centerIn: parent
        }
    }

    RoundButton {
        id: roundButton
        x: 346
        y: 404
        width: 55
        height: 53
        text: "+"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 44
        anchors.rightMargin: 50
        Material.background: "hotpink"
    }

    Rectangle {
        id: gastoTotal
        y: 410
        width: 79
        height: 40
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.leftMargin: 156
        Text {
            id: textGastoTotal
            text: "300 €"
            font.pixelSize: 18
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            font.bold: true
            anchors.centerIn: parent
            color: "seagreen"
        }
    }
}
