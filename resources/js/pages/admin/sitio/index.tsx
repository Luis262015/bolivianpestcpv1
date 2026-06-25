import { Button } from '@/components/ui/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import AppLayout from '@/layouts/app-layout';
import { cn } from '@/lib/utils';
import { type BreadcrumbItem } from '@/types';
import { Head, router, usePage } from '@inertiajs/react';
import axios from 'axios';
import {
  ArrowDown,
  ArrowUp,
  ImagePlus,
  Loader2,
  Plus,
  Save,
  Trash2,
} from 'lucide-react';
import { useMemo, useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Sitio Web', href: '/sitio' },
];

type SettingType = 'text' | 'textarea' | 'url' | 'image' | 'json';

interface Setting {
  key: string;
  value: unknown;
  type: SettingType;
  group: string;
  label: string | null;
  order: number;
}

type Groups = Record<string, Setting[]>;

// Etiquetas legibles + orden de las pestañas
const GROUP_META: Record<string, string> = {
  brand: 'Marca',
  hero: 'Hero',
  features: 'Características',
  about: 'Nosotros',
  services: 'Servicios',
  portfolio: 'Portafolio',
  ourfeatures: 'Nuestros servicios',
  why: 'Por qué elegirnos',
  faq: 'Preguntas (FAQ)',
  contact: 'Contacto',
  social: 'Redes sociales',
  seo: 'SEO',
};

const GROUP_ORDER = Object.keys(GROUP_META);

// Iconos de Lucide permitidos para las colecciones que usan icono
const ICON_OPTIONS = [
  'Factory', 'Rat', 'Snail', 'HouseWifi', 'Building2', 'Siren', 'Settings',
  'ShieldCheck', 'BadgeCheck', 'Bug', 'Home', 'Shield', 'Sparkles', 'Leaf',
  'Clock', 'Phone', 'Star', 'CheckCircle2',
];

// Esquema de campos para cada colección JSON.
// type 'string' = lista simple de textos; arreglo de campos = lista de objetos.
type FieldType = 'text' | 'textarea' | 'image' | 'icon';
interface FieldDef {
  name: string;
  label: string;
  type: FieldType;
}
const COLLECTION_SCHEMAS: Record<string, FieldDef[] | 'string'> = {
  'hero.chips': 'string',
  'about.benefits': 'string',
  'hero.slides': [
    { name: 'img', label: 'Imagen', type: 'image' },
    { name: 'alt', label: 'Texto alternativo', type: 'text' },
  ],
  'features.items': [
    { name: 'icon', label: 'Icono (imagen)', type: 'image' },
    { name: 'title', label: 'Título', type: 'text' },
    { name: 'alt', label: 'Texto alternativo', type: 'text' },
  ],
  'about.stats': [
    { name: 'end', label: 'Número', type: 'text' },
    { name: 'suffix', label: 'Sufijo (+, K, %)', type: 'text' },
    { name: 'label', label: 'Etiqueta', type: 'text' },
  ],
  'services.items': [
    { name: 'img', label: 'Imagen', type: 'image' },
    { name: 'icon', label: 'Icono', type: 'icon' },
    { name: 'category', label: 'Categoría', type: 'text' },
    { name: 'title', label: 'Título', type: 'text' },
    { name: 'desc', label: 'Descripción', type: 'textarea' },
    { name: 'alt', label: 'Texto alternativo', type: 'text' },
  ],
  'portfolio.videos': [
    { name: 'id', label: 'ID del video de TikTok', type: 'text' },
    { name: 'label', label: 'Etiqueta', type: 'text' },
  ],
  'ourfeatures.items': [
    { name: 'icon', label: 'Icono', type: 'icon' },
    { name: 'title', label: 'Título', type: 'text' },
    { name: 'desc', label: 'Descripción', type: 'textarea' },
    { name: 'iconWrap', label: 'Clases del icono (avanzado)', type: 'text' },
  ],
  'faq.items': [
    { name: 'question', label: 'Pregunta', type: 'text' },
    { name: 'answer', label: 'Respuesta (acepta HTML)', type: 'textarea' },
  ],
};

