{{-- resources/views/pdf/clientes.blade.php --}}
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <title>PDF Seguimiento</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    @page {
      margin: 0;
    }

    body {
      font-size: .65rem;
      font-family: Arial, sans-serif;
      color: #0D3347;
    }

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
      /* font-weight: bold; */
      font-size: .9rem;
      font-weight: normal;
    }

    .titulo {
      font-weight: bolder;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      page-break-inside: auto;
    }

    tr {
      page-break-inside: avoid;
      page-break-after: auto;
    }

    thead {
      display: table-header-group;
    }

    tfoot {
      display: table-footer-group;
    }
  </style>
</head>

<body>
  <div class="contenido">

    <table>
      <tr>
        <th rowspan="2" style="width: 12%;"><img src="{{ public_path('images/LogoFC.png') }}" alt=""
            width="75"></th> <!-- Esta celda ocupará 2 filas -->
        <td style="width: 76%; text-align: center; height: 30px; font-weight: bolder;">SEGUIMIENTO
          {{ $seguimiento->tipoSeguimiento->nombre }}
        </td>
        <td rowspan="2" style="width: 12%;"></td>
      </tr>
      <tr>
        <!-- No se necesita una celda para "Encabezado Largo" aquí -->
        <td style="width: 60%; text-align: center; font-weight: bolder;">FORMULARIO DE CONFORMIDAD</td>
        {{-- <td>Dato Fila 2, Col 2</td> --}}
      </tr>
    </table>

    <table>
      <tr>
        <td colspan="3" class="titulo">DATOS DEL SERVICIO</td>
      </tr>
      <tr>
        <td colspan="3" class="titulo">
          NOMBRE DE LA EMPRESA: <span>{{ $seguimiento->empresa->nombre }}</span>
        </td>
      </tr>
      <tr>
        <td class="titulo">CUIDAD: <span>{{ $seguimiento->almacen->ciudad }}</span></td>
        <td class="titulo">ALMACEN: <span>{{ $seguimiento->almacen->nombre }}</span></td>
        <td style="width: 40%" class="titulo">FECHA: <span>{{ $seguimiento->created_at }}</span></td>
      </tr>
      <tr>
        <td colspan="2" class="titulo">DIRECCION: <span>{{ $seguimiento->almacen->direccion }}</span></td>
        <td class="titulo">PROXIMA EVALUACION:
          <span>{{ $cronograma ? $cronograma->date : 'NO HAY PROXIMA FECHA' }}</span>
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td class="titulo">
          LABORES DESARROLLADAS
        </td>
      </tr>
      <tr>
        <td>
          <table>
            @if ($seguimiento->tipoSeguimiento->nombre === 'DESRATIZACION')
              <tr>
                <td colspan="5" class="titulo">CONTROL DE ROEDORES</td>
              </tr>
              <tr>
                <td class="titulo">TRAMPAS: <span>{{ $seguimiento->aplicacion->trampas ?? 'No disponible' }}</span></td>
                <td class="titulo">CAMBIAR TRAMPAS:
                  <span>{{ $seguimiento->aplicacion->trampas_cambiar ?? 'No disponible' }}</span>
                </td>
                <td class="titulo">INTERNAS: <span>{{ $seguimiento->aplicacion->internas ?? 'No disponible' }}</span>
                </td>
                <td class="titulo">EXTERNAS: <span>{{ $seguimiento->aplicacion->externas ?? 'No disponible' }}</span>
                </td>
                <td class="titulo">ROEDORES: <span>{{ $seguimiento->aplicacion->roedores ?? 'No disponible' }}</span>
                </td>
              </tr>
            @else
              <tr>
                <td colspan="5" class="titulo">FUMIGACIONES</td>
              </tr>
              <tr>
                <td class="titulo">PAREDES INTERNAS:
                  <span>{{ $seguimiento->aplicacion->paredes_internas ?? 'No disponible' }}</span>
                </td>
                <td class="titulo">PISOS: <span>{{ $seguimiento->aplicacion->pisos ?? 'No disponible' }}</span></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <td colspan="5" class="titulo">DESINFECCION</td>
              </tr>
              <tr>
                <td class="titulo">PISOS: <span>{{ $seguimiento->aplicacion->ambientes ?? 'No disponible' }}</span>
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
            @endif



          </table>
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td class="titulo">METODO UTILIZADO</td>
      </tr>
      <tr>
        <td>
          @foreach ($seguimiento->metodos as $metodo)
            {{ $loop->iteration }} : <span style="margin-right: 20px">{{ $metodo->nombre }}</span>
          @endforeach
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td class="titulo">PRODUCTO UTILIZADO</td>
      </tr>
      <tr>
        <td>


          @foreach ($seguimiento->productoUsos as $productoUso)
            {{ $loop->iteration }} : <span> {{ $productoUso->producto->nombre }}
              {{ $productoUso->unidad->nombre }} </span><br>
          @endforeach

        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td class="titulo">
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
    </table>
    <table>
      <tr>
        <td class="titulo">MEDIDAS DE PROTECCION ADOPTADAS PARA TERCEROS</td>
      </tr>
      <tr>
        <td>
          @foreach ($seguimiento->proteccions as $proteccion)
            {{ $loop->iteration }} : <span style="margin-right: 20px">{{ $proteccion->nombre }}</span>
          @endforeach
        </td>
      </tr>
    </table>
    @if ($seguimiento->tipoSeguimiento->nombre === 'DESRATIZACION')
      <table>
        <tr>
          <td class="titulo">OBSERVACIONES DE SIGNOS DE ROEDORES</td>
        </tr>
        <tr>
          <td>
            @foreach ($seguimiento->signos as $signo)
              {{ $loop->iteration }} : <span style="margin-right: 20px">{{ $signo->nombre }}</span>
            @endforeach
          </td>
        </tr>
      </table>
    @else
      <table>
        <tr>
          <td class="titulo">OBSERVACIONES DE CICLO BIOLOGICO</td>
        </tr>
        <tr>
          <td>
            @foreach ($seguimiento->biologicos as $biologico)
              {{ $loop->iteration }} : <span style="margin-right: 20px">{{ $biologico->nombre }}</span>
            @endforeach
          </td>
        </tr>
      </table>
    @endif





    <table>
      <tr>
        <td class="titulo">OBSERVACIONES BOLIVIAN PEST</td>
      </tr>
      <tr>
        <td><span>{{ $seguimiento->observacionesp }}</span></td>
      </tr>
    </table>

    <table>
      <tr>
        <td class="titulo">EVIDENCIAS</td>
      </tr>
      <tr>
        <td style="overflow: hidden; padding: 10px;">
          @foreach ($seguimiento->images as $image)
            <img src="{{ public_path($image->imagen) }}" alt=""
              style="width: 150px; max-width: 100%; height: auto; margin: 5px; vertical-align: top;">
          @endforeach
        </td>
      </tr>
    </table>
    <table>
      <tr>
        <td class="titulo">OBSERVACIONES</td>
      </tr>
      <tr>
        <td><span>{{ $seguimiento->observaciones }}</span></td>
      </tr>
    </table>

    <table>
      <tr>
        <td style="width: 50%; text-align: center;">
          <div><img src="{{ public_path($seguimiento->firma_encargado) }}" alt="" width="150px">
          </div>
          <div>ENCARGADO</div>
          <div>{{ $seguimiento->encargado_nombre }}</div>
          <div>{{ $seguimiento->encargado_cargo }}</div>
        </td>
        <td style="width: 50%; text-align: center;">
          <div><img src="{{ public_path($seguimiento->firma_supervisor) }}" alt="" width="150px">
          </div>
          <div>TECNICO</div>
          <div>{{ $seguimiento->user->name }}</div>
          <div>BOLIVIAN PEST</div>
        </td>
      </tr>
    </table>


    @if ($seguimiento->tipoSeguimiento->nombre === 'DESRATIZACION')
      {{-- <table>
        <tr>
          <td class="titulo">TRAMPAS ROEDORES</td>
        </tr>
        <tr>
          <td>
            <table>
              <tr>
                <td>#</td>
                <td>ID</td>
                <td>Observación</td>
                <td>Inicial</td>
                <td>Actual</td>
                <td>Merma</td>
              </tr>
              @foreach ($seguimiento->roedores as $roedor)
                <tr>
                  <td>{{ $loop->iteration }}</td>
                  <td>{{ $roedor->trampa_id }}</td>
                  <td>{{ $roedor->observacion }}</td>
                  <td>{{ $roedor->inicial }}</td>
                  <td>{{ $roedor->actual }}</td>
                  <td> {{ $roedor->merma }}</td>
                </tr>
              @endforeach

            </table>

          </td>
        </tr>
      </table> --}}
      <table>
        <thead>
          <tr>
            <td colspan="6" class="titulo">TRAMPAS ROEDORES</td>
          </tr>
          <tr>
            <td>#</td>
            <td>ID</td>
            <td>Observación</td>
            <td>Inicial</td>
            <td>Actual</td>
            <td>Merma</td>
          </tr>
        </thead>

        <tbody>
          @foreach ($seguimiento->roedores as $roedor)
            <tr>
              <td>{{ $loop->iteration }}</td>
              <td>{{ $roedor->trampa_id }}</td>
              <td>{{ $roedor->observacion }}</td>
              <td>{{ $roedor->inicial }}</td>
              <td>{{ $roedor->actual }}</td>
              <td>{{ $roedor->merma }}</td>
            </tr>
          @endforeach
        </tbody>
      </table>
    @else
      <table>
        <thead>
          <tr>
            <td class="titulo">INSECTOCUTORES</td>
          </tr>
          <tr>
            <td>#</td>
            <td>ID</td>
            <td>Especie</td>
            <td>Cantidad</td>
          </tr>
        </thead>
        <tbody>
          @foreach ($seguimiento->insectocutores as $insect)
            <tr>
              <td>{{ $loop->iteration }}</td>
              <td>{{ $insect->trampa_id }}</td>
              <td>{{ $insect->especie->nombre }}</td>
              <td>{{ $insect->cantidad }}</td>
            </tr>
          @endforeach
        </tbody>
      </table>
      {{-- <table>
        <tr>
          <td class="titulo">INSECTOCUTORES</td>
        </tr>
        <tr>
          <td>
            <table>
              <tr>
                <td>#</td>
                <td>ID</td>
                <td>Especie</td>
                <td>Cantidad</td>
              </tr>

              @foreach ($seguimiento->insectocutores as $insect)
                <tr>
                  <td>{{ $loop->iteration }}</td>
                  <td>{{ $insect->trampa_id }}</td>
                  <td>{{ $insect->especie->nombre }}</td>
                  <td>{{ $insect->cantidad }}</td>
                </tr>
              @endforeach
            </table>
          </td>
        </tr>
      </table> --}}
    @endif

  </div>
</body>

</html>
