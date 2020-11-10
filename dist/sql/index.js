"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.vacancies = exports.users = void 0;
var pg_promise_1 = require("pg-promise");
var path = require("path");
exports.users = pg_promise_1.utils.enumSql(path.join(__dirname, "sql", "users"), { recursive: true }, function (file) {
    return new pg_promise_1.QueryFile(file, { minify: true });
});
exports.vacancies = pg_promise_1.utils.enumSql(path.join(__dirname, "sql", "vacancies"), { recursive: true }, function (file) {
    return new pg_promise_1.QueryFile(file, { minify: true });
});
//# sourceMappingURL=index.js.map