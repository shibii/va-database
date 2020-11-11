import { UsersRepository } from "./users";
import { VacanciesRepository } from "./vacancies";
interface IExtensions {
    users: UsersRepository;
    vacancies: VacanciesRepository;
}
export { IExtensions, UsersRepository, VacanciesRepository };
