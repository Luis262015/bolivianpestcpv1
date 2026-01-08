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
      margin: 0;
      padding: 0;
      width: 100%;
      height: 100%;

      background-image: url('{{ public_path('images/certificado/Certificado.png') }}');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;

      font-family: DejaVu Sans, sans-serif;
    }

    .contenido {
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
    }
  </style>
</head>

<body>
  <div class="contenido">

    {{-- <div class="text-center mb-8">
      <h1 class="text-3xl font-bold">CERTIFICADO XXX</h1>
      <p class="text-gray-600">Generado el {{ now()->format('d/m/Y H:i') }}</p>
    </div>

    <table>
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
