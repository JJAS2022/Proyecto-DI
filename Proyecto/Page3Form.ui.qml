import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Page {
    id: page3
    width: 450
    height: 500
    anchors.fill: parent
    property alias message: message
    property alias messageText: messageText
    property alias textValor: textValor.text
    property alias textDescripcion: textDescripcion.text
    property alias buttonCerrar: buttonCerrar
    property alias buttonConfirmar: buttonConfirmar
    property bool editing: false
    property int editIndex: -1

    TextField {
        id: textDescripcion
        x: 117
        y: 122
        width: 217
        height: 43
        placeholderText: qsTr("Descripción del gasto")
    }

    TextField {
        id: textValor
        x: 117
        y: 171
        width: 217
        height: 43
        placeholderText: qsTr("Valor del gasto")
    }

    Button {
        id: buttonConfirmar
        x: 163
        y: 236
        width: 125
        height: 48
        text: qsTr("Confirmar")
        Material.background: "lightblue"
    }

    Button {
        id: buttonCerrar
        x: 163
        y: 290
        width: 125
        height: 48
        text: qsTr("Cancelar")
        Material.background: "lightblue"
    }

    Rectangle {
        id: message
        width: parent.width
        height: 40
        visible: false
        color: "white"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        Text {
            id: messageText
            anchors.centerIn: parent
            color: "white"
            text: qsTr("")
            font.pixelSize: 15
            font.bold: true
        }
    }
}
