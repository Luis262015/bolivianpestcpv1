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

    .totalcotizacion {
      text-align: right;
      font-size: .8rem;
      margin: 10px 0;
      font-style: italic;
      text-decoration: underline;
      font-weight: bold;
    }

    .totalcotizacion span {
      font-size: 1rem;
      font-weight: bold;
      font-style: normal;
    }
  </style>
</head>

<body>
  <div class="contenido">

    <div style="font-size: 1.2rem; font-weight: bold; margin-bottom: 1rem;">COTIZACION</div>
    <div style="font-size: .8rem; font-weight: bold; margin-bottom: 1rem; font-style: italic;">Informacion del Cliente
    </div>
    <table style="width: 100%">
      <tr>
        <td class="label">Nombre del cliente</td>
        <td class="label">Fecha de cotizacion</td>
      </tr>
      <tr>
        <td>{{ $cotizacion->nombre }}</td>
        <td>{{ $cotizacion->created_at }}</td>
      </tr>
      <tr>
        <td class="label">Email</td>
        <td class="label">Teléfono</td>
      </tr>
      <tr>
        <td>{{ $cotizacion->email }}</td>
        <td>{{ $cotizacion->telefono }}</td>
      </tr>
    </table>

    @foreach ($cotizacion['detalles'] as $detalles)
      <hr>
      <div style="font-size: .8rem; font-weight: bold; margin-bottom: 1rem; font-style: italic;">Almacen:
        {{ $detalles->nombre }} Nro: {{ $detalles->id }}</div>

      <table style="width: 100%;">
        <tr>
          <td class="label">Nombre del almacen</td>
        </tr>
        <tr>
          <td>{{ $detalles->nombre }}</td>
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
          <td>{{ $detalles['t_cantidad'] }}</td>
          <td>{{ $detalles['t_visitas'] }}</td>
          <td>(Bs.) {{ number_format($detalles['t_precio'], 2) }}</td>
        </tr>
        <tr>
          <td colspan="3" class="subtotal" style="text-align: right;">Subtotal: (Bs.)
            <span>{{ number_format($detalles['t_total'], 2) }}</span>
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
          <td>{{ $detalles['a_area'] }}</td>
          <td>{{ $detalles['a_visitas'] }}</td>
          <td>(Bs.) {{ number_format($detalles['a_precio'], 2) }}</td>
        </tr>
        <tr>
          <td colspan="3" class="subtotal" style="text-align: right;">Subtotal: (Bs.)
            <span>{{ number_format($detalles['a_total'], 2) }}</span>
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
          <td>{{ $detalles['i_cantidad'] }}</td>
          <td>(Bs.) {{ number_format($detalles['i_precio'], 2) }}</td>
        </tr>
        <tr>
          <td colspan="2" class="subtotal" style="text-align: right;">Subtotal: (Bs.)
            <span>{{ number_format($detalles['i_total'], 2) }}</span>
          </td>
        </tr>
      </table>
      <div class="total">Total este almacen: (Bs.)
        <span>{{ number_format($detalles['t_total'] + $detalles['a_total'] + $detalles['i_total'], 2) }}</span>
      </div>
    @endforeach

    <hr>
    <div class="totalcotizacion">Precio Total Cotizacion: (Bs.)
      <span>{{ number_format($cotizacion['total'], 2) }}</span>
    </div>




  </div>
</body>

</html>
