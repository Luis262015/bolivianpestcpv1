<?php

namespace App\Http\Controllers;

use App\Models\SiteSetting;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class SiteSettingController extends Controller
{
    /**
     * Editor del landing. Solo admin/superadmin (protegido por middleware de ruta).
     */
    public function index()
    {
        return inertia('admin/sitio/index', [
            'groups' => SiteSetting::grouped(),
        ]);
    }

    /**
     * Guarda todos los valores enviados. Las imágenes ya vienen como URL
     * (subidas previamente vía upload()); aquí solo se persisten cadenas.
     */
    public function update(Request $request)
    {
        $validated = $request->validate([
            'settings'   => 'required|array',
            'settings.*' => 'nullable',
        ]);

        foreach ($validated['settings'] as $key => $value) {
            $setting = SiteSetting::where('key', $key)->first();
            if (! $setting) {
                continue;
            }

            if ($setting->type === 'json') {
                // Llega como array desde Inertia; lo guardamos como JSON.
                $value = json_encode($value, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            }

            $setting->update(['value' => $value]);
        }

        return redirect()->route('sitio.index')->with('success', 'Configuración del sitio actualizada');
    }

    /**
     * Sube una imagen al directorio público (public/images/landing) y
     * devuelve su ruta pública para guardarla como valor de la configuración.
     */
    public function upload(Request $request)
    {
        $request->validate([
            'imagen' => 'required|image|mimes:jpeg,jpg,png,webp,gif,svg|max:5120',
        ]);

        $file = $request->file('imagen');
        $name = Str::uuid()->toString() . '.' . strtolower($file->getClientOriginalExtension());

        $destination = public_path('images/landing');
        if (! is_dir($destination)) {
            mkdir($destination, 0755, true);
        }

        $file->move($destination, $name);

        return response()->json([
            'url' => '/images/landing/' . $name,
        ]);
    }
}
