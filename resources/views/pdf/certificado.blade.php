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
      background-image: url('{{ public_path('images/certificado/Certificado.png') }}');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      font-family: Arial, sans-serif;
      font-size: .8rem;
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

    .titulo {
      font-size: 2rem;
      text-align: center;
      color: #0D3347;
      margin-top: 8rem;
      font-weight: bold;
      margin-left: 3.5rem;
    }

    .establecimiento {
      margin-top: 1.5rem;
      margin-left: 9rem;
      font-style: italic;
    }

    .establecimiento span {
      font-weight: bold;
      font-size: 1.3rem;
      margin-left: 1rem;
      font-style: normal;
    }

    .contenido {
      margin-left: 8rem;
      margin-top: 1rem;
    }

    .contenido div {
      margin-top: 1.1rem;
    }

    .resaltado {
      font-size: .9rem;
      font-weight: bold;
      margin-left: 1.1rem;
      margin-right: 1.1rem;
    }

    .firma {
      margin-top: 6rem;
      font-size: .7rem;
      margin-left: 16rem;
    }

    .firmanombre {
      color: #0D3347;
    }

    .firmacargo,
    .firmaempresa {
      color: red;
    }

    /* .firma {
      background-image: url('{{ public_path('images/certificado/firma.png') }}');

    } */

    .sello {
      position: absolute;
      width: 150px;
      margin-top: -150px;
      margin-left: 480px;
    }

    .logo {
      position: absolute;
      margin-top: -550px;
      margin-left: 650px;
    }
  </style>
</head>

<body>
  <div>

    <div class="titulo">
      CERTIFICADO DE {{ $certificado->titulo }}
    </div>
    <div class="establecimiento">
      Al Establecimiento: <span class="">{{ $certificado->establecimiento }}</span>
    </div>
    <div class="contenido">
      <div>
        ACTIVIDAD DEL SOLICITANTE: <span class="resaltado">{{ $certificado->actividad }}</span> FECHA:
        <span class="resaltado">{{ $certificado->created_at }}</span>
      </div>
      <div>
        VALIDEZ DE LA CERTIFICACION: <span class="resaltado">{{ $certificado->validez }}</span>
      </div>
      <div>
        DIRECCION: <span class="resaltado">{{ $certificado->direccion }}</span>
      </div>
      <div>
        DIAGNOSTICO: <span class="resaltado">{{ $certificado->diagnostico }}</span>
      </div>
      <div>
        CONDICION SANITARIA DE LA ZONA CIRCULANTE: <span class="resaltado">{{ $certificado->condicion }}</span>
      </div>
      <div>
        TRABAJOS REALIZADOS:
        <span class="resaltado">
          @foreach (explode(',', $certificado->trabajo) as $item)
            {{ trim($item) }}<br>
          @endforeach
        </span>
      </div>

      <table>
        <tr>
          <td>PLAGUICIDAS UTILIZADOS:</td>
          <td>
            @foreach (explode(',', $certificado->plaguicidas) as $item)
              <span class="resaltado">{{ trim($item) }}</span><br>
            @endforeach
          </td>
          <td>REGISTRO:</td>
          <td>
            @foreach (explode(',', $certificado->registro) as $item)
              <span class="resaltado">{{ trim($item) }}</span><br>
            @endforeach
          </td>
        </tr>
        <tr>

        </tr>
      </table>
      {{-- PLAGUICIDAS UTILIZADOS: --}}
      {{-- <span class="resaltado">          
          @foreach (explode(',', $certificado->plaguicidas) as $item)
            {{ trim($item) }}<br>
          @endforeach
        </span> --}}

      {{-- REGISTRO: --}}
      {{-- <span class="resaltado">          
          @foreach (explode(',', $certificado->registro) as $item)
            {{ trim($item) }}<br>
          @endforeach
        </span> --}}

      <div>
        AREA TRATADA: <span class="resaltado">{{ $certificado->area }}</span> ACCIONES CORRECTIVAS: <span
          class="resaltado">{{ $certificado->acciones }}</span>
      </div>
    </div>

    <div class="firma">
      <div>
        <img src="{{ public_path('images/certificado/firma.png') }}" alt="" width="150px">
      </div>
      <div class="firmanombre">
        Ing. Agr. Freddy Montero Castillo
      </div>
      <div class="firmacargo">
        GERENTE PROPIETARIO
      </div>
      <div class="firmaempresa">
        BOLIVIAN PEST HIGIENE AMBIENTAL
      </div>
    </div>

    <div class="sello">
      <img src="{{ public_path('images/certificado/sello.png') }}" alt="" width="150px">
    </div>

    <div class="logo">
      <img src="{{ public_path($certificado->logo) }}" alt="" width="60px">
    </div>

    {{-- <div class="firma">

    </div> --}}

    {{-- <div class="sello">

    </div> --}}


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
