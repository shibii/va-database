import { IDatabase, IMain } from "pg-promise";
import { User } from "../models";
import { users } from "../sql";

export class UsersRepository {
  constructor(private db: IDatabase<any>, private pgp: IMain) {}

  async add(email: string, pwhash: string): Promise<User | null> {
    return this.db.oneOrNone(users.add, { email, pwhash });
  }
  async getByEmail(email: string): Promise<User | null> {
    return this.db.oneOrNone(users.getByEmail, { email });
  }
  async hideVacancy(userId: number, vacancyId: number): Promise<null> {
    return this.db.none(users.hideVacancy, { userId, vacancyId });
  }
  async pinVacancy(userId: number, vacancyId: number): Promise<null> {
    return this.db.none(users.pinVacancy, { userId, vacancyId });
  }
  async unhideVacancy(userId: number, vacancyId: number): Promise<null> {
    return this.db.none(users.unhideVacancy, { userId, vacancyId });
  }
  async unpinVacancy(userId: number, vacancyId: number): Promise<null> {
    return this.db.none(users.unpinVacancy, { userId, vacancyId });
  }
}
