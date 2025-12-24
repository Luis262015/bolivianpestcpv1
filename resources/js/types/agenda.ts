// src/types/agenda.ts
export type ViewMode = 'month' | 'year';
export type TaskStatus = 'pendiente' | 'postergado' | 'completado';

export interface Task {
  id: string;
  title: string;
  date: string; // yyyy-MM-dd
  color: string;
  status: TaskStatus;
}

export interface BreadcrumbItem {
  title: string;
  href: string;
}
