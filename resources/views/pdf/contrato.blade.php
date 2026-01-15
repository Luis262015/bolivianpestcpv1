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

    body {
      font-family: Arial, sans-serif;
      font-size: .8rem;
    }

    .contenido {
      margin: 2rem;
    }

    hr {
      border: none;
      /* Elimina el borde por defecto */
      height: 1px;
      /* Define el grosor */
      background-color: #5f5f5f;
      /* Color de la línea */
      width: 80%;
      /* Ancho de la línea */
      margin: 20px auto;
      /* Centrar y añadir espacio */
    }

    .label {
      font-size: .65rem;
      font-weight: bold;
      font-style: italic;
    }

    .subtitle {
      margin: .5rem 0;
      font-weight: bold;
      font-size: .7rem;

    }

    .subtitle span {
      color: white;
      background-color: #8b8b8b;
      padding: 4px 8px;
    }



    .total {
      text-align: right;
      font-size: .8rem;
      margin: 10px 0;
      font-style: italic;
    }

    .total span {
      font-size: 1rem;
      font-weight: bold;
      font-style: normal;
    }

    .tablevisitas {
      width: 100%;
      font-size: .7rem;
    }

    .tablevisitas,
    .tablevisitas td,
    .tablevisitas th {
      border: 1px solid #5f5f5f;
      border-collapse: collapse;
    }

    .tableservicio {
      width: 100%;
      font-size: .7rem;
    }

    .tableservicio,
    .tableservicio td {
      border: 1px solid #5f5f5f;
      border-collapse: collapse;
      text-align: center;
    }

    .subtotal {
      text-align: right;
      font-size: .7rem;
    }

    .subtotal span {
      font-size: .9rem;
      font-weight: bold;
    }

    .totalcontrato {
      text-align: right;
      font-size: .8rem;
      margin: 10px 0;
      font-style: italic;
      text-decoration: underline;
      font-weight: bold;
    }

    .totalcontrato span {
      font-size: 1rem;
      font-weight: bold;
      font-style: normal;
    }
  </style>
</head>

