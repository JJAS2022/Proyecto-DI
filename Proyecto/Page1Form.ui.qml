import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.3

Page {
    id: page1
    width: 450
    height: 550
    property alias grafica: grafica
    property alias messageText: messageText
    property alias message: message
    property alias textNuevo: textNuevo
    property alias buttonModificar: buttonModificar
    property real presupuesto
    property real gastos

    ChartView {
        id: grafica
        width: 400
        height: 300
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -102
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        antialiasing: true

        PieSeries {
            id: pieSeries

            PieSlice {
                id: sliceGastos
                label: "Gasto: " + sliceGastos.value + " €"
                value: gastos
                labelVisible: true
            }

            PieSlice {
                id: sliceRestante
                label: "Resto: " + sliceRestante.value + " €"
                value: presupuesto - gastos
                labelVisible: true
            }
        }
    }

    Text {
        id: textActual
        width: 300
        height: 34
        text: qsTr("Presupuesto actual: " + presupuesto + " €")
        anchors.top: grafica.bottom
        font.pixelSize: 24
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
    }

    TextField {
        id: textNuevo
        width: 182
        height: 46
        anchors.left: parent.left
        anchors.top: textActual.bottom
        anchors.leftMargin: 59
        anchors.topMargin: 25
        placeholderText: qsTr("Nuevo presupuesto")
    }

    Button {
        id: buttonModificar
        x: 261
        width: 145
        height: 46
        text: qsTr("Actualizar")
        Material.background: "lightblue"
        anchors.right: parent.right
        anchors.top: textActual.bottom
        anchors.rightMargin: 44
        anchors.topMargin: 25
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
