// src/components/agenda/MonthlyView.tsx
'use client';

import { Button } from '@/components/ui/button';
import { cn } from '@/lib/utils';
import type { Task } from '@/types/agenda';
import {
  eachDayOfInterval,
  endOfMonth,
  format,
  isSameDay,
  startOfMonth,
} from 'date-fns';
import { Plus } from 'lucide-react';
import { TaskItem } from './TaskItem';

interface MonthlyViewProps {
  currentDate: Date;
  tasks: Task[];
  getTasksForDate: (dateStr: string) => Task[];
  onOpenDialog: (date?: Date, task?: Task) => void;
  onDragStart: (e: React.DragEvent<HTMLDivElement>, task: Task) => void;
  onDragOver: (e: React.DragEvent<HTMLDivElement>, dateStr: string) => void;
  onDrop: (e: React.DragEvent<HTMLDivElement>, dateStr: string) => void;
  dragOverDate: string | null;
  onDeleteTask: (id: string) => void;
}

export function MonthlyView({
  currentDate,
  tasks,
  getTasksForDate,
  onOpenDialog,
  onDragStart,
  onDragOver,
  onDrop,
  dragOverDate,
  onDeleteTask,
}: MonthlyViewProps) {
  const monthStart = startOfMonth(currentDate);
  const monthEnd = endOfMonth(currentDate);
  const days = eachDayOfInterval({ start: monthStart, end: monthEnd });
  const startDayOfWeek = monthStart.getDay(); // 0 = Domingo

  const today = new Date();

  return (
    <div className="grid grid-cols-7 gap-1">
      {/* Cabecera de días */}
      {['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'].map((day) => (
        <div
          key={day}
          className="py-2 text-center text-sm font-medium text-muted-foreground"
        >
          {day}
        </div>
      ))}

      {/* Espacios vacíos al inicio */}
      {Array.from({ length: startDayOfWeek }).map((_, i) => (
        <div
          key={`empty-${i}`}
          className="h-24 rounded-md border bg-muted/20"
        />
      ))}

      {/* Días del mes */}
      {days.map((day) => {
        const dateStr = format(day, 'yyyy-MM-dd');
        const dayTasks = getTasksForDate(dateStr);
        const isToday = isSameDay(day, today);

        return (
          <div
            key={dateStr}
            onDragOver={(e) => onDragOver(e, dateStr)}
            onDrop={(e) => onDrop(e, dateStr)}
            onClick={() => onOpenDialog(day)}
            className={cn(
              'flex min-h-24 cursor-pointer flex-col gap-1 rounded-md border p-1 transition-colors',
              isToday && 'ring-2 ring-primary',
              dragOverDate === dateStr && 'bg-muted',
            )}
          >
            <div
              className={cn('text-sm font-medium', isToday && 'text-primary')}
            >
              {format(day, 'd')}
            </div>

            <div className="flex-1 space-y-1 overflow-y-auto">
              {dayTasks.map((task) => (
                <TaskItem
                  key={task.id}
                  task={task}
                  draggable
                  onDragStart={(e) => onDragStart(e, task)}
                  onEdit={() => onOpenDialog(undefined, task)}
                  onDelete={() => onDeleteTask(task.id)}
                />
              ))}
            </div>

            {dayTasks.length === 0 && (
              <Button
                size="sm"
                variant="ghost"
                className="mt-auto h-6 text-xs"
                onClick={(e) => {
                  e.stopPropagation();
                  onOpenDialog(day);
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
}
