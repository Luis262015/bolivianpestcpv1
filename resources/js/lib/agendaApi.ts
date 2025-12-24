// src/lib/api.ts
import type { Task } from '@/types/agenda';
import axios from 'axios';

export const createAgendaApi = (baseEndpoint: string) => ({
  create: (data: Partial<Task>) => axios.post<Task>(baseEndpoint, data),

  update: (id: string, data: Partial<Task>) =>
    axios.put<Task>(`${baseEndpoint}/${id}`, data),

  delete: (id: string) => axios.delete(`${baseEndpoint}/${id}`),
});
