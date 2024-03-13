import "../class/Object.dart";
import "../class/Points.dart";

class Util {
  // List<Object> createListObject(List<Points> points_lista) {
  //   List<Points> lista_de_points = [];
  //   List<Object> lista_de_objetos = [];
  //   Points newPoints = new Points();
  //   Object objects_separados = new Object();

  //   for (int i = 0; i < points_lista.length; i++) {
  //     var current_element = points_lista[i];

  //     if (i < points_lista.length - 1) {
  //       var next_element = points_lista[i + 1];

  //       if (current_element.id_pixel == next_element.id_pixel) {
  //         newPoints = new Points();
  //         newPoints.setOffset(current_element.ponto);
  //         newPoints.setPixelId(current_element.id_pixel);
  //         lista_de_points.add(newPoints);
  //       } else {
  //         newPoints = new Points();
  //         newPoints.ponto = current_element.ponto;
  //         newPoints.id_pixel = current_element.id_pixel;
  //         lista_de_points.add(newPoints);

  //         objects_separados = new Object();
  //         objects_separados.setListaPonto(lista_de_points);
  //         objects_separados.setLastId(newPoints.id_pixel);
  //         lista_de_objetos.add(objects_separados);
  //         lista_de_points = [];
  //       }
  //     } else {
  //       newPoints = new Points();
  //       newPoints.setOffset(current_element.ponto);
  //       newPoints.setPixelId(current_element.id_pixel);
  //       lista_de_points.add(newPoints);
  //       objects_separados = new Object();
  //       objects_separados.setListaPonto(lista_de_points);
  //       objects_separados.setLastId(newPoints.id_pixel);
  //       lista_de_objetos.add(objects_separados);
  //     }
  //   }

  //   return lista_de_objetos;
  // }
}