<body>
  <div class="contenido">

    <div style="font-size: 1.2rem; font-weight: bold; margin-bottom: 1rem;">CONTRATO</div>
    <div style="font-size: .8rem; font-weight: bold; margin-bottom: 1rem; font-style: italic;">Informacion del Cliente
    </div>
    <table style="width: 100%">
      <tr>
        <td class="label">Nombre del cliente</td>
        <td class="label">Fecha de finalizacion del contrato</td>
      </tr>
      <tr>
        <td>{{ $contrato->empresa->nombre }}</td>
        <td>{{ $contrato->expiracion }}</td>
      </tr>
      <tr>
        <td class="label">Email</td>
        <td class="label">Teléfono</td>
      </tr>
      <tr>
        <td>{{ $contrato->empresa->email }}</td>
        <td>{{ $contrato->empresa->telefono }}</td>
      </tr>
      <tr>
        <td class="label">Ciudad</td>
        <td class="label">Direccion</td>
      </tr>
      <tr>
        <td>{{ $contrato->empresa->ciudad }}</td>
        <td>{{ $contrato->empresa->direccion }}</td>
      </tr>
    </table>

    @foreach ($almacenes as $almacen)
      <hr>
      <div style="font-size: .8rem; font-weight: bold; margin-bottom: 1rem; font-style: italic;">Almacen:
        {{ $almacen->nombre }} Nro: {{ $almacen->id }}</div>
      <table style="width: 100%;">
        <tr>
          <td class="label">Nombre del almacen</td>
          <td class="label">Email</td>
        </tr>
        <tr>
          <td>{{ $almacen->nombre }}</td>
          <td>{{ $almacen->email }}</td>
        </tr>
        <tr>
          <td class="label">Direccion</td>
          <td class="label">Cuidad</td>
        </tr>
        <tr>
          <td>{{ $almacen->direccion }}</td>
          <td>{{ $almacen->ciudad }}</td>
        </tr>
        <tr>
          <td class="label">Encargado</td>
          <td class="label">Telefono</td>
        </tr>
        <tr>
          <td>{{ $almacen->encargado }}</td>
          <td>{{ $almacen->telefono }}</td>
        </tr>
      </table>
      <div class="subtitle"><span>Servicio de Trampas</span></div>
      <table class="tableservicio">
        <tr>
          <td class="label" style="width: 25%">Cantidad</td>
          <td class="label" style="width: 25%">Visitas</td>
          <td class="label" style="width: 50%">Precio</td>
        </tr>
        <tr>
          <td>{{ $almacen['almacenTrampa']['cantidad'] }}</td>
          <td>{{ $almacen['almacenTrampa']['visitas'] }}</td>
          <td>(Bs.) {{ number_format($almacen['almacenTrampa']['precio'], 2) }}</td>
        </tr>
        <tr>
          <td colspan="3" class="subtotal" style="text-align: right;">Subtotal: (Bs.)
            <span>{{ number_format($almacen['almacenTrampa']['total'], 2) }}</span>
          </td>
        </tr>
      </table>
      <div class="subtitle"><span>Servicio por areas</span></div>
      <table class="tableservicio">
        <tr>
          <td class="label" style="width: 25%">Area</td>
          <td class="label" style="width: 25%">Visitas</td>
          <td class="label" style="width: 50%">Precio</td>
        </tr>
        <tr>
          <td>{{ $almacen['almacenArea']['area'] }}</td>
          <td>{{ $almacen['almacenArea']['visitas'] }}</td>
          <td>(Bs.) {{ number_format($almacen['almacenArea']['precio'], 2) }}</td>
        </tr>
        <tr>
          <td colspan="3" class="subtotal" style="text-align: right;">Subtotal: (Bs.)
            <span>{{ number_format($almacen['almacenArea']['total'], 2) }}</span>
          </td>
        </tr>
      </table>
      <div class="subtitle"><span>Servicio por insectocutores</span></div>
      <table class="tableservicio">
        <tr>
          <td class="label" style="width: 50%">Cantidad</td>
          <td class="label" style="width: 50%">Precio</td>
        </tr>
        <tr>
          <td>{{ $almacen['almacenInsectocutor']['cantidad'] }}</td>
          <td>(Bs.) {{ number_format($almacen['almacenInsectocutor']['precio'], 2) }}</td>
        </tr>
        <tr>
          <td colspan="2" class="subtotal" style="text-align: right;">Subtotal: (Bs.)
            <span>{{ number_format($almacen['almacenInsectocutor']['total'], 2) }}</span>
          </td>
        </tr>
      </table>
      <div class="total">Total este almacen: (Bs.)
        <span>{{ number_format($almacen['almacenTrampa']['total'] + $almacen['almacenArea']['total'] + $almacen['almacenInsectocutor']['total'], 2) }}</span>
      </div>

      <div class="subtitle"><span>Cronograma de visitas</span></div>
      <table class="tablevisitas">
        <tr>
          <th>Numero</th>
          <th>Fecha</th>
          <th>Tipo</th>
        </tr>
        @foreach ($almacen['tareas'] as $tarea)
          <tr>
            <td style="text-align: center">{{ $tarea->id }}</td>
            {{-- <td>{{ $tarea->date }}</td> --}}
            {{-- <td>{{ \Carbon\Carbon::parse($tarea->date)->format('d/m/Y H:i:s') }}</td> --}}
            <td style="text-align: center">{{ \Carbon\Carbon::parse($tarea->date)->format('d/m/Y') }}</td>
            {{-- <td>{{ \Carbon\Carbon::parse($tarea->date)->format('d \d\e F \d\e Y') }}</td> --}}
            {{-- <td>{{ \Carbon\Carbon::parse($tarea->date)->locale('es')->format('d \d\e F \d\e Y') }}</td> --}}
            <td style="text-align: center">{{ $tarea->title }}</td>
          </tr>
        @endforeach
      </table>
    @endforeach

    <hr>
    <div class="totalcontrato">Precio Total Contrato: (Bs.)
      <span>{{ number_format($contrato['total'], 2) }}</span>
    </div>




  </div>
</body>

</html>
