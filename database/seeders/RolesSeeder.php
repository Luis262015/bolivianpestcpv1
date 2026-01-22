<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        // Reset cache
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        // PERMISOS
        Permission::firstOrCreate(['name' => 'empresas']);
        Permission::firstOrCreate(['name' => 'cotizaciones']);
        Permission::firstOrCreate(['name' => 'contratos']);
        Permission::firstOrCreate(['name' => 'almacenes']);
        Permission::firstOrCreate(['name' => 'cronogramas']);
        Permission::firstOrCreate(['name' => 'mapas']);
        Permission::firstOrCreate(['name' => 'seguimientos']);
        Permission::firstOrCreate(['name' => 'certificados']);

        Permission::firstOrCreate(['name' => 'cuentascobrar']);
        Permission::firstOrCreate(['name' => 'cuentaspagar']);
        Permission::firstOrCreate(['name' => 'compras']);
        Permission::firstOrCreate(['name' => 'ingresos']);
        Permission::firstOrCreate(['name' => 'retiros']);
        Permission::firstOrCreate(['name' => 'gastos']);
        Permission::firstOrCreate(['name' => 'productos']);
        Permission::firstOrCreate(['name' => 'categorias']);
        Permission::firstOrCreate(['name' => 'subcategorias']);
        Permission::firstOrCreate(['name' => 'marcas']);
        Permission::firstOrCreate(['name' => 'etiquetas']);
        Permission::firstOrCreate(['name' => 'proveedores']);
        Permission::firstOrCreate(['name' => 'inventario']);

        Permission::firstOrCreate(['name' => 'agenda']);
        Permission::firstOrCreate(['name' => 'documentos']);
        Permission::firstOrCreate(['name' => 'usuarios']);
        Permission::firstOrCreate(['name' => 'configuraciones']);

        // ROLES
        $superadmin = Role::firstOrCreate(['name' => 'superadmin']);
        Role::firstOrCreate(['name' => 'admin']);
        Role::firstOrCreate(['name' => 'tecnico']);
        Role::firstOrCreate(['name' => 'cliente']);

        $superadmin->syncPermissions(Permission::all());

        // Datos de Metodos
        DB::table('metodos')->insert([
            ['nombre' => 'Alimento con veneno'],
            ['nombre' => 'Sustancia pegajosa'],
            ['nombre' => 'Alimento'],
            ['nombre' => 'Aspersion'],
            ['nombre' => 'Niebla'],
            ['nombre' => 'Nebulizacion'],
            ['nombre' => 'Fumigacion'],
            ['nombre' => 'Otros'],
        ]);
        // Datos de Epps
        DB::table('epps')->insert([
            ['nombre' => 'Ropa de trabajo'],
            ['nombre' => 'Casco de proteccion'],
            ['nombre' => 'Gorra'],
            ['nombre' => 'Guantes'],
            ['nombre' => 'Overol'],
            ['nombre' => 'Botas'],
            ['nombre' => 'Gafas'],
            ['nombre' => 'Antiparras'],
            ['nombre' => 'Respirados'],
            ['nombre' => 'Full face'],
            ['nombre' => 'Otros'],
        ]);
        // Datos de Protecciones
        DB::table('protecciones')->insert([
            ['nombre' => 'Señalizacion'],
            ['nombre' => 'Hoja de seguimiento'],
            ['nombre' => 'Otros'],
        ]);
        // Datos de Biologicos
        DB::table('biologicos')->insert([
            ['nombre' => 'Adulto'],
            ['nombre' => 'Huevo'],
            ['nombre' => 'Larva'],
            ['nombre' => 'Ninfa'],
            ['nombre' => 'Pupa'],
            ['nombre' => 'Otros'],
        ]);
        // Datos de Signos
        DB::table('signos')->insert([
            ['nombre' => 'Huellas'],
            ['nombre' => 'Roeduras'],
            ['nombre' => 'Madriguera'],
            ['nombre' => 'Senda'],
            ['nombre' => 'Excrementos'],
            ['nombre' => 'Marca de orina'],
            ['nombre' => 'Otros'],
        ]);

        DB::table('especies')->insert([
            ['nombre' => 'Moscas'],
            ['nombre' => 'Polillas'],
            ['nombre' => 'Mosquitos'],
        ]);

        DB::table('cuenta_financieros')->insert([
            ['nombre' => 'Sueldos administrativos'],
            ['nombre' => 'Honorarios profesionales'],
            ['nombre' => 'Utiles de oficina'],
            ['nombre' => 'Alquiler de oficina'],
            ['nombre' => 'Energia Electrica'],
            ['nombre' => 'Agua'],
            ['nombre' => 'Telefono'],
            ['nombre' => 'Mantenimiento y reparaciones'],
            ['nombre' => 'Limpieza'],
            ['nombre' => 'Seguros'],
            ['nombre' => 'Depresiacion'],
        ]);
        DB::table('cuenta_operativos')->insert([
            ['nombre' => 'Sueldos personal'],
            ['nombre' => 'Comisiones sobre ventas'],
            ['nombre' => 'Marketing digital'],
            ['nombre' => 'Material promocional'],
            ['nombre' => 'Transporte y distribucion'],
            ['nombre' => 'Combustible'],
            ['nombre' => 'Viaticos y movilidad'],
            ['nombre' => 'Empaques y embalajes'],
        ]);
        DB::table('cuenta_extras')->insert([
            ['nombre' => 'Gastos bancarios operativos'],
            ['nombre' => 'Capacitacion y cursos'],
            ['nombre' => 'Licencias de Software'],
            ['nombre' => 'Gastos de representación'],
            ['nombre' => 'Eventos y actividades'],
            ['nombre' => 'Seguridad y vigilancia'],
        ]);

        DB::table('unidades')->insert([
            ['nombre' => 'Gramos'],
            ['nombre' => 'C.C.'],
            ['nombre' => 'Unidad'],
            ['nombre' => 'Litros'],
        ]);

        DB::table('tipo_seguimientos')->insert([
            ['nombre' => 'DESINFECCION'],
            ['nombre' => 'DESRATIZACION'],
            ['nombre' => 'DESINSECTACION'],
            ['nombre' => 'CONTROL DE AVES'],
        ]);

        // Carga de Tipos de Trampas
        DB::table('trampa_tipos')->insert([
            ['nombre' => 'golpe', 'imagen' => '/images/trampas/trampa_raton.jpg'],
            ['nombre' => 'insecto', 'imagen' => '/images/trampas/trampa_insecto.jpg'],
            ['nombre' => 'caja', 'imagen' => '/images/trampas/caja_negra.jpg'],
            ['nombre' => 'viva', 'imagen' => '/images/trampas/captura_viva.jpg'],
            ['nombre' => 'pegajosa', 'imagen' => '/images/trampas/pegajosa.png'],
        ]);
    }
}
