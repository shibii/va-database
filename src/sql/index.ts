import { utils, QueryFile } from "pg-promise";
import * as path from "path";

interface IUsers {
  add: QueryFile;
  getByEmail: QueryFile;
  hideVacancy: QueryFile;
  pinVacancy: QueryFile;
  unhideVacancy: QueryFile;
  unpinVacancy: QueryFile;
}

export const users: IUsers = utils.enumSql(
  path.join(__dirname, "sql", "users"),
  { recursive: true },
  (file) => {
    return new QueryFile(file, { minify: true });
  }
);

interface IVacancies {
  getFts: QueryFile;
  getHidden: QueryFile;
  getPinned: QueryFile;
  getUnparsedUrls: QueryFile;
}

export const vacancies: IVacancies = utils.enumSql(
  path.join(__dirname, "sql", "vacancies"),
  { recursive: true },
  (file) => {
    return new QueryFile(file, { minify: true });
  }
);
