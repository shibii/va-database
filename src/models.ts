export interface User {
  id: number;
  email: string;
  pwhash: string;
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
