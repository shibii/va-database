import { IDatabase, IMain } from "pg-promise";
import { User } from "../models";
export declare class UsersRepository {
    private db;
    private pgp;
    constructor(db: IDatabase<any>, pgp: IMain);
    add(email: string, pwhash: string): Promise<User | null>;
    getByEmail(email: string): Promise<User | null>;
    hideVacancy(userId: number, vacancyId: number): Promise<null>;
    pinVacancy(userId: number, vacancyId: number): Promise<null>;
    unhideVacancy(userId: number, vacancyId: number): Promise<null>;
    unpinVacancy(userId: number, vacancyId: number): Promise<null>;
}