/* ------------------------------------------------------------------ */
/* Subida de imágenes a public/images/landing                          */
/* ------------------------------------------------------------------ */
function ImageField({
  value,
  onChange,
}: {
  value: string;
  onChange: (url: string) => void;
}) {
  const [uploading, setUploading] = useState(false);

  const handleFile = async (file: File) => {
    const fd = new FormData();
    fd.append('imagen', file);
    setUploading(true);
    try {
      const { data } = await axios.post('/sitio/upload', fd, {
        headers: { 'Content-Type': 'multipart/form-data' },
      });
      onChange(data.url);
    } catch {
      alert('No se pudo subir la imagen. Verifique el formato (jpg, png, webp, svg) y el tamaño (máx 5MB).');
    } finally {
      setUploading(false);
    }
  };

  return (
    <div className="flex items-start gap-3">
      <div className="flex h-20 w-20 shrink-0 items-center justify-center overflow-hidden rounded-lg border bg-muted">
        {value ? (
          <img src={value} alt="preview" className="h-full w-full object-contain" />
        ) : (
          <ImagePlus className="h-6 w-6 text-muted-foreground" />
        )}
      </div>
      <div className="flex-1 space-y-2">
        <Input
          value={value ?? ''}
          onChange={(e) => onChange(e.target.value)}
          placeholder="/images/..."
        />
        <div>
          <label className="inline-flex cursor-pointer items-center gap-2 rounded-md border bg-background px-3 py-1.5 text-sm font-medium transition-colors hover:bg-accent">
            {uploading ? (
              <Loader2 className="h-4 w-4 animate-spin" />
            ) : (
              <ImagePlus className="h-4 w-4" />
            )}
            {uploading ? 'Subiendo...' : 'Subir imagen'}
            <input
              type="file"
              accept="image/*"
              className="hidden"
              disabled={uploading}
              onChange={(e) => {
                if (e.target.files?.[0]) handleFile(e.target.files[0]);
                e.target.value = '';
              }}
            />
          </label>
        </div>
      </div>
    </div>
  );
}

/* ------------------------------------------------------------------ */
/* Editor de un campo individual dentro de una colección               */
/* ------------------------------------------------------------------ */
function CollectionField({
  field,
  value,
  onChange,
}: {
  field: FieldDef;
  value: string;
  onChange: (v: string) => void;
}) {
  if (field.type === 'image') {
    return <ImageField value={value ?? ''} onChange={onChange} />;
  }
  if (field.type === 'textarea') {
    return (
      <Textarea
        value={value ?? ''}
        onChange={(e) => onChange(e.target.value)}
        rows={3}
      />
    );
  }
  if (field.type === 'icon') {
    return (
      <select
        value={value ?? ''}
        onChange={(e) => onChange(e.target.value)}
        className="flex h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm"
      >
        <option value="">— Sin icono —</option>
        {ICON_OPTIONS.map((ic) => (
          <option key={ic} value={ic}>
            {ic}
          </option>
        ))}
      </select>
    );
  }
  return <Input value={value ?? ''} onChange={(e) => onChange(e.target.value)} />;
}

/* ------------------------------------------------------------------ */
/* Repetidor de colección JSON                                         */
/* ------------------------------------------------------------------ */
function Repeater({
  settingKey,
  value,
  onChange,
}: {
  settingKey: string;
  value: unknown;
  onChange: (v: unknown) => void;
}) {
  const schema = COLLECTION_SCHEMAS[settingKey];
  const items: unknown[] = Array.isArray(value) ? value : [];

  const updateItem = (idx: number, newItem: unknown) => {
    const next = [...items];
    next[idx] = newItem;
    onChange(next);
  };
  const removeItem = (idx: number) => {
    onChange(items.filter((_, i) => i !== idx));
  };
  const move = (idx: number, dir: -1 | 1) => {
    const target = idx + dir;
    if (target < 0 || target >= items.length) return;
    const next = [...items];
    [next[idx], next[target]] = [next[target], next[idx]];
    onChange(next);
  };
  const addItem = () => {
    if (schema === 'string') {
      onChange([...items, '']);
    } else {
      const empty: Record<string, string> = {};
      (schema as FieldDef[]).forEach((f) => (empty[f.name] = ''));
      onChange([...items, empty]);
    }
  };

  return (
    <div className="space-y-3">
      {items.map((item, idx) => (
        <div
          key={idx}
          className="rounded-lg border bg-muted/30 p-3"
        >
          <div className="mb-2 flex items-center justify-between">
            <span className="text-xs font-semibold text-muted-foreground">
              #{idx + 1}
            </span>
            <div className="flex items-center gap-1">
              <Button
                type="button"
                variant="ghost"
                size="icon"
                className="h-7 w-7"
                onClick={() => move(idx, -1)}
                disabled={idx === 0}
              >
                <ArrowUp className="h-4 w-4" />
              </Button>
              <Button
                type="button"
                variant="ghost"
                size="icon"
                className="h-7 w-7"
                onClick={() => move(idx, 1)}
                disabled={idx === items.length - 1}
              >
                <ArrowDown className="h-4 w-4" />
              </Button>
              <Button
                type="button"
                variant="ghost"
                size="icon"
                className="h-7 w-7 text-red-600 hover:text-red-700"
                onClick={() => removeItem(idx)}
              >
                <Trash2 className="h-4 w-4" />
              </Button>
            </div>
          </div>

          {schema === 'string' ? (
            <Input
              value={(item as string) ?? ''}
              onChange={(e) => updateItem(idx, e.target.value)}
            />
          ) : (
            <div className="grid gap-3 sm:grid-cols-2">
              {(schema as FieldDef[]).map((f) => {
                const obj = (item as Record<string, string>) ?? {};
                const isWide = f.type === 'textarea' || f.type === 'image';
                return (
                  <div
                    key={f.name}
                    className={cn('space-y-1', isWide && 'sm:col-span-2')}
                  >
                    <Label className="text-xs">{f.label}</Label>
                    <CollectionField
                      field={f}
                      value={obj[f.name] ?? ''}
                      onChange={(v) =>
                        updateItem(idx, { ...obj, [f.name]: v })
                      }
                    />
                  </div>
                );
              })}
            </div>
          )}
        </div>
      ))}

      <Button type="button" variant="outline" size="sm" onClick={addItem}>
        <Plus className="mr-1 h-4 w-4" />
        Agregar elemento
      </Button>
    </div>
  );
}

