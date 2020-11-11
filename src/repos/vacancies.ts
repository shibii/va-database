import { IDatabase, IMain, ColumnSet } from "pg-promise";
import { Vacancy } from "../models";
import { vacancies } from "../sql";

export class VacanciesRepository {
  insertcs: ColumnSet<any>;
  constructor(private db: IDatabase<any>, private pgp: IMain) {
    this.insertcs = new pgp.helpers.ColumnSet(
      ["url", "header", "contents", "source"],
      {
        table: "vacancies",
      }
    );
  }

  async getFts(
    terms: string,
    userId: number,
    offsetId: number | undefined,
    limit: number | undefined
  ): Promise<Vacancy[]> {
    const offsetClause = offsetId
      ? this.pgp.as.format("id < $<offsetId> AND", { offsetId })
      : "";

    const limitClause = limit
      ? this.pgp.as.format("LIMIT $<limit>", { limit })
      : "";

    return this.db.any(vacancies.getFts, {
      terms,
      userId,
      offsetClause,
      limitClause,
    });
  }
  async getHidden(
    userId: number,
    offsetId: number | undefined,
    limit: number | undefined
  ): Promise<Vacancy[]> {
    const offsetClause = offsetId
      ? this.pgp.as.format("vacancy_id < $<offsetId> AND", { offsetId })
      : "";

    const limitClause = limit
      ? this.pgp.as.format("LIMIT $<limit>", { limit })
      : "";

    return this.db.any(vacancies.getHidden, {
      userId,
      offsetClause,
      limitClause,
    });
  }
  async getPinned(
    userId: number,
    offsetId: number | undefined,
    limit: number | undefined
  ): Promise<Vacancy[]> {
    const offsetClause = offsetId
      ? this.pgp.as.format("vacancy_id < $<offsetId> AND", { offsetId })
      : "";

    const limitClause = limit
      ? this.pgp.as.format("LIMIT $<limit>", { limit })
      : "";

    return this.db.any(vacancies.getPinned, {
      userId,
      offsetClause,
      limitClause,
    });
  }
  async insert(
    entries: Array<{
      url: string;
      header: string;
      contents: string;
      source: string;
    }>
  ): Promise<null> {
    const query =
      this.pgp.helpers.insert(entries, this.insertcs) +
      " ON CONFLICT DO NOTHING";
    return this.db.none(query);
  }
  async getUnparsedUrls(urls: Array<string>): Promise<Array<string>> {
    let keyed: Array<{ url: string }> = urls.map((url) => ({ url: url }));
    const qvalues = this.pgp.helpers.values(keyed, ["url"]);
    return this.db
      .any(vacancies.getUnparsedUrls, qvalues)
      .then((unparsed) => unparsed.map((url) => url.url));
  }
}
