import { UsersRepository } from "./users";
import { VacanciesRepository } from "./vacancies";

// Database Interface Extensions:
interface IExtensions {
  users: UsersRepository;
  vacancies: VacanciesRepository;
}

export { IExtensions, UsersRepository, VacanciesRepository };
