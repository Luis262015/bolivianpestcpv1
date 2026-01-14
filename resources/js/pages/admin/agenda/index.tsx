'use client';

import AppLayout from '@/layouts/app-layout';
import { type BreadcrumbItem } from '@/types';
import { Head, router, usePage } from '@inertiajs/react';

import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { cn } from '@/lib/utils';
import {
  addMonths,
  addYears,
  eachDayOfInterval,
  endOfMonth,
  format,
  isSameDay,
  setMonth,
  startOfMonth,
  subMonths,
  subYears,
} from 'date-fns';
import {
  CheckCircle2,
  ChevronLeft,
  ChevronRight,
  Clock,
  GripVertical,
  Plus,
  Trash2,
  XCircle,
} from 'lucide-react';
import { useEffect, useRef, useState } from 'react';

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Cronogramas', href: '/cronogramas' },
];

type ViewMode = 'month' | 'year';
type TaskStatus = 'pendiente' | 'postergado' | 'completado';

interface Task {
  id: number;
  user_id: number;
  title: string;
  date: string;
  hour: string;
  color: string;
  status: TaskStatus;
}

const COLORS = [
  'bg-red-500',
  'bg-blue-500',
  'bg-green-500',
  'bg-yellow-500',
  'bg-purple-500',
  'bg-pink-600',
  'bg-teal-500',
];

const STATUS_CONFIG: Record<
  TaskStatus,
  { label: string; icon: React.ReactNode; color: string }
> = {
  pendiente: {
    label: 'Pendiente',
    icon: <Clock className="h-3 w-3" />,
    color: 'text-orange-600',
  },
  postergado: {
    label: 'Postergado',
    icon: <XCircle className="h-3 w-3" />,
    color: 'text-red-600',
  },
  completado: {
    label: 'Completado',
    icon: <CheckCircle2 className="h-3 w-3" />,
    color: 'text-green-600',
  },
};

