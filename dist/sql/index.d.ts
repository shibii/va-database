import { QueryFile } from "pg-promise";
interface IUsers {
    add: QueryFile;
    getByEmail: QueryFile;
    hideVacancy: QueryFile;
    pinVacancy: QueryFile;
    unhideVacancy: QueryFile;
    unpinVacancy: QueryFile;
}
export declare const users: IUsers;
interface IVacancies {
    getFts: QueryFile;
    getHidden: QueryFile;
    getPinned: QueryFile;
    getUnparsedUrls: QueryFile;
}
export declare const vacancies: IVacancies;
export {};
