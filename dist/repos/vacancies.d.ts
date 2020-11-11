import { IDatabase, IMain, ColumnSet } from "pg-promise";
import { Vacancy } from "../models";
export declare class VacanciesRepository {
    private db;
    private pgp;
    insertcs: ColumnSet<any>;
    constructor(db: IDatabase<any>, pgp: IMain);
    getFts(terms: string, userId: number, offsetId: number | undefined, limit: number | undefined): Promise<Vacancy[]>;
    getHidden(userId: number, offsetId: number | undefined, limit: number | undefined): Promise<Vacancy[]>;
    getPinned(userId: number, offsetId: number | undefined, limit: number | undefined): Promise<Vacancy[]>;
    insert(entries: Array<{
        url: string;
        header: string;
        contents: string;
        source: string;
    }>): Promise<null>;
    getUnparsedUrls(urls: Array<string>): Promise<Array<string>>;
}
