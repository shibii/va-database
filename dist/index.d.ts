import { IDatabase, IMain } from "pg-promise";
import { IExtensions } from "./repos";
declare type ExtendedProtocol = IDatabase<IExtensions> & IExtensions;
declare const pgp: IMain;
declare const db: ExtendedProtocol;
export { db, pgp };
