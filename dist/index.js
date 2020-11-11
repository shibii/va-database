"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.pgp = exports.db = void 0;
var pgPromise = require("pg-promise");
var repos_1 = require("./repos");
var initOptions = {
    extend: function (obj, dc) {
        obj.users = new repos_1.UsersRepository(obj, pgp);
        obj.vacancies = new repos_1.VacanciesRepository(obj, pgp);
    },
};
var pgp = pgPromise(initOptions);
exports.pgp = pgp;
// return timestamp as a string instead of a date object
var types = pgp.pg.types;
var re = /\.[^.]*$/;
types.setTypeParser(1114, function (str) {
    //remove postfix
    return str.replace(re, "");
});
// Creating the database instance with extensions:
var db = pgp({
    host: process.env.DB_HOST,
    port: parseInt(process.env.PORT, 10),
    database: process.env.DB_DATABASE,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
});
exports.db = db;
//# sourceMappingURL=index.js.map