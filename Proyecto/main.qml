import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: app
    width: 450
    height: 550
    visible: true
    title: qsTr("Gestor de Presupuesto")

    property real presupuestoTotal: 1000.0
    property real gastoTotal: page2.calcularSumaGastos()

    header: TabBar {
        id: tabBar
        width: swipeView.width
        height: 50
        currentIndex: swipeView.currentIndex
        background: Rectangle {
            color: "lightblue"
        }

        TabButton {
            text: "Presupuesto"
            onClicked: swipeView.currentIndex = 0
        }
        TabButton {
            text: "Gastos"
            onClicked: swipeView.currentIndex = 1
        }
    }

    Item {
        width: parent.width
        height: parent.height
        SwipeView {
            id: swipeView
            anchors.fill: parent
            currentIndex: tabBar.currentIndex

            Page1Form {
                id: page1
                presupuesto: presupuestoTotal
                gastos: gastoTotal
                Component.onCompleted: {
                   page1.grafica.legend.visible = false
                }
                buttonModificar.onClicked: {
                   if(textNuevo.text !== "") {
                       var presupuestoFloat = parseFloat(textNuevo.text)
                       if (presupuestoFloat >= gastoTotal){
                           if (presupuestoFloat !== presupuesto) {
                            presupuestoTotal = presupuestoFloat
                            message.visible = true
                            message.color = "lightgreen"
                            messageText.text = "El presupuesto se ha actualizado."
                            textNuevo.text = ""
                            timer.restart()
                           }
                       } else {
                           message.visible = true
                           message.color = "pink"
                           messageText.text = "El presupuesto no puede ser inferior a los gastos."
                           timer.restart()
                       }
                   } else {
                       message.visible = true
                       message.color = "pink"
                       messageText.text = "El presupuesto no puede estar vacío."
                       timer.restart()
                   }
                }
                Timer {
                    id: timer
                    running: false
                    repeat: false
                    interval: 3000
                    onTriggered: {
                        page1.message.visible = false;
                    }
                }
            }

            Page2Form {
                id: page2
                ListModel {
                    id: modeloPrincipal
                    ListElement {
                        descripcion: "Alquiler"
                        valor: "200"
                    }
                    ListElement {
                        descripcion: "Comida"
                        valor: "70"
                    }
                    ListElement {
                        descripcion: "Gasolina"
                        valor: "30"
                    }
                }

                function calcularSumaGastos() {
                    var suma = 0;
                    for (var i = 0; i < modeloPrincipal.count; ++i) {
                        suma += parseFloat(modeloPrincipal.get(i).valor);
                    }
                    return suma;
                }

                StackView{
                    id: stack
                    anchors.fill: parent
                    initialItem: list
                }

                Component {
                    id: list
                    Page2Form {
                        textGastoTotal: gastoTotal + " €"
                        buttonAnyadir.onClicked: {
                            stack.push(form, { editing: false })
                        }
                        modelo: modeloPrincipal
                        onEditar: indice => {
                                      var dato = modeloPrincipal.get(indice)
                                      stack.push(form, { textDescripcion: dato.descripcion, textValor: dato.valor, editing: true, editIndex: indice })
                                  }
                        onEliminar: indice => {
                                      modeloPrincipal.remove(indice)
                                      gastoTotal = page2.calcularSumaGastos()
                                  }
                    }
                }

                Component {
                    id: form
                    Page3Form {
                        id: page3
                        buttonConfirmar.onClicked: {
                            if (textDescripcion !== "" && textValor !== ""){
                                if(editing === false) {
                                    if ((parseFloat(textValor) + gastoTotal) <= presupuestoTotal ) {
                                        gastoTotal += parseFloat(textValor)
                                        modeloPrincipal.append({ descripcion: textDescripcion, valor: textValor })
                                        stack.pop()
                                    } else {
                                        message.visible = true
                                        message.color = "pink"
                                        messageText.text = "Añadir el gasto superaría el presupuesto actual."
                                        timer.restart()
                                    }
                                } else {
                                    if ((gastoTotal - parseFloat(modeloPrincipal.get(editIndex).valor)) + (parseFloat(textValor)) <= presupuestoTotal ) {
                                        modeloPrincipal.set(editIndex, { descripcion: textDescripcion, valor: textValor })
                                        gastoTotal = page2.calcularSumaGastos()
                                        editing = false
                                        stack.pop()
                                    } else {
                                        message.visible = true
                                        message.color = "pink"
                                        messageText.text = "Aumentar este gasto superaría el presupuesto actual."
                                        timer.restart()
                                    }
                                }
                            } else {
                                message.visible = true
                                message.color = "pink"
                                messageText.text = "Los campos no pueden estar vacíos."
                                timer.restart()
                            }
                        }
                        buttonCerrar.onClicked: {
                            stack.pop()
                        }
                        Timer {
                            id: timer
                            running: false
                            repeat: false
                            interval: 3000
                            onTriggered: {
                                message.visible = false;
                            }
                        }
                    }
                }
            }
        }
    }
}
