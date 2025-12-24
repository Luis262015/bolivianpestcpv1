// src/components/agenda/AgendaCalendar.tsx
'use client';

import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Tabs, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { COLORS } from '@/constants/agenda';
import { useAgenda } from '@/hooks/useAgenda';
import type { Task, TaskStatus } from '@/types/agenda';
import { format } from 'date-fns';
import { ChevronLeft, ChevronRight } from 'lucide-react';
import { useState } from 'react';
import { MonthlyView } from './MonthlyView';
import { TaskDialog } from './TaskDialog';
import { YearlyView } from './YearlyView';

interface AgendaCalendarProps {
  initialTasks: Task[];
  apiEndpoint: string;
}

export default function AgendaCalendar({
  initialTasks,
  apiEndpoint,
}: AgendaCalendarProps) {
  const {
    currentDate,
    viewMode,
    setViewMode,
    tasks,
    draggedTask,
    setDraggedTask,
    dragOverRef,
    year,
    month,
    goToPrevious,
    goToNext,
    goToToday,
    handleYearChange,
    handleMonthChange,
    goToMonth,
    getTasksForDate,
    saveTask,
    deleteTask,
    moveTask,
  } = useAgenda({ initialTasks, apiEndpoint });

  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [editingTask, setEditingTask] = useState<Task | null>(null);
  const [selectedDate, setSelectedDate] = useState<Date | null>(null);
  const [taskTitle, setTaskTitle] = useState('');
  const [taskColor, setTaskColor] = useState(COLORS[0]);
  const [taskStatus, setTaskStatus] = useState<TaskStatus>('pendiente');

  const openDialog = (date?: Date, task?: Task) => {
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

  const handleSave = async () => {
    if (!selectedDate || !taskTitle.trim()) return;

    const dateStr = format(selectedDate, 'yyyy-MM-dd');
    const payload = {
      title: taskTitle.trim(),
      date: dateStr,
      color: taskColor,
      status: taskStatus,
    };

    await saveTask(payload, editingTask);
    setIsDialogOpen(false);
  };

  const handleDragStart = (e: React.DragEvent<HTMLDivElement>, task: Task) => {
    setDraggedTask(task);
    e.dataTransfer.effectAllowed = 'move';
  };

  const handleDragOver = (
    e: React.DragEvent<HTMLDivElement>,
    dateStr: string,
  ) => {
    e.preventDefault();
    dragOverRef.current = dateStr;
  };

  const handleDrop = async (
    e: React.DragEvent<HTMLDivElement>,
    dateStr: string,
  ) => {
    e.preventDefault();
    if (!draggedTask) return;
    await moveTask(draggedTask, dateStr);
  };

  return (
    <Card>
      <CardContent className="p-6">
        {/* Controles de navegación */}
        <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div className="flex items-center gap-2">
            <Button variant="outline" size="icon" onClick={goToPrevious}>
              <ChevronLeft className="h-4 w-4" />
            </Button>

            <div className="flex items-center gap-2">
              {viewMode === 'month' ? (
                <>
                  <Select
                    value={month.toString()}
                    onValueChange={handleMonthChange}
                  >
                    <SelectTrigger className="w-36">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      {Array.from({ length: 12 }, (_, i) => (
                        <SelectItem key={i} value={i.toString()}>
                          {format(new Date(year, i), 'MMMM')}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>

                  <Select
                    value={year.toString()}
                    onValueChange={handleYearChange}
                  >
                    <SelectTrigger className="w-24">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      {Array.from({ length: 11 }, (_, i) => {
                        const y = year - 5 + i;
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
                <h2 className="px-4 text-xl font-semibold">{year}</h2>
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

        {/* Vista del calendario */}
        <div className="mt-6">
          {viewMode === 'month' ? (
            <MonthlyView
              currentDate={currentDate}
              tasks={tasks}
              getTasksForDate={getTasksForDate}
              onOpenDialog={openDialog}
              onDragStart={handleDragStart}
              onDragOver={handleDragOver}
              onDrop={handleDrop}
              dragOverDate={dragOverRef.current}
              onDeleteTask={deleteTask}
            />
          ) : (
            <YearlyView
              year={year}
              tasks={tasks}
              getTasksForDate={getTasksForDate}
              onGoToMonth={goToMonth}
              onDragOver={handleDragOver}
              onDrop={handleDrop}
              dragOverDate={dragOverRef.current}
            />
          )}
        </div>
      </CardContent>

      {/* Diálogo */}
      <TaskDialog
        open={isDialogOpen}
        onOpenChange={setIsDialogOpen}
        editingTask={editingTask}
        selectedDate={selectedDate}
        taskTitle={taskTitle}
        setTaskTitle={setTaskTitle}
        taskColor={taskColor}
        setTaskColor={setTaskColor}
        taskStatus={taskStatus}
        setTaskStatus={setTaskStatus}
        onSave={handleSave}
      />
    </Card>
  );
}
