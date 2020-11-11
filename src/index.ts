import * as pgPromise from "pg-promise";
import { IInitOptions, IDatabase, IMain } from "pg-promise";
import { IExtensions, UsersRepository, VacanciesRepository } from "./repos";

type ExtendedProtocol = IDatabase<IExtensions> & IExtensions;

const initOptions: IInitOptions<IExtensions> = {
  extend(obj: ExtendedProtocol, dc: any) {
    obj.users = new UsersRepository(obj, pgp);
    obj.vacancies = new VacanciesRepository(obj, pgp);
  },
};

const pgp: IMain = pgPromise(initOptions);

// return timestamp as a string instead of a date object
let types = pgp.pg.types;
const re = /\.[^.]*$/;
types.setTypeParser(1114, (str) =>
  //remove postfix
  str.replace(re, "")
);

// Creating the database instance with extensions:
const db: ExtendedProtocol = pgp({
  host: process.env.DB_HOST,
  port: parseInt(<string>process.env.PORT, 10),
  database: process.env.DB_DATABASE,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

export { User, Vacancy } from "./models";
export { db, pgp };
