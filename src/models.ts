export interface User {
  userId: number;
  email: string;
}

export interface Vacancy {
  id: number;
  url: string;
  header: string;
  source: string;
  ts: string;
  pinned: boolean;
  hidden: boolean;
}
