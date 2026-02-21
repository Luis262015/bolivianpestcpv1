{{-- resources/views/pdf/clientes.blade.php --}}
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <title>PDF Cierre</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    @page {
      margin: 0;
    }


    body {
      font-size: 1rem;
      font-family: Arial, sans-serif;
    }


    .contenido {
      margin: 1rem 2rem;
    }

    .titulo {
      font-size: 1.5rem;
      font-weight: bold;
    }

    .fechas {
      font-size: .8rem;
      color: gray;
      margin-bottom: 1rem;
    }

    .fechas span {
      font-family: 'Courier New', Courier, monospace;
    }

    .monto {
      text-align: right;
      font-family: 'Courier New', Courier, monospace;
    }

    table {
      width: 60%;
    }

    td {
      padding: .4rem 0;
    }

    /*.header {
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
    } */
  </style>
</head>

<body>
  <div class="contenido">
    <div class="titulo">Estado de resultados</div>
    <div class="fechas">Fechas: <span>{{ \Carbon\Carbon::parse($estado->fecha_inicio)->format('d/m/Y') }}</span> al
      <span>{{ \Carbon\Carbon::parse($estado->fecha_fin)->format('d/m/Y') }}</span>
    </div>

    <table>
      <tr>
        <td class="subtitle">INGRESOS</td>
        <td></td>
      </tr>
      <tr>
        <td style="padding-left: 1rem;">Ventas</td>
        <td class="monto">Bs. {{ number_format($estado->ventas, 2) }}</td>
      </tr>
      <tr>
        <td style="padding-left: 1rem;">Cobrado (x cobrar)</td>
        <td class="monto">Bs. {{ number_format($estado->cobrado, 2) }}</td>
      </tr>
      <tr>
        <td style="padding-left: 1rem;">Otros ingresos</td>
        <td class="monto">Bs. {{ number_format($estado->otros_ingresos, 2) }}</td>
      </tr>
      <tr>
        <td class="totales">= INGRESOS TOTALES</td>
        <td class="monto">Bs. {{ number_format($estado->ingresos_totales, 2) }}</td>
      </tr>
      <tr>
        <td class="subtitle">(-) COSTOS</td>
        <td></td>
      </tr>
      <tr>
        <td style="padding-left: 1rem;">Compras</td>
        <td class="monto">Bs. {{ number_format($estado->compras, 2) }}</td>
      </tr>
      <tr>
        <td class="totales">= COSTO TOTAL</td>
        <td class="monto">Bs. {{ number_format($estado->costo_total, 2) }}</td>
      </tr>
      <tr>
        <td class="subtitle">= UTILIDAD BRUTA</td>
        <td class="monto">Bs. {{ number_format($estado->utilidad_bruta, 2) }}</td>
      </tr>
      <tr>c
        <td class="subtitle">(-) GASTOS</td>
        <td></td>
      </tr>
      <tr>
        <td style="padding-left: 1rem;">Operativos</td>
        <td class="monto">Bs. {{ number_format($estado->gastosop, 2) }}</td>
      </tr>
      <tr>
        <td style="padding-left: 1rem;">Financieros</td>
        <td class="monto">Bs. {{ number_format($estado->gastosfin, 2) }}</td>
      </tr>
      <tr>
        <td style="padding-left: 1rem;">Extraordinarios</td>
        <td class="monto">Bs. {{ number_format($estado->gastosext, 2) }}</td>
      </tr>
      <tr>
        <td style="padding-left: 1rem;">Caja Chica</td>
        <td class="monto">Bs. {{ number_format($estado->gastos, 2) }}</td>
      </tr>
      <tr>
        <td style="padding-left: 1rem;">Pagos (x pagar)</td>
        <td class="monto">Bs. {{ number_format($estado->pagos, 2) }}</td>
      </tr>
      <tr>
        <td class="totales">= GASTOS TOTALES</td>
        <td class="monto">Bs. {{ number_format($estado->total_gastos, 2) }}</td>
      </tr>
      <tr>
        <td>= UTILIDAD NETA DEL MES</td>
        <td class="monto">Bs. {{ number_format($estado->utilidad_neta, 2) }}</td>
      </tr>

    </table>
  </div>
</body>

</html>
