{{-- resources/views/pdf/clientes.blade.php --}}
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <title>Lista de Clientes</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    @page {
      margin: 0;
    }

    /* body {
      margin: 0;
      padding: 0;
      width: 100%;
      height: 100%;

      background-image: url('{{ public_path('images/certificado/Certificado.png') }}');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;

      font-family: DejaVu Sans, sans-serif;
    }  */

    body {
      font-size: .65rem;
      font-family: Arial, sans-serif;
      color: #0D3347;
    }

    /* .contenido {
      position: relative;
      width: 100%;
      height: 100%;
      padding: 80px;
      box-sizing: border-box;
    }

    h1 {
      text-align: center;
      margin-top: 120px;
    }

    p {
      font-size: 14px;
      line-height: 1.6;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th,
    td {
      border: 1px solid #000;
      padding: 8px;
      text-align: left;
    }

    th {
      background-color: #f3f4f6;
    } */
    .contenido {
      margin: 1rem;
    }

    .header {
      display: flex;
      flex-direction: column;
      font-weight: bold;
    }

    .headerA {
      display: flex;
      flex-direction: row;
    }

    table {
      width: 100%;
      border: 1px solid #0D3347;
    }

    table,
    td {
      border: 1px solid #0D3347;
      border-collapse: collapse;
    }
  </style>
</head>

<body>
  <div class="contenido">

    {{-- <table>
      <tr>
        <td style="width: 20%;" colspan="2">
          <img src="{{ public_path('images/LogoFC.png') }}" alt="" width="75">
        </td>
        <td style="width: 60%; text-align: center;">
          SEGUIMIENTO
          FORMULARIO DE CONFORMIDAD
        </td>
        <td style="width: 20%;"></td>
      </tr>
      <tr>
        <td style="width: 20%;">
        </td>
        <td style="width: 60%; text-align: center;">

          FORMULARIO DE CONFORMIDAD
        </td>
        <td style="width: 20%;"></td>
      </tr>
    </table> --}}

    <table>
      <tr>
        <th rowspan="2" style="width: 12%;"><img src="{{ public_path('images/LogoFC.png') }}" alt=""
            width="75"></th> <!-- Esta celda ocupará 2 filas -->
        <td style="width: 76%; text-align: center; height: 30px;">SEGUIMIENTO</td>
        <td rowspan="2" style="width: 12%;"></td>
      </tr>
      <tr>
        <!-- No se necesita una celda para "Encabezado Largo" aquí -->
        <td style="width: 60%; text-align: center;">FORMULARIO DE CONFORMIDAD</td>
        {{-- <td>Dato Fila 2, Col 2</td> --}}
      </tr>
    </table>

    <table>
      <tr>
        <td colspan="3">DATOS DEL SERVICIO</td>
      </tr>
      <tr>
        <td colspan="3">
          NOMBRE DE LA EMPRESA:
        </td>
      </tr>
      <tr>
        <td>CUIDAD:</td>
        <td>ALMACEN:</td>
        <td style="width: 40%">FECHA:</td>
      </tr>
      <tr>
        <td colspan="2">DIRECCION:</td>
        <td>PROXIMA EVALUACION:</td>
      </tr>
    </table>
    <table>
      <tr>
        <td>
          LABORES DESARROLLADAS
        </td>
      </tr>
      <tr>
        <td>
          <table>
            <tr>
              <td>PAREDES INTERNAS:</td>
              <td>....... UNDADES</td>
            </tr>
            <tr>
              <td>PISOS:</td>
              <td>........ UNIDADES</td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td>METODO UTILIZADO</td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table>
    <table>
      <tr>
        <td>PRODUCTO UTILIZADO</td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table>
    <table>
      <tr>
        <td>
          EPP UTILIZADO
        </td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table>
    <table>
      <tr>
        <td>MEDIDAS DE PROTECCION ADOPTADAS PARA TERCEROS</td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table>
    <table>
      <tr>
        <td>OBSERVACIONES DE CICLO BIOLOGICO</td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table>
    <table>
      <tr>
        <td>OBSERVACIONES BOLIVIAN PEST</td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table>
    <table>
      <tr>
        <td>EVIDENCIAS</td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table>
    <table>
      <tr>
        <td>OBSERVACIONES</td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table>






    {{-- <div class="text-center mb-8">
      <h1 class="text-3xl font-bold">CERTIFICADO XXX</h1>
      <p class="text-gray-600">Generado el {{ now()->format('d/m/Y H:i') }}</p>
    </div> --}}

    {{-- <table>
      <thead>
        <tr class="bg-gray-100">
          <th class="px-4 py-2">ID</th>
          <th class="px-4 py-2">Titulo</th>
          <th class="px-4 py-2">Validez</th>
          <th class="px-4 py-2">Direccion</th>
          <th class="px-4 py-2">Registro</th>
        </tr>
      </thead>
      <tbody>

        <tr class="">
          <td class="px-4 py-2">{{ $certificado->id }}</td>
          <td class="px-4 py-2">{{ $certificado->titulo }}</td>
          <td class="px-4 py-2">{{ $certificado->validez }}</td>
          <td class="px-4 py-2">{{ $certificado->direccion }}</td>          
          <td class="px-4 py-2">{{ $certificado->registro }}</td>
        </tr>

      </tbody>
    </table> --}}

    {{-- <div class="mt-8 text-center text-sm text-gray-500">
          Total de clientes: {{ $clientes->count() }}
      </div> --}}
  </div>
</body>

</html>
