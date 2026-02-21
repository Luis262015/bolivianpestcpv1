{{-- resources/views/pdf/clientes.blade.php --}}
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <title>PDF Trampas</title>
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

    td {
      padding: 3px;
    }

    span {
      font-weight: bold;
      font-size: .8rem;
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
        <td style="width: 76%; text-align: center; height: 30px;">SEGUIMIENTO TRAMPAS</td>
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
          {{-- NOMBRE DE LA EMPRESA: <span>{{ $seguimiento->empresa->nombre }}</span> --}}
        </td>
      </tr>
      <tr>
        <td>CUIDAD: <span>{{ $seguimiento->almacen->ciudad }}</span></td>
        <td>ALMACEN: <span>{{ $seguimiento->almacen->nombre }}</span></td>
        <td style="width: 40%">FECHA: <span>{{ $seguimiento->created_at }}</span></td>
      </tr>
      <tr>
        <td colspan="3">DIRECCION: <span>{{ $seguimiento->almacen->direccion }}</span></td>
        {{-- <td>PROXIMA EVALUACION:</td> --}}
      </tr>
    </table>
    {{-- <table>
      <tr>
        <td>
          INSECTOCUTORES
        </td>
      </tr>
      <tr>
        <td>
          <table>
            <tr>
              <td>PAREDES INTERNAS: <span>{{ $seguimiento->aplicacion->paredes_internas }}</span></td>
              <td>OFICINAS: <span>{{ $seguimiento->aplicacion->oficinas }}</span></td>
              <td>PISOS: <span>{{ $seguimiento->aplicacion->pisos }}</span></td>
              <td>BAÑOS: <span>{{ $seguimiento->aplicacion->banos }}</span></td>
            </tr>
            <tr>
              <td>COCINAS: <span>{{ $seguimiento->aplicacion->cocinas }}</span></td>
              <td>ALMACENES: <span>{{ $seguimiento->aplicacion->almacenes }}</span></td>
              <td>PORTERIA: <span>{{ $seguimiento->aplicacion->porteria }}</span></td>
              <td>POLICIAL: <span>{{ $seguimiento->aplicacion->policial }}</span></td>
            </tr>
            <tr>
              <td>TRAMPAS: <span>{{ $seguimiento->aplicacion->trampas }}</span></td>
              <td>CAMBIAR TRAMPAS: <span>{{ $seguimiento->aplicacion->trampas_cambiar }}</span></td>
              <td>INTERNAS: <span>{{ $seguimiento->aplicacion->internas }}</span></td>
              <td>EXTERNAS: <span>{{ $seguimiento->aplicacion->externas }}</span></td>
            </tr>
            <tr>
              <td>ROEDORES: <span>{{ $seguimiento->aplicacion->roedores }}</span></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
          </table>
        </td>
      </tr>
    </table> --}}
    <table>
      <tr>
        <td>INSECTOCUTORES</td>
      </tr>
      <tr>
        <td>
          <table>
            <tr>
              <td>#</td>
              <td>Trampa ID:</td>
              <td>Especie ID</td>
              <td>Cantidad</td>
            </tr>
            @foreach ($seguimiento->trampaEspeciesSeguimientos as $metodo)
              <tr>
                <td>{{ $loop->iteration }}</td>
                <td>{{ $metodo->trampa_id }}</td>
                <td>{{ $metodo->especie->nombre }}</td>
                <td>{{ $metodo->cantidad }}</td>
                {{-- : <span style="margin-right: 20px">{{ $metodo->nombre }}</span><span>{{ $metodo->nombre }}</span> --}}
              </tr>
            @endforeach
          </table>
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td>TRAMPAS</td>
      </tr>
      <tr>
        <td>
          <table>
            <tr>
              <td>#</td>
              <td>Trampa ID:</td>
              <td>Cantidad</td>
              <td>Inicial</td>
              <td>Merma</td>
              <td>Actual</td>
            </tr>
            @foreach ($seguimiento->trampaRoedoresSeguimientos as $metodo)
              <tr>
                <td>{{ $loop->iteration }}</td>
                <td>{{ $metodo->trampa_id }}</td>
                <td>{{ $metodo->cantidad }}</td>
                <td>{{ $metodo->inicial }}</td>
                <td>{{ $metodo->merma }}</td>
                <td>{{ $metodo->actual }}</td>
                {{-- : <span style="margin-right: 20px">{{ $metodo->nombre }}</span><span>{{ $metodo->nombre }}</span> --}}
              </tr>
            @endforeach
          </table>
        </td>
      </tr>
    </table>
    {{-- <table>
      <tr>
        <td>PRODUCTO UTILIZADO</td>
      </tr>
      <tr>
        <td></td>
      </tr>
    </table> --}}
    {{-- <table>
      <tr>
        <td>
          EPP UTILIZADO
        </td>
      </tr>
      <tr>
        <td>
          @foreach ($seguimiento->epps as $epp)
            {{ $loop->iteration }} : <span style="margin-right: 20px">{{ $epp->nombre }}</span>
          @endforeach
        </td>
      </tr>
    </table> --}}
    {{-- <table>
      <tr>
        <td>MEDIDAS DE PROTECCION ADOPTADAS PARA TERCEROS</td>
      </tr>
      <tr>
        <td>
          @foreach ($seguimiento->proteccions as $proteccion)
            {{ $loop->iteration }} : <span style="margin-right: 20px">{{ $proteccion->nombre }}</span>
          @endforeach
        </td>
      </tr>
    </table> --}}
    {{-- <table>
      <tr>
        <td>OBSERVACIONES DE CICLO BIOLOGICO</td>
      </tr>
      <tr>
        <td>
          @foreach ($seguimiento->biologicos as $biologico)
            {{ $loop->iteration }} : <span style="margin-right: 20px">{{ $biologico->nombre }}</span>
          @endforeach
        </td>
      </tr>
    </table> --}}
    {{-- <table>
      <tr>
        <td>OBSERVACIONES DE SIGNOS DE ROEDORES</td>
      </tr>
      <tr>
        <td>
          @foreach ($seguimiento->signos as $signo)
            {{ $loop->iteration }} : <span style="margin-right: 20px">{{ $signo->nombre }}</span>
          @endforeach
        </td>
      </tr>
    </table> --}}
    {{-- <table>
      <tr>
        <td>OBSERVACIONES BOLIVIAN PEST</td>
      </tr>
      <tr>
        <td>{{ $seguimiento->observacionesp }}</td>
      </tr>
    </table> --}}
    {{-- <table>
      <tr>
        <td>EVIDENCIAS</td>
      </tr>
      <tr>
        <td>
          @foreach ($seguimiento->images as $image)
            <img src="{{ public_path('storage/' . $image->imagen) }}" alt="" width="150px">
          @endforeach
        </td>
      </tr>
    </table> --}}
    {{-- <table>
      <tr>
        <td>OBSERVACIONES</td>
      </tr>
      <tr>
        <td>{{ $seguimiento->observaciones }}</td>
      </tr>
    </table> --}}

    {{-- <table>
      <tr>
        <td style="width: 50%; text-align: center;">
          <div><img src="{{ public_path('storage/' . $seguimiento->firma_encargado) }}" alt="" width="150px">
          </div>
          <div>ENCARGADO</div>
          <div>Nombre del encargado</div>
        </td>
        <td style="width: 50%; text-align: center;">
          <div><img src="{{ public_path('storage/' . $seguimiento->firma_supervisor) }}" alt="" width="150px">
          </div>
          <div>TECNICO</div>
          <div>Nombre del tecnico</div>
          <div>BOLIVIAN PEST</div>
        </td>
      </tr>
    </table> --}}






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
