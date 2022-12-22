from flask import Flask

app = Flask(__name__)


# un decorador se usa con el '@' y sirve para poder modificar cierto metodo de una clase 
@app.route('/')
def inicio():
    return 'Hola desde mi servidor de Flask'

@app.route('/mostrar-hora', methods=['GET', 'POST'])
def mostrarHora():
    # no se suele retornar strings (cadena de texto) sino que se utiliza diccionarios
    return {
        'content': '22:50:15'
    }

# debug > cada vez que modifiquemos algun archivo del proyecto y guardamos, se reiniciara el servidor
app.run(debug=True)