// 'use client';

// import { Badge } from '@/components/ui/badge';
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import {
//     Dialog,
//     DialogContent,
//     DialogFooter,
//     DialogHeader,
//     DialogTitle,
// } from '@/components/ui/dialog';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import { ScrollArea } from '@/components/ui/scroll-area';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// // import { toast } from '@/components/ui/sonner'; // ← CORRECTO: desde shadcn
// import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
// import { cn } from '@/lib/utils';
// import { Head, usePage } from '@inertiajs/react';
// import {
//     addMonths,
//     addYears,
//     eachDayOfInterval,
//     endOfMonth,
//     format,
//     isSameDay,
//     setMonth,
//     startOfMonth,
//     subMonths,
//     subYears,
// } from 'date-fns';
// import {
//     CheckCircle2,
//     ChevronLeft,
//     ChevronRight,
//     Clock,
//     GripVertical,
//     Plus,
//     Trash2,
//     XCircle,
// } from 'lucide-react';
// import { useEffect, useRef, useState } from 'react';

// type ViewMode = 'month' | 'year';
// type TaskStatus = 'pendiente' | 'postergado' | 'completado';

// interface Task {
//     id: string;
//     title: string;
//     date: string;
//     color: string;
//     status: TaskStatus;
// }

// const COLORS = [
//     'bg-red-500',
//     'bg-blue-500',
//     'bg-green-500',
//     'bg-yellow-500',
//     'bg-purple-500',
// ];

// const STATUS_CONFIG: Record<
//     TaskStatus,
//     { label: string; icon: React.ReactNode; color: string }
// > = {
//     pendiente: {
//         label: 'Pendiente',
//         icon: <Clock className="h-3 w-3" />,
//         color: 'text-orange-600',
//     },
//     postergado: {
//         label: 'Postergado',
//         icon: <XCircle className="h-3 w-3" />,
//         color: 'text-red-600',
//     },
//     completado: {
//         label: 'Completado',
//         icon: <CheckCircle2 className="h-3 w-3" />,
//         color: 'text-green-600',
//     },
// };

// export default function Calendar() {
//     const { props } = usePage<{ initialTasks: Task[] }>();

//     const [currentDate, setCurrentDate] = useState(new Date());
//     const [viewMode, setViewMode] = useState<ViewMode>('month');
//     const [tasks, setTasks] = useState<Task[]>(props.initialTasks || []);
//     const [isDialogOpen, setIsDialogOpen] = useState(false);
//     const [editingTask, setEditingTask] = useState<Task | null>(null);
//     const [selectedDate, setSelectedDate] = useState<Date | null>(null);
//     const [taskTitle, setTaskTitle] = useState('');
//     const [taskColor, setTaskColor] = useState(COLORS[0]);
//     const [taskStatus, setTaskStatus] = useState<TaskStatus>('pendiente');
//     const [draggedTask, setDraggedTask] = useState<Task | null>(null);

//     const dragOverRef = useRef<string | null>(null);

//     const year = currentDate.getFullYear();
//     const month = currentDate.getMonth();

//     // Sincronizar tareas iniciales
//     useEffect(() => {
//         setTasks(props.initialTasks || []);
//     }, [props.initialTasks]);

//     // Notificaciones en tiempo real
//     useEffect(() => {
//         const userId = (window as any).Laravel?.userId;
//         if (!userId || !window.Echo) return;

//         const channel = window.Echo.private(`user.${userId}`);
//         channel.listen('.TaskUpdated', (e: any) => {
//             setTasks((prev) => {
//                 const exists = prev.some((t) => t.id === e.task.id);
//                 if (exists) {
//                     return prev.map((t) => (t.id === e.task.id ? e.task : t));
//                 }
//                 return [...prev, e.task];
//             });

//             // toast.success(e.message, {
//             //     description: `${STATUS_CONFIG[e.task.status].icon} ${STATUS_CONFIG[e.task.status].label}`,
//             // });
//         });

//         return () => {
//             channel.stopListening('.TaskUpdated');
//         };
//     }, []);

//     // Navegación
//     const goToPrevious = () => {
//         setCurrentDate(
//             viewMode === 'month'
//                 ? subMonths(currentDate, 1)
//                 : subYears(currentDate, 1),
//         );
//     };

//     const goToNext = () => {
//         setCurrentDate(
//             viewMode === 'month'
//                 ? addMonths(currentDate, 1)
//                 : addYears(currentDate, 1),
//         );
//     };

//     const goToToday = () => setCurrentDate(new Date());

//     const handleYearChange = (value: string) => {
//         setCurrentDate(new Date(parseInt(value), month));
//     };

//     const handleMonthChange = (value: string) => {
//         setCurrentDate(new Date(year, parseInt(value)));
//     };

//     const goToMonth = (monthIndex: number) => {
//         setCurrentDate(setMonth(currentDate, monthIndex));
//         setViewMode('month');
//     };

//     // Diálogo
//     const openTaskDialog = (date?: Date, task?: Task) => {
//         if (task) {
//             setEditingTask(task);
//             setTaskTitle(task.title);
//             setTaskColor(task.color);
//             setTaskStatus(task.status);
//             setSelectedDate(new Date(task.date));
//         } else {
//             setEditingTask(null);
//             setTaskTitle('');
//             setTaskColor(COLORS[0]);
//             setTaskStatus('pendiente');
//             setSelectedDate(date || null);
//         }
//         setIsDialogOpen(true);
//     };

//     const saveTask = () => {
//         if (!selectedDate || !taskTitle.trim()) {
//             // toast.error('El título es obligatorio');
//             return;
//         }

//         const data = {
//             title: taskTitle.trim(),
//             date: format(selectedDate, 'yyyy-MM-dd'),
//             color: taskColor,
//             status: taskStatus,
//         };

//         if (editingTask) {
//             // router.put(route('tasks.update', editingTask.id), data, {
//             //     preserveState: true,
//             //     onSuccess: () => {
//             //         setIsDialogOpen(false);
//             //         toast.success('Tarea actualizada');
//             //     },
//             //     onError: () => toast.error('Error al actualizar'),
//             // });
//         } else {
//             // router.post(route('tasks.store'), data, {
//             //     preserveState: true,
//             //     onSuccess: () => {
//             //         setIsDialogOpen(false);
//             //         toast.success('Tarea creada');
//             //     },
//             //     onError: () => toast.error('Error al crear'),
//             // });
//         }
//     };

//     const deleteTask = (id: string) => {
//         if (!confirm('¿Eliminar esta tarea?')) return;

//         // router.delete(route('tasks.destroy', id), {
//         //     onSuccess: () => toast.success('Tarea eliminada'),
//         //     onError: () => toast.error('Error al eliminar'),
//         // });
//     };

//     // Drag & Drop
//     const handleDragStart = (e: React.DragEvent, task: Task) => {
//         setDraggedTask(task);
//         e.dataTransfer.effectAllowed = 'move';
//     };

//     const handleDragOver = (e: React.DragEvent, dateStr: string) => {
//         e.preventDefault();
//         dragOverRef.current = dateStr;
//     };

//     const handleDrop = (e: React.DragEvent, dateStr: string) => {
//         e.preventDefault();
//         if (!draggedTask) return;

//         // router.put(
//         //     route('tasks.update', draggedTask.id),
//         //     { date: dateStr },
//         //     {
//         //         preserveState: true,
//         //         onSuccess: () => toast.success('Fecha actualizada'),
//         //     },
//         // );

//         setDraggedTask(null);
//         dragOverRef.current = null;
//     };

//     const getTasksForDate = (dateStr: string) =>
//         tasks.filter((t) => t.date === dateStr);

//     // === VISTAS (sin cambios) ===
//     const MonthlyView = () => {
//         const monthStart = startOfMonth(currentDate);
//         const monthEnd = endOfMonth(currentDate);
//         const days = eachDayOfInterval({ start: monthStart, end: monthEnd });
//         const startDayOfWeek = monthStart.getDay();

//         return (
//             <div className="grid grid-cols-7 gap-1">
//                 {['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'].map(
//                     (day) => (
//                         <div
//                             key={day}
//                             className="py-2 text-center text-sm font-medium text-muted-foreground"
//                         >
//                             {day}
//                         </div>
//                     ),
//                 )}

//                 {Array.from({ length: startDayOfWeek }, (_, i) => (
//                     <div
//                         key={`empty-${i}`}
//                         className="h-24 rounded-md border bg-muted/20"
//                     />
//                 ))}

//                 {days.map((day) => {
//                     const dateStr = format(day, 'yyyy-MM-dd');
//                     const dayTasks = getTasksForDate(dateStr);
//                     const isToday = isSameDay(day, new Date());

//                     return (
//                         <div
//                             key={dateStr}
//                             onDragOver={(e) => handleDragOver(e, dateStr)}
//                             onDrop={(e) => handleDrop(e, dateStr)}
//                             className={cn(
//                                 'flex min-h-24 cursor-pointer flex-col gap-1 rounded-md border p-1 transition-colors',
//                                 isToday && 'ring-2 ring-primary',
//                                 dragOverRef.current === dateStr && 'bg-muted',
//                             )}
//                             onClick={() => openTaskDialog(day)}
//                         >
//                             <div
//                                 className={cn(
//                                     'text-sm font-medium',
//                                     isToday && 'text-primary',
//                                 )}
//                             >
//                                 {format(day, 'd')}
//                             </div>

//                             <div className="flex-1 space-y-1 overflow-y-auto">
//                                 {dayTasks.map((task) => (
//                                     <div
//                                         key={task.id}
//                                         draggable
//                                         onDragStart={(e) =>
//                                             handleDragStart(e, task)
//                                         }
//                                         onClick={(e) => {
//                                             e.stopPropagation();
//                                             openTaskDialog(undefined, task);
//                                         }}
//                                         className={cn(
//                                             'group flex cursor-move items-center gap-1 rounded p-1 text-xs text-white',
//                                             task.color,
//                                         )}
//                                     >
//                                         <GripVertical className="h-3 w-3 opacity-70" />
//                                         <span className="flex-1 truncate">
//                                             {task.title}
//                                         </span>
//                                         <div
//                                             className={cn(
//                                                 'text-xs',
//                                                 STATUS_CONFIG[task.status]
//                                                     .color,
//                                             )}
//                                         >
//                                             {STATUS_CONFIG[task.status].icon}
//                                         </div>
//                                         <button
//                                             onClick={(e) => {
//                                                 e.stopPropagation();
//                                                 deleteTask(task.id);
//                                             }}
//                                             className="opacity-0 transition-opacity group-hover:opacity-100"
//                                         >
//                                             <Trash2 className="h-3 w-3" />
//                                         </button>
//                                     </div>
//                                 ))}
//                             </div>

//                             {dayTasks.length === 0 && (
//                                 <Button
//                                     size="sm"
//                                     variant="ghost"
//                                     className="mt-auto h-6 text-xs"
//                                     onClick={(e) => {
//                                         e.stopPropagation();
//                                         openTaskDialog(day);
//                                     }}
//                                 >
//                                     <Plus className="mr-1 h-3 w-3" /> Agregar
//                                 </Button>
//                             )}
//                         </div>
//                     );
//                 })}
//             </div>
//         );
//     };

//     const YearlyView = () => {
//         return (
//             <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
//                 {Array.from({ length: 12 }, (_, i) => {
//                     const monthDate = new Date(year, i, 1);
//                     const monthStart = startOfMonth(monthDate);
//                     const monthEnd = endOfMonth(monthDate);
//                     const days = eachDayOfInterval({
//                         start: monthStart,
//                         end: monthEnd,
//                     });
//                     const startDayOfWeek = monthStart.getDay();

//                     return (
//                         <Card
//                             key={i}
//                             className="cursor-pointer overflow-hidden transition-shadow hover:shadow-lg"
//                             onClick={() => goToMonth(i)}
//                         >
//                             <CardHeader className="bg-primary/5 px-3 pt-3 pb-2">
//                                 <CardTitle className="text-center text-sm">
//                                     {format(monthDate, 'MMMM')}
//                                 </CardTitle>
//                             </CardHeader>
//                             <CardContent className="p-0">
//                                 <div className="grid grid-cols-7 gap-0 text-xs">
//                                     {['D', 'L', 'M', 'M', 'J', 'V', 'S'].map(
//                                         (d) => (
//                                             <div
//                                                 key={d}
//                                                 className="p-1 text-center font-medium text-muted-foreground"
//                                             >
//                                                 {d}
//                                             </div>
//                                         ),
//                                     )}
//                                     {Array.from({ length: startDayOfWeek }).map(
//                                         (_, idx) => (
//                                             <div key={`empty-${idx}`} />
//                                         ),
//                                     )}
//                                     {days.map((day) => {
//                                         const dateStr = format(
//                                             day,
//                                             'yyyy-MM-dd',
//                                         );
//                                         const dayTasks =
//                                             getTasksForDate(dateStr);
//                                         const isToday = isSameDay(
//                                             day,
//                                             new Date(),
//                                         );

//                                         return (
//                                             <div
//                                                 key={dateStr}
//                                                 onDragOver={(e) =>
//                                                     handleDragOver(e, dateStr)
//                                                 }
//                                                 onDrop={(e) =>
//                                                     handleDrop(e, dateStr)
//                                                 }
//                                                 className={cn(
//                                                     'min-h-6 border-t border-l p-1 text-center last:border-r',
//                                                     isToday &&
//                                                         'bg-primary font-bold text-white',
//                                                     dragOverRef.current ===
//                                                         dateStr && 'bg-muted',
//                                                 )}
//                                             >
//                                                 <div className="font-medium">
//                                                     {format(day, 'd')}
//                                                 </div>
//                                                 {dayTasks.length > 0 && (
//                                                     <div className="mt-0.5 flex justify-center gap-0.5">
//                                                         {dayTasks
//                                                             .slice(0, 3)
//                                                             .map((task) => (
//                                                                 <div
//                                                                     key={
//                                                                         task.id
//                                                                     }
//                                                                     className={cn(
//                                                                         'h-1.5 w-1.5 rounded-full',
//                                                                         task.color,
//                                                                     )}
//                                                                     title={`${task.title} [${task.status}]`}
//                                                                 />
//                                                             ))}
//                                                         {dayTasks.length >
//                                                             3 && (
//                                                             <Badge
//                                                                 variant="secondary"
//                                                                 className="h-3 px-1 text-[10px]"
//                                                             >
//                                                                 +
//                                                                 {dayTasks.length -
//                                                                     3}
//                                                             </Badge>
//                                                         )}
//                                                     </div>
//                                                 )}
//                                             </div>
//                                         );
//                                     })}
//                                 </div>
//                             </CardContent>
//                         </Card>
//                     );
//                 })}
//             </div>
//         );
//     };

//     const TaskList = () => {
//         const sortedTasks = [...tasks].sort((a, b) =>
//             a.date.localeCompare(b.date),
//         );

//         return (
//             <Card className="h-full">
//                 <CardHeader>
//                     <CardTitle className="flex items-center justify-between text-lg">
//                         Tareas ({tasks.length})
//                         <Button
//                             size="sm"
//                             onClick={() => openTaskDialog(new Date())}
//                         >
//                             <Plus className="mr-1 h-4 w-4" /> Nueva
//                         </Button>
//                     </CardTitle>
//                 </CardHeader>
//                 <CardContent className="p-0">
//                     <ScrollArea className="h-[calc(100vh-16rem)] px-4">
//                         {sortedTasks.length === 0 ? (
//                             <p className="py-8 text-center text-muted-foreground">
//                                 No hay tareas
//                             </p>
//                         ) : (
//                             <div className="space-y-3 pb-4">
//                                 {sortedTasks.map((task) => (
//                                     <div
//                                         key={task.id}
//                                         className="flex cursor-pointer items-start gap-3 rounded-lg border bg-card p-3 transition-colors hover:bg-muted/50"
//                                         onClick={() =>
//                                             openTaskDialog(undefined, task)
//                                         }
//                                     >
//                                         <div
//                                             className={cn(
//                                                 'mt-1 h-3 w-3 flex-shrink-0 rounded-full',
//                                                 task.color,
//                                             )}
//                                         />
//                                         <div className="min-w-0 flex-1">
//                                             <p className="truncate text-sm font-medium">
//                                                 {task.title}
//                                             </p>
//                                             <div className="mt-1 flex items-center gap-2 text-xs text-muted-foreground">
//                                                 <span>
//                                                     {format(
//                                                         new Date(task.date),
//                                                         'dd MMM yyyy',
//                                                     )}
//                                                 </span>
//                                                 <span className="mx-1">•</span>
//                                                 <span
//                                                     className={
//                                                         STATUS_CONFIG[
//                                                             task.status
//                                                         ].color
//                                                     }
//                                                 >
//                                                     {
//                                                         STATUS_CONFIG[
//                                                             task.status
//                                                         ].icon
//                                                     }{' '}
//                                                     {
//                                                         STATUS_CONFIG[
//                                                             task.status
//                                                         ].label
//                                                     }
//                                                 </span>
//                                             </div>
//                                         </div>
//                                         <Button
//                                             size="sm"
//                                             variant="ghost"
//                                             onClick={(e) => {
//                                                 e.stopPropagation();
//                                                 deleteTask(task.id);
//                                             }}
//                                         >
//                                             <Trash2 className="h-4 w-4" />
//                                         </Button>
//                                     </div>
//                                 ))}
//                             </div>
//                         )}
//                     </ScrollArea>
//                 </CardContent>
//             </Card>
//         );
//     };

//     return (
//         <>
//             <Head title="Calendario" />

//             <div className="min-h-screen bg-background">
//                 <div className="mx-auto grid max-w-7xl grid-cols-1 gap-6 px-4 py-8 sm:px-6 lg:grid-cols-4 lg:px-8">
//                     <div className="lg:col-span-3">
//                         <Card>
//                             <CardContent className="p-6">
//                                 <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
//                                     <div className="flex items-center gap-2">
//                                         <Button
//                                             variant="outline"
//                                             size="icon"
//                                             onClick={goToPrevious}
//                                         >
//                                             <ChevronLeft className="h-4 w-4" />
//                                         </Button>

//                                         <div className="flex items-center gap-2">
//                                             {viewMode === 'month' ? (
//                                                 <>
//                                                     <Select
//                                                         value={month.toString()}
//                                                         onValueChange={
//                                                             handleMonthChange
//                                                         }
//                                                     >
//                                                         <SelectTrigger className="w-36">
//                                                             <SelectValue />
//                                                         </SelectTrigger>
//                                                         <SelectContent>
//                                                             {Array.from(
//                                                                 { length: 12 },
//                                                                 (_, i) => (
//                                                                     <SelectItem
//                                                                         key={i}
//                                                                         value={i.toString()}
//                                                                     >
//                                                                         {format(
//                                                                             new Date(
//                                                                                 year,
//                                                                                 i,
//                                                                             ),
//                                                                             'MMMM',
//                                                                         )}
//                                                                     </SelectItem>
//                                                                 ),
//                                                             )}
//                                                         </SelectContent>
//                                                     </Select>

//                                                     <Select
//                                                         value={year.toString()}
//                                                         onValueChange={
//                                                             handleYearChange
//                                                         }
//                                                     >
//                                                         <SelectTrigger className="w-24">
//                                                             <SelectValue />
//                                                         </SelectTrigger>
//                                                         <SelectContent>
//                                                             {Array.from(
//                                                                 { length: 11 },
//                                                                 (_, i) => {
//                                                                     const y =
//                                                                         year -
//                                                                         5 +
//                                                                         i;
//                                                                     return (
//                                                                         <SelectItem
//                                                                             key={
//                                                                                 y
//                                                                             }
//                                                                             value={y.toString()}
//                                                                         >
//                                                                             {y}
//                                                                         </SelectItem>
//                                                                     );
//                                                                 },
//                                                             )}
//                                                         </SelectContent>
//                                                     </Select>
//                                                 </>
//                                             ) : (
//                                                 <h2 className="px-4 text-xl font-semibold">
//                                                     {year}
//                                                 </h2>
//                                             )}
//                                         </div>

//                                         <Button
//                                             variant="outline"
//                                             size="icon"
//                                             onClick={goToNext}
//                                         >
//                                             <ChevronRight className="h-4 w-4" />
//                                         </Button>
//                                     </div>

//                                     <div className="flex items-center gap-2">
//                                         <Button
//                                             variant="outline"
//                                             size="sm"
//                                             onClick={goToToday}
//                                         >
//                                             Hoy
//                                         </Button>

//                                         <Tabs
//                                             value={viewMode}
//                                             onValueChange={(v) =>
//                                                 setViewMode(v as ViewMode)
//                                             }
//                                         >
//                                             <TabsList>
//                                                 <TabsTrigger value="month">
//                                                     Mensual
//                                                 </TabsTrigger>
//                                                 <TabsTrigger value="year">
//                                                     Anual
//                                                 </TabsTrigger>
//                                             </TabsList>
//                                         </Tabs>
//                                     </div>
//                                 </div>

//                                 <div className="mt-6">
//                                     {viewMode === 'month' ? (
//                                         <MonthlyView />
//                                     ) : (
//                                         <YearlyView />
//                                     )}
//                                 </div>
//                             </CardContent>
//                         </Card>
//                     </div>

//                     <div className="hidden lg:col-span-1 lg:block">
//                         <TaskList />
//                     </div>
//                 </div>
//             </div>

//             <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
//                 <DialogContent className="sm:max-w-md">
//                     <DialogHeader>
//                         <DialogTitle>
//                             {editingTask ? 'Editar tarea' : 'Nueva tarea'} -{' '}
//                             {selectedDate &&
//                                 format(selectedDate, 'dd MMMM yyyy')}
//                         </DialogTitle>
//                     </DialogHeader>
//                     <div className="space-y-4">
//                         <div>
//                             <Label htmlFor="title">Título</Label>
//                             <Input
//                                 id="title"
//                                 value={taskTitle}
//                                 onChange={(e) => setTaskTitle(e.target.value)}
//                                 placeholder="Reunión con equipo"
//                                 autoFocus
//                             />
//                         </div>

//                         <div>
//                             <Label>Estado</Label>
//                             <div className="mt-2 grid grid-cols-3 gap-2">
//                                 {(
//                                     [
//                                         'pendiente',
//                                         'postergado',
//                                         'completado',
//                                     ] as TaskStatus[]
//                                 ).map((status) => (
//                                     <Button
//                                         key={status}
//                                         variant={
//                                             taskStatus === status
//                                                 ? 'default'
//                                                 : 'outline'
//                                         }
//                                         size="sm"
//                                         onClick={() => setTaskStatus(status)}
//                                         className="flex items-center gap-1"
//                                     >
//                                         {STATUS_CONFIG[status].icon}
//                                         {STATUS_CONFIG[status].label}
//                                     </Button>
//                                 ))}
//                             </div>
//                         </div>

//                         <div>
//                             <Label>Color</Label>
//                             <div className="mt-2 flex gap-2">
//                                 {COLORS.map((color) => (
//                                     <button
//                                         key={color}
//                                         onClick={() => setTaskColor(color)}
//                                         className={cn(
//                                             'h-8 w-8 rounded-full transition-transform',
//                                             color,
//                                             taskColor === color &&
//                                                 'scale-110 ring-2 ring-foreground ring-offset-2',
//                                         )}
//                                     />
//                                 ))}
//                             </div>
//                         </div>
//                     </div>
//                     <DialogFooter>
//                         <Button
//                             variant="outline"
//                             onClick={() => setIsDialogOpen(false)}
//                         >
//                             Cancelar
//                         </Button>
//                         <Button onClick={saveTask}>
//                             {editingTask ? 'Actualizar' : 'Guardar'}
//                         </Button>
//                     </DialogFooter>
//                 </DialogContent>
//             </Dialog>
//         </>
//     );
// }

// ---------------------------------------------------------------------------------------------
'use client';

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
import { ScrollArea } from '@/components/ui/scroll-area';
import {
    Select,
    SelectContent,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from '@/components/ui/select';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { cn } from '@/lib/utils';
import { Head } from '@inertiajs/react';
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

type ViewMode = 'month' | 'year';
type TaskStatus = 'pendiente' | 'postergado' | 'completado';

interface Task {
    id: string;
    title: string;
    date: string; // yyyy-MM-dd
    color: string;
    status: TaskStatus;
}

const COLORS = [
    'bg-red-500',
    'bg-blue-500',
    'bg-green-500',
    'bg-yellow-500',
    'bg-purple-500',
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

export default function Calendar() {
    const [currentDate, setCurrentDate] = useState(new Date());
    const [viewMode, setViewMode] = useState<ViewMode>('month');
    const [tasks, setTasks] = useState<Task[]>([]);
    const [isDialogOpen, setIsDialogOpen] = useState(false);
    const [editingTask, setEditingTask] = useState<Task | null>(null);
    const [selectedDate, setSelectedDate] = useState<Date | null>(null);
    const [taskTitle, setTaskTitle] = useState('');
    const [taskColor, setTaskColor] = useState(COLORS[0]);
    const [taskStatus, setTaskStatus] = useState<TaskStatus>('pendiente');
    const [draggedTask, setDraggedTask] = useState<Task | null>(null);

    const dragOverRef = useRef<string | null>(null);

    // Cargar tareas
    useEffect(() => {
        const saved = localStorage.getItem('calendar-tasks-v2');
        if (saved) {
            const parsed = JSON.parse(saved);
            setTasks(
                parsed.map((t: any) => ({
                    ...t,
                    status: t.status || 'pendiente',
                })),
            );
        }
    }, []);

    // Guardar tareas
    useEffect(() => {
        localStorage.setItem('calendar-tasks-v2', JSON.stringify(tasks));
    }, [tasks]);

    const year = currentDate.getFullYear();
    const month = currentDate.getMonth();

    // Navegación
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

    const goToToday = () => {
        setCurrentDate(new Date());
    };

    const handleYearChange = (value: string) => {
        setCurrentDate(new Date(parseInt(value), month));
    };

    const handleMonthChange = (value: string) => {
        setCurrentDate(new Date(year, parseInt(value)));
    };

    // Cambiar a mes desde vista anual
    const goToMonth = (monthIndex: number) => {
        setCurrentDate(setMonth(currentDate, monthIndex));
        setViewMode('month');
    };

    // Abrir diálogo (nuevo o editar)
    const openTaskDialog = (date?: Date, task?: Task) => {
        if (task) {
            setEditingTask(task);
            setTaskTitle(task.title);
            setTaskColor(task.color);
            setTaskStatus(task.status);
            setSelectedDate(new Date(task.date));
        } else {
            setEditingTask(null);
            setTaskTitle('');
            setTaskColor(COLORS[0]);
            setTaskStatus('pendiente');
            setSelectedDate(date || null);
        }
        setIsDialogOpen(true);
    };

    // Guardar tarea
    const saveTask = () => {
        if (!selectedDate || !taskTitle.trim()) return;

        const dateStr = format(selectedDate, 'yyyy-MM-dd');

        if (editingTask) {
            setTasks((prev) =>
                prev.map((t) =>
                    t.id === editingTask.id
                        ? {
                              ...t,
                              title: taskTitle.trim(),
                              color: taskColor,
                              status: taskStatus,
                              date: dateStr,
                          }
                        : t,
                ),
            );
        } else {
            const newTask: Task = {
                id: Date.now().toString(),
                title: taskTitle.trim(),
                date: dateStr,
                color: taskColor,
                status: taskStatus,
            };
            setTasks((prev) => [...prev, newTask]);
        }

        setIsDialogOpen(false);
    };

    // Eliminar tarea
    const deleteTask = (id: string) => {
        setTasks((prev) => prev.filter((t) => t.id !== id));
    };

    // Drag & Drop
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

        setTasks((prev) =>
            prev.map((t) =>
                t.id === draggedTask.id ? { ...t, date: dateStr } : t,
            ),
        );
        setDraggedTask(null);
        dragOverRef.current = null;
    };

    const getTasksForDate = (dateStr: string) => {
        return tasks.filter((t) => t.date === dateStr);
    };

    // Vista Mensual
    const MonthlyView = () => {
        const monthStart = startOfMonth(currentDate);
        const monthEnd = endOfMonth(currentDate);
        const days = eachDayOfInterval({ start: monthStart, end: monthEnd });
        const startDayOfWeek = monthStart.getDay();

        return (
            <div className="grid grid-cols-7 gap-1">
                {['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'].map(
                    (day) => (
                        <div
                            key={day}
                            className="py-2 text-center text-sm font-medium text-muted-foreground"
                        >
                            {day}
                        </div>
                    ),
                )}

                {Array.from({ length: startDayOfWeek }, (_, i) => (
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
                                'flex min-h-24 cursor-pointer flex-col gap-1 rounded-md border p-1 transition-colors',
                                isToday && 'ring-2 ring-primary',
                                dragOverRef.current === dateStr && 'bg-muted',
                            )}
                            onClick={() => openTaskDialog(day)}
                        >
                            <div
                                className={cn(
                                    'text-sm font-medium',
                                    isToday && 'text-primary',
                                )}
                            >
                                {format(day, 'd')}
                            </div>

                            <div className="flex-1 space-y-1 overflow-y-auto">
                                {dayTasks.map((task) => (
                                    <div
                                        key={task.id}
                                        draggable
                                        onDragStart={(e) =>
                                            handleDragStart(e, task)
                                        }
                                        onClick={(e) => {
                                            e.stopPropagation();
                                            openTaskDialog(undefined, task);
                                        }}
                                        className={cn(
                                            'group flex cursor-move items-center gap-1 rounded p-1 text-xs text-white',
                                            task.color,
                                        )}
                                    >
                                        <GripVertical className="h-3 w-3 opacity-70" />
                                        <span className="flex-1 truncate">
                                            {task.title}
                                        </span>
                                        <div
                                            className={cn(
                                                'text-xs',
                                                STATUS_CONFIG[task.status]
                                                    .color,
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
                                            <Trash2 className="h-3 w-3" />
                                        </button>
                                    </div>
                                ))}
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

    // Vista Anual
    const YearlyView = () => {
        return (
            <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
                {Array.from({ length: 12 }, (_, i) => {
                    const monthDate = new Date(year, i, 1);
                    const monthStart = startOfMonth(monthDate);
                    const monthEnd = endOfMonth(monthDate);
                    const days = eachDayOfInterval({
                        start: monthStart,
                        end: monthEnd,
                    });
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
                                    {['D', 'L', 'M', 'M', 'J', 'V', 'S'].map(
                                        (d) => (
                                            <div
                                                key={d}
                                                className="p-1 text-center font-medium text-muted-foreground"
                                            >
                                                {d}
                                            </div>
                                        ),
                                    )}
                                    {Array.from({ length: startDayOfWeek }).map(
                                        (_, idx) => (
                                            <div key={`empty-${idx}`} />
                                        ),
                                    )}
                                    {days.map((day) => {
                                        const dateStr = format(
                                            day,
                                            'yyyy-MM-dd',
                                        );
                                        const dayTasks =
                                            getTasksForDate(dateStr);
                                        const isToday = isSameDay(
                                            day,
                                            new Date(),
                                        );

                                        return (
                                            <div
                                                key={dateStr}
                                                onDragOver={(e) =>
                                                    handleDragOver(e, dateStr)
                                                }
                                                onDrop={(e) =>
                                                    handleDrop(e, dateStr)
                                                }
                                                className={cn(
                                                    'min-h-6 border-t border-l p-1 text-center last:border-r',
                                                    isToday &&
                                                        'bg-primary font-bold text-white',
                                                    dragOverRef.current ===
                                                        dateStr && 'bg-muted',
                                                )}
                                            >
                                                <div className="font-medium">
                                                    {format(day, 'd')}
                                                </div>
                                                {dayTasks.length > 0 && (
                                                    <div className="mt-0.5 flex justify-center gap-0.5">
                                                        {dayTasks
                                                            .slice(0, 3)
                                                            .map((task) => (
                                                                <div
                                                                    key={
                                                                        task.id
                                                                    }
                                                                    className={cn(
                                                                        'h-1.5 w-1.5 rounded-full',
                                                                        task.color,
                                                                    )}
                                                                    title={`${task.title} [${task.status}]`}
                                                                />
                                                            ))}
                                                        {dayTasks.length >
                                                            3 && (
                                                            <Badge
                                                                variant="secondary"
                                                                className="h-3 px-1 text-[10px]"
                                                            >
                                                                +
                                                                {dayTasks.length -
                                                                    3}
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

    // Lista lateral de tareas
    const TaskList = () => {
        const sortedTasks = [...tasks].sort((a, b) =>
            a.date.localeCompare(b.date),
        );

        return (
            <Card className="h-full">
                <CardHeader>
                    <CardTitle className="flex items-center justify-between text-lg">
                        Tareas ({tasks.length})
                        <Button
                            size="sm"
                            onClick={() => openTaskDialog(new Date())}
                        >
                            <Plus className="mr-1 h-4 w-4" /> Nueva
                        </Button>
                    </CardTitle>
                </CardHeader>
                <CardContent className="p-0">
                    <ScrollArea className="h-[calc(100vh-16rem)] px-4">
                        {sortedTasks.length === 0 ? (
                            <p className="py-8 text-center text-muted-foreground">
                                No hay tareas
                            </p>
                        ) : (
                            <div className="space-y-3 pb-4">
                                {sortedTasks.map((task) => (
                                    <div
                                        key={task.id}
                                        className="flex cursor-pointer items-start gap-3 rounded-lg border bg-card p-3 transition-colors hover:bg-muted/50"
                                        onClick={() =>
                                            openTaskDialog(undefined, task)
                                        }
                                    >
                                        <div
                                            className={cn(
                                                'mt-1 h-3 w-3 flex-shrink-0 rounded-full',
                                                task.color,
                                            )}
                                        />
                                        <div className="min-w-0 flex-1">
                                            <p className="truncate text-sm font-medium">
                                                {task.title}
                                            </p>
                                            <div className="mt-1 flex items-center gap-2 text-xs text-muted-foreground">
                                                <span>
                                                    {format(
                                                        new Date(task.date),
                                                        'dd MMM yyyy',
                                                    )}
                                                </span>
                                                <span className="mx-1">•</span>
                                                <span
                                                    className={
                                                        STATUS_CONFIG[
                                                            task.status
                                                        ].color
                                                    }
                                                >
                                                    {
                                                        STATUS_CONFIG[
                                                            task.status
                                                        ].icon
                                                    }{' '}
                                                    {
                                                        STATUS_CONFIG[
                                                            task.status
                                                        ].label
                                                    }
                                                </span>
                                            </div>
                                        </div>
                                        <Button
                                            size="sm"
                                            variant="ghost"
                                            onClick={(e) => {
                                                e.stopPropagation();
                                                deleteTask(task.id);
                                            }}
                                        >
                                            <Trash2 className="h-4 w-4" />
                                        </Button>
                                    </div>
                                ))}
                            </div>
                        )}
                    </ScrollArea>
                </CardContent>
            </Card>
        );
    };

    return (
        <>
            <Head title="Calendario Avanzado" />

            <div className="min-h-screen bg-background">
                <div className="mx-auto grid max-w-7xl grid-cols-1 gap-6 px-4 py-8 sm:px-6 lg:grid-cols-4 lg:px-8">
                    {/* Calendario */}
                    <div className="lg:col-span-3">
                        <Card>
                            <CardContent className="p-6">
                                {/* Controles */}
                                <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                                    <div className="flex items-center gap-2">
                                        <Button
                                            variant="outline"
                                            size="icon"
                                            onClick={goToPrevious}
                                        >
                                            <ChevronLeft className="h-4 w-4" />
                                        </Button>

                                        <div className="flex items-center gap-2">
                                            {viewMode === 'month' ? (
                                                <>
                                                    <Select
                                                        value={month.toString()}
                                                        onValueChange={
                                                            handleMonthChange
                                                        }
                                                    >
                                                        <SelectTrigger className="w-36">
                                                            <SelectValue />
                                                        </SelectTrigger>
                                                        <SelectContent>
                                                            {Array.from(
                                                                { length: 12 },
                                                                (_, i) => (
                                                                    <SelectItem
                                                                        key={i}
                                                                        value={i.toString()}
                                                                    >
                                                                        {format(
                                                                            new Date(
                                                                                year,
                                                                                i,
                                                                            ),
                                                                            'MMMM',
                                                                        )}
                                                                    </SelectItem>
                                                                ),
                                                            )}
                                                        </SelectContent>
                                                    </Select>

                                                    <Select
                                                        value={year.toString()}
                                                        onValueChange={
                                                            handleYearChange
                                                        }
                                                    >
                                                        <SelectTrigger className="w-24">
                                                            <SelectValue />
                                                        </SelectTrigger>
                                                        <SelectContent>
                                                            {Array.from(
                                                                { length: 11 },
                                                                (_, i) => {
                                                                    const y =
                                                                        year -
                                                                        5 +
                                                                        i;
                                                                    return (
                                                                        <SelectItem
                                                                            key={
                                                                                y
                                                                            }
                                                                            value={y.toString()}
                                                                        >
                                                                            {y}
                                                                        </SelectItem>
                                                                    );
                                                                },
                                                            )}
                                                        </SelectContent>
                                                    </Select>
                                                </>
                                            ) : (
                                                <h2 className="px-4 text-xl font-semibold">
                                                    {year}
                                                </h2>
                                            )}
                                        </div>

                                        <Button
                                            variant="outline"
                                            size="icon"
                                            onClick={goToNext}
                                        >
                                            <ChevronRight className="h-4 w-4" />
                                        </Button>
                                    </div>

                                    <div className="flex items-center gap-2">
                                        <Button
                                            variant="outline"
                                            size="sm"
                                            onClick={goToToday}
                                        >
                                            Hoy
                                        </Button>

                                        <Tabs
                                            value={viewMode}
                                            onValueChange={(v) =>
                                                setViewMode(v as ViewMode)
                                            }
                                        >
                                            <TabsList>
                                                <TabsTrigger value="month">
                                                    Mensual
                                                </TabsTrigger>
                                                <TabsTrigger value="year">
                                                    Anual
                                                </TabsTrigger>
                                            </TabsList>
                                        </Tabs>
                                    </div>
                                </div>

                                {/* Vista */}
                                <div className="mt-6">
                                    {viewMode === 'month' ? (
                                        <MonthlyView />
                                    ) : (
                                        <YearlyView />
                                    )}
                                </div>
                            </CardContent>
                        </Card>
                    </div>

                    {/* Lista de tareas */}
                    <div className="hidden lg:col-span-1 lg:block">
                        <TaskList />
                    </div>
                </div>
            </div>

            {/* Diálogo */}
            <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
                <DialogContent className="sm:max-w-md">
                    <DialogHeader>
                        <DialogTitle>
                            {editingTask ? 'Editar tarea' : 'Nueva tarea'} -{' '}
                            {selectedDate &&
                                format(selectedDate, 'dd MMMM yyyy')}
                        </DialogTitle>
                    </DialogHeader>
                    <div className="space-y-4">
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
                                    [
                                        'pendiente',
                                        'postergado',
                                        'completado',
                                    ] as TaskStatus[]
                                ).map((status) => (
                                    <Button
                                        key={status}
                                        variant={
                                            taskStatus === status
                                                ? 'default'
                                                : 'outline'
                                        }
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
                        <Button
                            variant="outline"
                            onClick={() => setIsDialogOpen(false)}
                        >
                            Cancelar
                        </Button>
                        <Button onClick={saveTask}>
                            {editingTask ? 'Actualizar' : 'Guardar'}
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>
        </>
    );
}
// -----------------------------------------------------------------------------------------------
// 'use client';

// import { Badge } from '@/components/ui/badge';
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import {
//     Dialog,
//     DialogContent,
//     DialogFooter,
//     DialogHeader,
//     DialogTitle,
// } from '@/components/ui/dialog';
// import { Input } from '@/components/ui/input';
// import { Label } from '@/components/ui/label';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
// import { cn } from '@/lib/utils';
// import { Head } from '@inertiajs/react';
// import {
//     addMonths,
//     addYears,
//     eachDayOfInterval,
//     endOfMonth,
//     format,
//     isSameDay,
//     startOfMonth,
//     subMonths,
//     subYears,
// } from 'date-fns';
// import {
//     ChevronLeft,
//     ChevronRight,
//     GripVertical,
//     Plus,
//     Trash2,
// } from 'lucide-react';
// import { useEffect, useRef, useState } from 'react';

// type ViewMode = 'month' | 'year';

// interface Task {
//     id: string;
//     title: string;
//     date: string; // ISO string
//     color: string;
// }

// const COLORS = [
//     'bg-red-500',
//     'bg-blue-500',
//     'bg-green-500',
//     'bg-yellow-500',
//     'bg-purple-500',
// ];

// export default function Calendar() {
//     const [currentDate, setCurrentDate] = useState(new Date());
//     const [viewMode, setViewMode] = useState<ViewMode>('month');
//     const [tasks, setTasks] = useState<Task[]>([]);
//     const [isDialogOpen, setIsDialogOpen] = useState(false);
//     const [selectedDate, setSelectedDate] = useState<Date | null>(null);
//     const [taskTitle, setTaskTitle] = useState('');
//     const [taskColor, setTaskColor] = useState(COLORS[0]);
//     const [draggedTask, setDraggedTask] = useState<Task | null>(null);

//     const dragOverRef = useRef<string | null>(null);

//     // Cargar tareas desde localStorage
//     useEffect(() => {
//         const saved = localStorage.getItem('calendar-tasks');
//         if (saved) {
//             setTasks(JSON.parse(saved));
//         }
//     }, []);

//     // Guardar tareas
//     useEffect(() => {
//         localStorage.setItem('calendar-tasks', JSON.stringify(tasks));
//     }, [tasks]);

//     const year = currentDate.getFullYear();
//     const month = currentDate.getMonth();

//     // Navegación
//     const goToPrevious = () => {
//         setCurrentDate(
//             viewMode === 'month'
//                 ? subMonths(currentDate, 1)
//                 : subYears(currentDate, 1),
//         );
//     };

//     const goToNext = () => {
//         setCurrentDate(
//             viewMode === 'month'
//                 ? addMonths(currentDate, 1)
//                 : addYears(currentDate, 1),
//         );
//     };

//     const goToToday = () => {
//         setCurrentDate(new Date());
//     };

//     const handleYearChange = (value: string) => {
//         setCurrentDate(new Date(parseInt(value), month));
//     };

//     const handleMonthChange = (value: string) => {
//         setCurrentDate(new Date(year, parseInt(value)));
//     };

//     // Abrir diálogo para agregar tarea
//     const openAddTask = (date: Date) => {
//         setSelectedDate(date);
//         setTaskTitle('');
//         setTaskColor(COLORS[0]);
//         setIsDialogOpen(true);
//     };

//     // Guardar tarea
//     const saveTask = () => {
//         if (!selectedDate || !taskTitle.trim()) return;

//         const newTask: Task = {
//             id: Date.now().toString(),
//             title: taskTitle.trim(),
//             date: format(selectedDate, 'yyyy-MM-dd'),
//             color: taskColor,
//         };

//         setTasks((prev) => [...prev, newTask]);
//         setIsDialogOpen(false);
//     };

//     // Eliminar tarea
//     const deleteTask = (id: string) => {
//         setTasks((prev) => prev.filter((t) => t.id !== id));
//     };

//     // Drag & Drop
//     const handleDragStart = (e: React.DragEvent, task: Task) => {
//         setDraggedTask(task);
//         e.dataTransfer.effectAllowed = 'move';
//     };

//     const handleDragOver = (e: React.DragEvent, dateStr: string) => {
//         e.preventDefault();
//         dragOverRef.current = dateStr;
//     };

//     const handleDrop = (e: React.DragEvent, dateStr: string) => {
//         e.preventDefault();
//         if (!draggedTask) return;

//         setTasks((prev) =>
//             prev.map((t) =>
//                 t.id === draggedTask.id ? { ...t, date: dateStr } : t,
//             ),
//         );
//         setDraggedTask(null);
//         dragOverRef.current = null;
//     };

//     const getTasksForDate = (dateStr: string) => {
//         return tasks.filter((t) => t.date === dateStr);
//     };

//     // Vista Mensual
//     const MonthlyView = () => {
//         const monthStart = startOfMonth(currentDate);
//         const monthEnd = endOfMonth(currentDate);
//         const days = eachDayOfInterval({ start: monthStart, end: monthEnd });
//         const startDayOfWeek = monthStart.getDay();

//         return (
//             <div className="grid grid-cols-7 gap-1">
//                 {['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'].map(
//                     (day) => (
//                         <div
//                             key={day}
//                             className="py-2 text-center text-sm font-medium text-muted-foreground"
//                         >
//                             {day}
//                         </div>
//                     ),
//                 )}

//                 {Array.from({ length: startDayOfWeek }, (_, i) => (
//                     <div
//                         key={`empty-${i}`}
//                         className="h-24 rounded-md border bg-muted/20"
//                     />
//                 ))}

//                 {days.map((day) => {
//                     const dateStr = format(day, 'yyyy-MM-dd');
//                     const dayTasks = getTasksForDate(dateStr);
//                     const isToday = isSameDay(day, new Date());

//                     return (
//                         <div
//                             key={dateStr}
//                             onDragOver={(e) => handleDragOver(e, dateStr)}
//                             onDrop={(e) => handleDrop(e, dateStr)}
//                             className={cn(
//                                 'flex min-h-24 cursor-pointer flex-col gap-1 rounded-md border p-1 transition-colors',
//                                 isToday && 'ring-2 ring-primary',
//                                 dragOverRef.current === dateStr && 'bg-muted',
//                             )}
//                             onClick={() => openAddTask(day)}
//                         >
//                             <div
//                                 className={cn(
//                                     'text-sm font-medium',
//                                     isToday && 'text-primary',
//                                 )}
//                             >
//                                 {format(day, 'd')}
//                             </div>

//                             <div className="flex-1 space-y-1 overflow-y-auto">
//                                 {dayTasks.map((task) => (
//                                     <div
//                                         key={task.id}
//                                         draggable
//                                         onDragStart={(e) =>
//                                             handleDragStart(e, task)
//                                         }
//                                         className={cn(
//                                             'flex cursor-move items-center gap-1 rounded p-1 text-xs text-white',
//                                             task.color,
//                                         )}
//                                     >
//                                         <GripVertical className="h-3 w-3 opacity-70" />
//                                         <span className="flex-1 truncate">
//                                             {task.title}
//                                         </span>
//                                         <button
//                                             onClick={(e) => {
//                                                 e.stopPropagation();
//                                                 deleteTask(task.id);
//                                             }}
//                                             className="opacity-0 transition-opacity hover:opacity-100"
//                                         >
//                                             <Trash2 className="h-3 w-3" />
//                                         </button>
//                                     </div>
//                                 ))}
//                             </div>

//                             {dayTasks.length === 0 && (
//                                 <Button
//                                     size="sm"
//                                     variant="ghost"
//                                     className="mt-auto h-6 text-xs"
//                                     onClick={(e) => {
//                                         e.stopPropagation();
//                                         openAddTask(day);
//                                     }}
//                                 >
//                                     <Plus className="mr-1 h-3 w-3" /> Agregar
//                                 </Button>
//                             )}
//                         </div>
//                     );
//                 })}
//             </div>
//         );
//     };

//     // Vista Anual
//     const YearlyView = () => {
//         return (
//             <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
//                 {Array.from({ length: 12 }, (_, i) => {
//                     const monthDate = new Date(year, i, 1);
//                     const monthStart = startOfMonth(monthDate);
//                     const monthEnd = endOfMonth(monthDate);
//                     const days = eachDayOfInterval({
//                         start: monthStart,
//                         end: monthEnd,
//                     });
//                     const startDayOfWeek = monthStart.getDay();

//                     return (
//                         <Card key={i} className="overflow-hidden">
//                             <CardHeader className="px-3 pt-3 pb-2">
//                                 <CardTitle className="text-center text-sm">
//                                     {format(monthDate, 'MMMM')}
//                                 </CardTitle>
//                             </CardHeader>
//                             <CardContent className="p-0">
//                                 <div className="grid grid-cols-7 gap-0 text-xs">
//                                     {['D', 'L', 'M', 'M', 'J', 'V', 'S'].map(
//                                         (d) => (
//                                             <div
//                                                 key={d}
//                                                 className="p-1 text-center font-medium text-muted-foreground"
//                                             >
//                                                 {d}
//                                             </div>
//                                         ),
//                                     )}
//                                     {Array.from({ length: startDayOfWeek }).map(
//                                         (_, idx) => (
//                                             <div key={`empty-${idx}`} />
//                                         ),
//                                     )}
//                                     {days.map((day) => {
//                                         const dateStr = format(
//                                             day,
//                                             'yyyy-MM-dd',
//                                         );
//                                         const dayTasks =
//                                             getTasksForDate(dateStr);
//                                         const isToday = isSameDay(
//                                             day,
//                                             new Date(),
//                                         );

//                                         return (
//                                             <div
//                                                 key={dateStr}
//                                                 onDragOver={(e) =>
//                                                     handleDragOver(e, dateStr)
//                                                 }
//                                                 onDrop={(e) =>
//                                                     handleDrop(e, dateStr)
//                                                 }
//                                                 className={cn(
//                                                     'min-h-6 border-t border-l p-1 text-center last:border-r',
//                                                     isToday &&
//                                                         'bg-primary font-bold text-white',
//                                                     dragOverRef.current ===
//                                                         dateStr && 'bg-muted',
//                                                 )}
//                                                 onClick={() => openAddTask(day)}
//                                             >
//                                                 <div className="font-medium">
//                                                     {format(day, 'd')}
//                                                 </div>
//                                                 {dayTasks.length > 0 && (
//                                                     <div className="mt-0.5 flex justify-center gap-0.5">
//                                                         {dayTasks
//                                                             .slice(0, 3)
//                                                             .map((task) => (
//                                                                 <div
//                                                                     key={
//                                                                         task.id
//                                                                     }
//                                                                     className={cn(
//                                                                         'h-1.5 w-1.5 rounded-full',
//                                                                         task.color,
//                                                                     )}
//                                                                     title={
//                                                                         task.title
//                                                                     }
//                                                                 />
//                                                             ))}
//                                                         {dayTasks.length >
//                                                             3 && (
//                                                             <Badge
//                                                                 variant="secondary"
//                                                                 className="h-3 px-1 text-[10px]"
//                                                             >
//                                                                 +
//                                                                 {dayTasks.length -
//                                                                     3}
//                                                             </Badge>
//                                                         )}
//                                                     </div>
//                                                 )}
//                                             </div>
//                                         );
//                                     })}
//                                 </div>
//                             </CardContent>
//                         </Card>
//                     );
//                 })}
//             </div>
//         );
//     };

//     return (
//         <>
//             <Head title="Calendario con Tareas" />

//             <div className="min-h-screen bg-background py-8">
//                 <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
//                     <div className="mb-8">
//                         <h1 className="text-3xl font-bold tracking-tight">
//                             Calendario con Tareas
//                         </h1>
//                         <p className="mt-1 text-muted-foreground">
//                             Arrastra tareas entre días
//                         </p>
//                     </div>

//                     <Card>
//                         <CardContent className="p-6">
//                             {/* Controles */}
//                             <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
//                                 <div className="flex items-center gap-2">
//                                     <Button
//                                         variant="outline"
//                                         size="icon"
//                                         onClick={goToPrevious}
//                                     >
//                                         <ChevronLeft className="h-4 w-4" />
//                                     </Button>

//                                     <div className="flex items-center gap-2">
//                                         {viewMode === 'month' ? (
//                                             <>
//                                                 <Select
//                                                     value={month.toString()}
//                                                     onValueChange={
//                                                         handleMonthChange
//                                                     }
//                                                 >
//                                                     <SelectTrigger className="w-36">
//                                                         <SelectValue />
//                                                     </SelectTrigger>
//                                                     <SelectContent>
//                                                         {Array.from(
//                                                             { length: 12 },
//                                                             (_, i) => (
//                                                                 <SelectItem
//                                                                     key={i}
//                                                                     value={i.toString()}
//                                                                 >
//                                                                     {format(
//                                                                         new Date(
//                                                                             year,
//                                                                             i,
//                                                                         ),
//                                                                         'MMMM',
//                                                                     )}
//                                                                 </SelectItem>
//                                                             ),
//                                                         )}
//                                                     </SelectContent>
//                                                 </Select>

//                                                 <Select
//                                                     value={year.toString()}
//                                                     onValueChange={
//                                                         handleYearChange
//                                                     }
//                                                 >
//                                                     <SelectTrigger className="w-24">
//                                                         <SelectValue />
//                                                     </SelectTrigger>
//                                                     <SelectContent>
//                                                         {Array.from(
//                                                             { length: 11 },
//                                                             (_, i) => {
//                                                                 const y =
//                                                                     year -
//                                                                     5 +
//                                                                     i;
//                                                                 return (
//                                                                     <SelectItem
//                                                                         key={y}
//                                                                         value={y.toString()}
//                                                                     >
//                                                                         {y}
//                                                                     </SelectItem>
//                                                                 );
//                                                             },
//                                                         )}
//                                                     </SelectContent>
//                                                 </Select>
//                                             </>
//                                         ) : (
//                                             <h2 className="px-4 text-xl font-semibold">
//                                                 {year}
//                                             </h2>
//                                         )}
//                                     </div>

//                                     <Button
//                                         variant="outline"
//                                         size="icon"
//                                         onClick={goToNext}
//                                     >
//                                         <ChevronRight className="h-4 w-4" />
//                                     </Button>
//                                 </div>

//                                 <div className="flex items-center gap-2">
//                                     <Button
//                                         variant="outline"
//                                         size="sm"
//                                         onClick={goToToday}
//                                     >
//                                         Hoy
//                                     </Button>

//                                     <Tabs
//                                         value={viewMode}
//                                         onValueChange={(v) =>
//                                             setViewMode(v as ViewMode)
//                                         }
//                                     >
//                                         <TabsList>
//                                             <TabsTrigger value="month">
//                                                 Mensual
//                                             </TabsTrigger>
//                                             <TabsTrigger value="year">
//                                                 Anual
//                                             </TabsTrigger>
//                                         </TabsList>
//                                     </Tabs>
//                                 </div>
//                             </div>

//                             {/* Vista */}
//                             <div className="mt-6">
//                                 {viewMode === 'month' ? (
//                                     <MonthlyView />
//                                 ) : (
//                                     <YearlyView />
//                                 )}
//                             </div>
//                         </CardContent>
//                     </Card>
//                 </div>
//             </div>

//             {/* Diálogo para agregar tarea */}
//             <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
//                 <DialogContent>
//                     <DialogHeader>
//                         <DialogTitle>
//                             Agregar tarea -{' '}
//                             {selectedDate &&
//                                 format(selectedDate, 'dd MMMM yyyy')}
//                         </DialogTitle>
//                     </DialogHeader>
//                     <div className="space-y-4">
//                         <div>
//                             <Label htmlFor="title">Título</Label>
//                             <Input
//                                 id="title"
//                                 value={taskTitle}
//                                 onChange={(e) => setTaskTitle(e.target.value)}
//                                 placeholder="Reunión con equipo"
//                                 autoFocus
//                             />
//                         </div>
//                         <div>
//                             <Label>Color</Label>
//                             <div className="mt-2 flex gap-2">
//                                 {COLORS.map((color) => (
//                                     <button
//                                         key={color}
//                                         onClick={() => setTaskColor(color)}
//                                         className={cn(
//                                             'h-8 w-8 rounded-full transition-transform',
//                                             color,
//                                             taskColor === color &&
//                                                 'scale-110 ring-2 ring-foreground ring-offset-2',
//                                         )}
//                                     />
//                                 ))}
//                             </div>
//                         </div>
//                     </div>
//                     <DialogFooter>
//                         <Button
//                             variant="outline"
//                             onClick={() => setIsDialogOpen(false)}
//                         >
//                             Cancelar
//                         </Button>
//                         <Button onClick={saveTask}>Guardar</Button>
//                     </DialogFooter>
//                 </DialogContent>
//             </Dialog>
//         </>
//     );
// }

// ---------------------------------------------------------------------------------------------
// 'use client';

// import { Head } from '@inertiajs/react';
// import {
//     addMonths,
//     addYears,
//     eachDayOfInterval,
//     endOfMonth,
//     format,
//     isSameDay,
//     startOfMonth,
//     subMonths,
//     subYears,
// } from 'date-fns';
// import { ChevronLeft, ChevronRight } from 'lucide-react';
// import { useState } from 'react';

// // shadcn/ui components
// import { Button } from '@/components/ui/button';
// import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
// import {
//     Select,
//     SelectContent,
//     SelectItem,
//     SelectTrigger,
//     SelectValue,
// } from '@/components/ui/select';
// import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';

// type ViewMode = 'month' | 'year';

// export default function Calendar() {
//     const [currentDate, setCurrentDate] = useState(new Date());
//     const [viewMode, setViewMode] = useState<ViewMode>('month');

//     const year = currentDate.getFullYear();
//     const month = currentDate.getMonth();

//     // Navegación
//     const goToPrevious = () => {
//         setCurrentDate(
//             viewMode === 'month'
//                 ? subMonths(currentDate, 1)
//                 : subYears(currentDate, 1),
//         );
//     };

//     const goToNext = () => {
//         setCurrentDate(
//             viewMode === 'month'
//                 ? addMonths(currentDate, 1)
//                 : addYears(currentDate, 1),
//         );
//     };

//     const goToToday = () => {
//         setCurrentDate(new Date());
//     };

//     const handleYearChange = (value: string) => {
//         setCurrentDate(new Date(parseInt(value), month));
//     };

//     const handleMonthChange = (value: string) => {
//         setCurrentDate(new Date(year, parseInt(value)));
//     };

//     // Vista Mensual
//     const MonthlyView = () => {
//         const monthStart = startOfMonth(currentDate);
//         const monthEnd = endOfMonth(currentDate);
//         const days = eachDayOfInterval({ start: monthStart, end: monthEnd });
//         const startDayOfWeek = monthStart.getDay(); // 0 = Domingo

//         return (
//             <div className="grid grid-cols-7 gap-1">
//                 {['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'].map(
//                     (day) => (
//                         <div
//                             key={day}
//                             className="py-2 text-center text-sm font-medium text-muted-foreground"
//                         >
//                             {day}
//                         </div>
//                     ),
//                 )}

//                 {/* Espacios vacíos al inicio */}
//                 {Array.from({ length: startDayOfWeek }, (_, i) => (
//                     <div
//                         key={`empty-start-${i}`}
//                         className="h-20 rounded-md border bg-muted/20"
//                     />
//                 ))}

//                 {days.map((day) => {
//                     const isToday = isSameDay(day, new Date());
//                     return (
//                         <div
//                             key={day.toISOString()}
//                             className={`flex h-20 flex-col rounded-md border p-1 text-sm ${isToday ? 'bg-primary font-bold text-primary-foreground' : 'hover:bg-muted'} cursor-pointer transition-colors`}
//                         >
//                             <div className="font-medium">
//                                 {format(day, 'd')}
//                             </div>
//                             <div className="mt-auto text-xs opacity-70">
//                                 {/* Aquí puedes mostrar eventos */}
//                             </div>
//                         </div>
//                     );
//                 })}
//             </div>
//         );
//     };

//     // Vista Anual
//     const YearlyView = () => {
//         return (
//             <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
//                 {Array.from({ length: 12 }, (_, i) => {
//                     const monthDate = new Date(year, i, 1);
//                     const monthStart = startOfMonth(monthDate);
//                     const monthEnd = endOfMonth(monthDate);
//                     const days = eachDayOfInterval({
//                         start: monthStart,
//                         end: monthEnd,
//                     });
//                     const startDayOfWeek = monthStart.getDay();

//                     return (
//                         <Card key={i} className="overflow-hidden">
//                             <CardHeader className="px-3 pt-3 pb-2">
//                                 <CardTitle className="text-center text-sm">
//                                     {format(monthDate, 'MMMM')}
//                                 </CardTitle>
//                             </CardHeader>
//                             <CardContent className="p-0">
//                                 <div className="grid grid-cols-7 gap-0 text-xs">
//                                     {['D', 'L', 'M', 'M', 'J', 'V', 'S'].map(
//                                         (d) => (
//                                             <div
//                                                 key={d}
//                                                 className="p-1 text-center font-medium text-muted-foreground"
//                                             >
//                                                 {d}
//                                             </div>
//                                         ),
//                                     )}
//                                     {Array.from({ length: startDayOfWeek }).map(
//                                         (_, idx) => (
//                                             <div key={`empty-${idx}`} />
//                                         ),
//                                     )}
//                                     {days.map((day) => {
//                                         const isToday = isSameDay(
//                                             day,
//                                             new Date(),
//                                         );
//                                         return (
//                                             <div
//                                                 key={day.toISOString()}
//                                                 className={`rounded p-1 text-center text-xs ${isToday ? 'bg-primary font-bold text-white' : ''} `}
//                                             >
//                                                 {format(day, 'd')}
//                                             </div>
//                                         );
//                                     })}
//                                 </div>
//                             </CardContent>
//                         </Card>
//                     );
//                 })}
//             </div>
//         );
//     };

//     return (
//         <>
//             <Head title="Calendario" />

//             <div className="min-h-screen bg-background py-8">
//                 <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
//                     <div className="mb-8">
//                         <h1 className="text-3xl font-bold tracking-tight">
//                             Calendario
//                         </h1>
//                         <p className="mt-1 text-muted-foreground">
//                             Vista mensual y anual intercambiable
//                         </p>
//                     </div>

//                     <Card>
//                         <CardContent className="p-6">
//                             {/* Controles superiores */}
//                             <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
//                                 <div className="flex items-center gap-2">
//                                     <Button
//                                         variant="outline"
//                                         size="icon"
//                                         onClick={goToPrevious}
//                                     >
//                                         <ChevronLeft className="h-4 w-4" />
//                                     </Button>

//                                     <div className="flex items-center gap-2">
//                                         {viewMode === 'month' ? (
//                                             <>
//                                                 <Select
//                                                     value={month.toString()}
//                                                     onValueChange={
//                                                         handleMonthChange
//                                                     }
//                                                 >
//                                                     <SelectTrigger className="w-36">
//                                                         <SelectValue />
//                                                     </SelectTrigger>
//                                                     <SelectContent>
//                                                         {Array.from(
//                                                             { length: 12 },
//                                                             (_, i) => (
//                                                                 <SelectItem
//                                                                     key={i}
//                                                                     value={i.toString()}
//                                                                 >
//                                                                     {format(
//                                                                         new Date(
//                                                                             year,
//                                                                             i,
//                                                                         ),
//                                                                         'MMMM',
//                                                                     )}
//                                                                 </SelectItem>
//                                                             ),
//                                                         )}
//                                                     </SelectContent>
//                                                 </Select>

//                                                 <Select
//                                                     value={year.toString()}
//                                                     onValueChange={
//                                                         handleYearChange
//                                                     }
//                                                 >
//                                                     <SelectTrigger className="w-24">
//                                                         <SelectValue />
//                                                     </SelectTrigger>
//                                                     <SelectContent>
//                                                         {Array.from(
//                                                             { length: 11 },
//                                                             (_, i) => {
//                                                                 const y =
//                                                                     year -
//                                                                     5 +
//                                                                     i;
//                                                                 return (
//                                                                     <SelectItem
//                                                                         key={y}
//                                                                         value={y.toString()}
//                                                                     >
//                                                                         {y}
//                                                                     </SelectItem>
//                                                                 );
//                                                             },
//                                                         )}
//                                                     </SelectContent>
//                                                 </Select>
//                                             </>
//                                         ) : (
//                                             <h2 className="px-4 text-xl font-semibold">
//                                                 {year}
//                                             </h2>
//                                         )}
//                                     </div>

//                                     <Button
//                                         variant="outline"
//                                         size="icon"
//                                         onClick={goToNext}
//                                     >
//                                         <ChevronRight className="h-4 w-4" />
//                                     </Button>
//                                 </div>

//                                 <div className="flex items-center gap-2">
//                                     <Button
//                                         variant="outline"
//                                         size="sm"
//                                         onClick={goToToday}
//                                     >
//                                         Hoy
//                                     </Button>

//                                     <Tabs
//                                         value={viewMode}
//                                         onValueChange={(v) =>
//                                             setViewMode(v as ViewMode)
//                                         }
//                                     >
//                                         <TabsList>
//                                             <TabsTrigger value="month">
//                                                 Mensual
//                                             </TabsTrigger>
//                                             <TabsTrigger value="year">
//                                                 Anual
//                                             </TabsTrigger>
//                                         </TabsList>
//                                     </Tabs>
//                                 </div>
//                             </div>

//                             {/* Vista del calendario */}
//                             <div className="mt-6">
//                                 {viewMode === 'month' ? (
//                                     <MonthlyView />
//                                 ) : (
//                                     <YearlyView />
//                                 )}
//                             </div>
//                         </CardContent>
//                     </Card>
//                 </div>
//             </div>
//         </>
//     );
// }