export default function Lista() {
  const { props } = usePage<any>();
  const { tareas: initialTasks } = props;

  const [currentDate, setCurrentDate] = useState(new Date());
  const [viewMode, setViewMode] = useState<ViewMode>('month');
  const [tasks, setTasks] = useState<Task[]>(initialTasks || []);
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [editingTask, setEditingTask] = useState<Task | null>(null);
  const [selectedDate, setSelectedDate] = useState<Date | null>(null);
  const [selectedHour, setSelectedHour] = useState('');
  const [taskTitle, setTaskTitle] = useState('');
  const [taskColor, setTaskColor] = useState(COLORS[0]);
  const [taskStatus, setTaskStatus] = useState<TaskStatus>('pendiente');
  const dragOverRef = useRef<string | null>(null);
  const [draggedTask, setDraggedTask] = useState<Task | null>(null);

  // 2. Actualizar tareas cuando llegan nuevas del servidor
  useEffect(() => {
    setTasks(initialTasks || []);
  }, [initialTasks]);

  const getTasksForDate = (dateStr: string) =>
    tasks.filter((t) => t.date === dateStr);

  const goToPrevious = () => {
    setCurrentDate(
      viewMode === 'month'
        ? subMonths(currentDate, 1)
        : subYears(currentDate, 1),
    );
  };

  const goToNext = () => {
    setCurrentDate(
      viewMode === 'month'
        ? addMonths(currentDate, 1)
        : addYears(currentDate, 1),
    );
  };

  const goToToday = () => setCurrentDate(new Date());

  const handleYearChange = (value: string) => {
    setCurrentDate(new Date(parseInt(value), currentDate.getMonth()));
  };

  const handleMonthChange = (value: string) => {
    setCurrentDate(new Date(currentDate.getFullYear(), parseInt(value)));
  };

  const goToMonth = (monthIndex: number) => {
    setCurrentDate(setMonth(currentDate, monthIndex));
    setViewMode('month');
  };

  const openTaskDialog = (date?: Date, task?: Task) => {
    console.log(task);
    if (task) {
      setEditingTask(task);
      setTaskTitle(task.title);
      setTaskColor(task.color);
      setTaskStatus(task.status);
      setSelectedDate(new Date(task.date + 'T00:00:00'));
      setSelectedHour(task.hour);
    } else {
      setEditingTask(null);
      setTaskTitle('');
      setTaskColor(COLORS[0]);
      setTaskStatus('pendiente');
      setSelectedDate(date || null);
      setSelectedHour('');
    }
    setIsDialogOpen(true);
  };

  const saveTask = () => {
    if (!selectedDate || !taskTitle.trim()) return;

    const dateStr = format(selectedDate, 'yyyy-MM-dd');
    // const dateHour = format(selectedHour, 'HH:mm:ss');

    const data = {
      title: taskTitle.trim(),
      date: dateStr,
      hour: selectedHour,
      color: taskColor,
      status: taskStatus,
    };

    if (editingTask) {
      router.patch(`/agendas/${editingTask.id}`, data, {
        onSuccess: () => setIsDialogOpen(false),
      });
    } else {
      router.post('/agendas', data, {
        onSuccess: () => setIsDialogOpen(false),
      });
    }
  };

  const deleteTask = (id: number) => {
    if (confirm('¿Seguro que quieres eliminar esta tarea?')) {
      router.delete(`/agendas/${id}`);
    }
  };

  const handleDragStart = (e: React.DragEvent, task: Task) => {
    setDraggedTask(task);
    e.dataTransfer.effectAllowed = 'move';
  };

  const handleDragOver = (e: React.DragEvent, dateStr: string) => {
    e.preventDefault();
    dragOverRef.current = dateStr;
  };

  const handleDrop = (e: React.DragEvent, dateStr: string) => {
    e.preventDefault();
    if (!draggedTask) return;

    router.patch(
      `/agendas/${draggedTask.id}`,
      { date: dateStr },
      { preserveState: true },
    );

    setDraggedTask(null);
    dragOverRef.current = null;
  };

  const MonthlyView = () => {
    const monthStart = startOfMonth(currentDate);
    const monthEnd = endOfMonth(currentDate);
    const days = eachDayOfInterval({ start: monthStart, end: monthEnd });
    const startDayOfWeek = monthStart.getDay();

    return (
      <div className="grid grid-cols-7 gap-1">
        {['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'].map((day) => (
          <div
            key={day}
            className="py-2 text-center text-sm font-medium text-muted-foreground"
          >
            {day}
          </div>
        ))}

        {Array.from({ length: startDayOfWeek }).map((_, i) => (
          <div
            key={`empty-${i}`}
            className="h-24 rounded-md border bg-muted/20"
          />
        ))}

        {days.map((day) => {
          const dateStr = format(day, 'yyyy-MM-dd');
          const dayTasks = getTasksForDate(dateStr);
          const isToday = isSameDay(day, new Date());

          return (
            <div
              key={dateStr}
              onDragOver={(e) => handleDragOver(e, dateStr)}
              onDrop={(e) => handleDrop(e, dateStr)}
              className={cn(
                'flex min-h-24 flex-col gap-1 rounded-md border p-1 transition-colors',
                isToday && 'ring-2 ring-primary',
                dragOverRef.current === dateStr && 'bg-muted',
                // puedeCrearTarea
                //   ? 'cursor-pointer hover:bg-accent/50'
                //   : 'cursor-not-allowed opacity-60',
              )}
              onClick={() => {
                openTaskDialog(day);
              }}
            >
              <div
                className={cn('text-sm font-medium', isToday && 'text-primary')}
              >
                {format(day, 'd')}
              </div>

              <div className="flex-1 space-y-1 overflow-y-auto">
                {dayTasks.map((task) => {
                  return (
                    <div
                      key={task.id}
                      draggable
                      onDragStart={(e) => handleDragStart(e, task)}
                      onClick={(e) => {
                        e.stopPropagation();
                        openTaskDialog(undefined, task);
                      }}
                      className={cn(
                        'group flex cursor-move items-center gap-1.5 rounded p-1.5 text-xs text-white shadow-sm',
                        task.color,
                      )}
                    >
                      <GripVertical className="h-3.5 w-3.5 opacity-70" />
                      <span className="flex-1 truncate font-medium">
                        {task.title}
                      </span>
                      <div
                        className={cn(
                          'text-xs',
                          STATUS_CONFIG[task.status].color,
                        )}
                      >
                        {STATUS_CONFIG[task.status].icon}
                      </div>
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          deleteTask(task.id);
                        }}
                        className="opacity-0 transition-opacity group-hover:opacity-100"
                      >
                        <Trash2 className="h-3.5 w-3.5" />
                      </button>
                    </div>
                  );
                })}
              </div>

              {dayTasks.length === 0 && (
                <Button
                  size="sm"
                  variant="ghost"
                  className="mt-auto h-6 text-xs"
                  onClick={(e) => {
                    e.stopPropagation();
                    openTaskDialog(day);
                  }}
                >
                  <Plus className="mr-1 h-3 w-3" /> Agregar
                </Button>
              )}
            </div>
          );
        })}
      </div>
    );
  };

  const YearlyView = () => {
    const year = currentDate.getFullYear();

    return (
      <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
        {Array.from({ length: 12 }, (_, i) => {
          const monthDate = new Date(year, i, 1);
          const monthStart = startOfMonth(monthDate);
          const monthEnd = endOfMonth(monthDate);
          const days = eachDayOfInterval({ start: monthStart, end: monthEnd });
          const startDayOfWeek = monthStart.getDay();

          return (
            <Card
              key={i}
              className="cursor-pointer overflow-hidden transition-shadow hover:shadow-lg"
              onClick={() => goToMonth(i)}
            >
              <CardHeader className="bg-primary/5 px-3 pt-3 pb-2">
                <CardTitle className="text-center text-sm">
                  {format(monthDate, 'MMMM')}
                </CardTitle>
              </CardHeader>
              <CardContent className="p-0">
                <div className="grid grid-cols-7 gap-0 text-xs">
                  {['D', 'L', 'M', 'M', 'J', 'V', 'S'].map((d) => (
                    <div
                      key={d}
                      className="p-1 text-center font-medium text-muted-foreground"
                    >
                      {d}
                    </div>
                  ))}

                  {Array.from({ length: startDayOfWeek }).map((_, idx) => (
                    <div key={`empty-${idx}`} />
                  ))}

                  {days.map((day) => {
                    const dateStr = format(day, 'yyyy-MM-dd');
                    const dayTasks = getTasksForDate(dateStr);
                    const isToday = isSameDay(day, new Date());

                    return (
                      <div
                        key={dateStr}
                        onDragOver={(e) => handleDragOver(e, dateStr)}
                        onDrop={(e) => handleDrop(e, dateStr)}
                        className={cn(
                          'min-h-6 border-t border-l p-1 text-center last:border-r',
                          isToday && 'bg-primary font-bold text-white',
                          dragOverRef.current === dateStr && 'bg-muted',
                        )}
                      >
                        <div className="font-medium">{format(day, 'd')}</div>
                        {dayTasks.length > 0 && (
                          <div className="mt-0.5 flex flex-wrap justify-center gap-0.5">
                            {dayTasks.slice(0, 3).map((task) => (
                              <div
                                key={task.id}
                                className={cn(
                                  'h-1.5 w-1.5 rounded-full',
                                  task.color,
                                )}
                                title={`${task.title} - ${task.status}`}
                              />
                            ))}
                            {dayTasks.length > 3 && (
                              <Badge
                                variant="secondary"
                                className="h-3 px-1 text-[10px]"
                              >
                                +{dayTasks.length - 3}
                              </Badge>
                            )}
                          </div>
                        )}
                      </div>
                    );
                  })}
                </div>
              </CardContent>
            </Card>
          );
        })}
      </div>
    );
  };

  return (
    <AppLayout breadcrumbs={breadcrumbs}>
      <Head title="Cronogramas" />

      <div className="space-y-6 p-6">
        <h1 className="text-2xl font-bold">Gestión de Agenda personal</h1>

        <div className="flex flex-wrap items-end gap-6"></div>

        <Card>
          <CardContent className="p-6">
            {/* Controles de navegación y vista (mes/año) */}
            <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
              <div className="flex items-center gap-2">
                <Button variant="outline" size="icon" onClick={goToPrevious}>
                  <ChevronLeft className="h-4 w-4" />
                </Button>

                <div className="flex items-center gap-2">
                  {viewMode === 'month' ? (
                    <>
                      <Select
                        value={currentDate.getMonth().toString()}
                        onValueChange={handleMonthChange}
                      >
                        <SelectTrigger className="w-36">
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          {Array.from({ length: 12 }, (_, i) => (
                            <SelectItem key={i} value={i.toString()}>
                              {format(new Date(2026, i), 'MMMM')}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>

                      <Select
                        value={currentDate.getFullYear().toString()}
                        onValueChange={handleYearChange}
                      >
                        <SelectTrigger className="w-24">
                          <SelectValue />
                        </SelectTrigger>
                        <SelectContent>
                          {Array.from({ length: 11 }, (_, i) => {
                            const y = currentDate.getFullYear() - 5 + i;
                            return (
                              <SelectItem key={y} value={y.toString()}>
                                {y}
                              </SelectItem>
                            );
                          })}
                        </SelectContent>
                      </Select>
                    </>
                  ) : (
                    <h2 className="px-4 text-xl font-semibold">
                      {currentDate.getFullYear()}
                    </h2>
                  )}
                </div>

                <Button variant="outline" size="icon" onClick={goToNext}>
                  <ChevronRight className="h-4 w-4" />
                </Button>
              </div>

              <div className="flex items-center gap-2">
                <Button variant="outline" size="sm" onClick={goToToday}>
                  Hoy
                </Button>

                <Tabs
                  value={viewMode}
                  onValueChange={(v) => setViewMode(v as ViewMode)}
                >
                  <TabsList>
                    <TabsTrigger value="month">Mensual</TabsTrigger>
                    <TabsTrigger value="year">Anual</TabsTrigger>
                  </TabsList>
                </Tabs>
              </div>
            </div>

            <div className="mt-6">
              {viewMode === 'month' ? <MonthlyView /> : <YearlyView />}
            </div>
          </CardContent>
        </Card>
      </div>

      <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>
              {editingTask ? 'Editar tarea' : 'Nueva tarea'} -{' '}
              {selectedDate && format(selectedDate, 'dd MMMM yyyy')}
            </DialogTitle>
          </DialogHeader>
          <div className="space-y-4">
            <div>
              <Label htmlFor="title">Hora</Label>
              <Input
                type="time"
                id="hour"
                value={selectedHour}
                onChange={(e) => setSelectedHour(e.target.value)}
                autoFocus
              />
            </div>

            <div>
              <Label htmlFor="title">Título</Label>
              <Input
                id="title"
                value={taskTitle}
                onChange={(e) => setTaskTitle(e.target.value)}
                placeholder="Reunión con equipo"
                autoFocus
              />
            </div>

            <div>
              <Label>Estado</Label>
              <div className="mt-2 grid grid-cols-3 gap-2">
                {(
                  ['pendiente', 'postergado', 'completado'] as TaskStatus[]
                ).map((status) => (
                  <Button
                    key={status}
                    variant={taskStatus === status ? 'default' : 'outline'}
                    size="sm"
                    onClick={() => setTaskStatus(status)}
                    className="flex items-center gap-1"
                  >
                    {STATUS_CONFIG[status].icon}
                    {STATUS_CONFIG[status].label}
                  </Button>
                ))}
              </div>
            </div>

            <div>
              <Label>Color</Label>
              <div className="mt-2 flex gap-2">
                {COLORS.map((color) => (
                  <button
                    key={color}
                    onClick={() => setTaskColor(color)}
                    className={cn(
                      'h-8 w-8 rounded-full transition-transform',
                      color,
                      taskColor === color &&
                        'scale-110 ring-2 ring-foreground ring-offset-2',
                    )}
                  />
                ))}
              </div>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setIsDialogOpen(false)}>
              Cancelar
            </Button>
            <Button onClick={saveTask}>
              {editingTask ? 'Actualizar' : 'Guardar'}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </AppLayout>
  );
}