/* ------------------------------------------------------------------ */
/* Página principal                                                    */
/* ------------------------------------------------------------------ */
export default function SitioIndex() {
  const { props } = usePage();
  const groups = (props.groups ?? {}) as Groups;

  // Estado plano: key -> value
  const [values, setValues] = useState<Record<string, unknown>>(() => {
    const flat: Record<string, unknown> = {};
    Object.values(groups).forEach((arr) =>
      arr.forEach((s) => {
        flat[s.key] = s.value;
      }),
    );
    return flat;
  });

  const orderedGroups = useMemo(
    () =>
      Object.keys(groups).sort(
        (a, b) => GROUP_ORDER.indexOf(a) - GROUP_ORDER.indexOf(b),
      ),
    [groups],
  );

  const [activeGroup, setActiveGroup] = useState(orderedGroups[0] ?? '');
  const [saving, setSaving] = useState(false);

  const setValue = (key: string, v: unknown) =>
    setValues((prev) => ({ ...prev, [key]: v }));

  const submit = () => {
    setSaving(true);
    router.post(
      '/sitio',
      { settings: values } as never,
      {
        preserveScroll: true,
        onFinish: () => setSaving(false),
      },
    );
  };

  const renderField = (s: Setting) => {
    const v = values[s.key];
    switch (s.type) {
      case 'textarea':
        return (
          <Textarea
            value={(v as string) ?? ''}
            onChange={(e) => setValue(s.key, e.target.value)}
            rows={3}
          />
        );
      case 'image':
        return (
          <ImageField
            value={(v as string) ?? ''}
            onChange={(url) => setValue(s.key, url)}
          />
        );
      case 'json':
        return (
          <Repeater
            settingKey={s.key}
            value={v}
            onChange={(nv) => setValue(s.key, nv)}
          />
        );
      default:
        return (
          <Input
            value={(v as string) ?? ''}
            onChange={(e) => setValue(s.key, e.target.value)}
          />
        );
    }
  };

  const activeSettings = (groups[activeGroup] ?? [])
    .slice()
    .sort((a, b) => a.order - b.order);

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Configuración del sitio" />

      <div className="m-4 space-y-5">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div>
            <h1 className="text-2xl font-bold">Configuración del sitio web</h1>
            <p className="text-sm text-muted-foreground">
              Edite los textos e imágenes de la página de inicio. Los cambios se
              reflejan en la ruta «/».
            </p>
          </div>
          <Button onClick={submit} disabled={saving}>
            {saving ? (
              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
            ) : (
              <Save className="mr-2 h-4 w-4" />
            )}
            Guardar cambios
          </Button>
        </div>

        {/* Pestañas de grupos */}
        <div className="flex flex-wrap gap-2 border-b pb-3">
          {orderedGroups.map((g) => (
            <button
              key={g}
              type="button"
              onClick={() => setActiveGroup(g)}
              className={cn(
                'rounded-full px-4 py-1.5 text-sm font-medium transition-colors',
                activeGroup === g
                  ? 'bg-primary text-primary-foreground'
                  : 'bg-muted text-muted-foreground hover:bg-accent',
              )}
            >
              {GROUP_META[g] ?? g}
            </button>
          ))}
        </div>

        {/* Campos del grupo activo */}
        <Card>
          <CardHeader>
            <CardTitle>{GROUP_META[activeGroup] ?? activeGroup}</CardTitle>
            <CardDescription>
              {activeSettings.length} campo(s) configurable(s)
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            {activeSettings.map((s) => (
              <div key={s.key} className="space-y-2">
                <Label className="font-semibold">
                  {s.label ?? s.key}
                </Label>
                {renderField(s)}
              </div>
            ))}
          </CardContent>
        </Card>

        <div className="flex justify-end">
          <Button onClick={submit} disabled={saving}>
            {saving ? (
              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
            ) : (
              <Save className="mr-2 h-4 w-4" />
            )}
            Guardar cambios
          </Button>
        </div>
      </div>
    </AppLayout>
  );
}
