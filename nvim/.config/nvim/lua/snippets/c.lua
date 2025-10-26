local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "include",
    t({
      "#include <signal.h>",
      "#include <stdio.h>",
      "#include <stdlib.h>",
      "#include <unistd.h>",
    })
  ),

  s("main", {
    t("int main() {"),
    t({ "", "\t" }),
    i(1, "// código aquí"),
    t({ "", "\treturn 0;", "}" }),
  }),
  s(
    "read_matrix_file",
    fmt(
      [[
/**
 * @brief Lee una matriz cuadrada de tamaño `n x n` desde un archivo.
 *
 * El archivo debe tener el siguiente formato:
 * - La primera línea contiene un entero `n`, que representa tanto el número de
 *   filas como de columnas de la matriz.
 * - Las siguientes `n` líneas contienen `n` enteros cada una, separados por
 *   espacios o saltos de línea, representando las filas de la matriz.
 *
 * @param filename Nombre del archivo a leer.
 * @param n        Puntero a entero donde se almacenará el tamaño de la matriz
 *                 leída.
 * @param matrix   Puntero triple a una matriz dinámica `n x n` que será
 *                 reservada e inicializada con los datos del archivo.
 *
 * @note La memoria reservada dentro de esta función debe ser liberada por el
 *       llamador utilizando `free`.
 */
void read_matrix_file(const char *filename, int *n, int ***matrix) {{
  FILE *file = fopen(filename, "r");

  fscanf(file, "%d", n); // Leer el tamaño de la matriz
  fgetc(file);           // Consumir salto de línea

  *matrix = (int **)malloc(sizeof(int *) * (*n));
  for (int i = 0; i < *n; i++) {{
    (*matrix)[i] = (int *)malloc(sizeof(int) * (*n));
    for (int j = 0; j < *n; j++) {{
      fscanf(file, "%d", &(*matrix)[i][j]); // Leer cada elemento
    }}
  }}

  fclose(file);
}}
]],
      {}
    )
  ),

  s(
    "print_matrix",
    fmt(
      [[
/**
 * @brief Imprime en consola una matriz cuadrada de tamaño `n x n`.
 *
 * Cada fila de la matriz se imprime en una línea separada, y los elementos se
 * separan por espacios.
 *
 * @param matrix Matriz dinámica de enteros a imprimir.
 * @param n      Tamaño de la matriz (número de filas y columnas).
 *
 */
void print_matrix(int **matrix, int n) {{
  for (int i = 0; i < n; i++) {{
    for (int j = 0; j < n; j++) {{
      printf("%d ", matrix[i][j]);
    }}
    printf("\\n");
  }}
}}
]],
      {}
    )
  ),
}
