// src/hooks/useAgenda.ts
'use client';

import { createAgendaApi } from '@/lib/agendaApi';
import type { Task, ViewMode } from '@/types/agenda';
import { addMonths, addYears, setMonth, subMonths, subYears } from 'date-fns';
import { useRef, useState } from 'react';

interface UseAgendaProps {
  initialTasks: Task[];
  apiEndpoint: string;
}

export function useAgenda({ initialTasks, apiEndpoint }: UseAgendaProps) {
  const api = createAgendaApi(apiEndpoint);

  const [currentDate, setCurrentDate] = useState(new Date());
  const [viewMode, setViewMode] = useState<ViewMode>('month');
  const [tasks, setTasks] = useState<Task[]>(initialTasks);
  const [draggedTask, setDraggedTask] = useState<Task | null>(null);
  const dragOverRef = useRef<string | null>(null);

  const year = currentDate.getFullYear();
  const month = currentDate.getMonth();

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
    setCurrentDate(new Date(parseInt(value), month));
  };

  const handleMonthChange = (value: string) => {
    setCurrentDate(new Date(year, parseInt(value)));
  };

  const goToMonth = (monthIndex: number) => {
    setCurrentDate(setMonth(currentDate, monthIndex));
    setViewMode('month');
  };

  const saveTask = async (payload: Partial<Task>, editingTask?: Task) => {
    try {
      if (editingTask) {
        const { data } = await api.update(editingTask.id, payload);
        setTasks((prev) =>
          prev.map((t) => (t.id === editingTask.id ? data : t)),
        );
        return data;
      } else {
        const { data } = await api.create(payload);
        setTasks((prev) => [...prev, data]);
        return data;
      }
    } catch (error) {
      console.error('Error al guardar tarea', error);
      alert('Ocurrió un error al guardar la tarea');
    }
  };

  const deleteTask = async (id: string) => {
    if (!confirm('¿Estás seguro de eliminar esta tarea?')) return;
    try {
      await api.delete(id);
      setTasks((prev) => prev.filter((t) => t.id !== id));
    } catch (error) {
      console.error('Error al eliminar tarea', error);
      alert('Error al eliminar la tarea');
    }
  };

  const moveTask = async (task: Task, newDate: string) => {
    try {
      const { data } = await api.update(task.id, { date: newDate });
      setTasks((prev) => prev.map((t) => (t.id === task.id ? data : t)));
    } catch (error) {
      console.error('Error al mover tarea', error);
    }
    setDraggedTask(null);
    dragOverRef.current = null;
  };

  const getTasksForDate = (dateStr: string) =>
    tasks.filter((t) => t.date === dateStr);

  return {
    currentDate,
    setCurrentDate,
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
    saveTask,
    deleteTask,
    moveTask,
    getTasksForDate,
  };
}
