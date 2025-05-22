"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
//import type { Config } from '@jest/types';
const node_child_process_1 = require("node:child_process");
const dotenv_1 = __importDefault(require("dotenv"));
const jest_environment_node_1 = __importDefault(require("jest-environment-node"));
const pg_1 = require("pg");
const node_util_1 = __importDefault(require("node:util"));
const node_crypto_1 = __importDefault(require("node:crypto"));
dotenv_1.default.config({ path: '.env.test' });
const execSync = node_util_1.default.promisify(node_child_process_1.exec);
//const prismaBinary = './node_modules/.bin/prisma';
class PrismaTestEnvironment extends jest_environment_node_1.default {
    constructor(config, context) {
        super(config, context);
        const dbUser = process.env.DATABASE_USER;
        const dbPass = process.env.DATABASE_PASS;
        const dbHost = process.env.DATABASE_HOST;
        const dbPort = process.env.DATABASE_PORT;
        const dbName = process.env.DATABASE_NAME;
        this.schema = `test_${node_crypto_1.default.randomUUID()}`;
        this.connectionString = `postgresql://${dbUser}:${dbPass}@${dbHost}:${dbPort}/${dbName}?schema=${this.schema}`;
    }
    setup() {
        const _super = Object.create(null, {
            setup: { get: () => super.setup }
        });
        return __awaiter(this, void 0, void 0, function* () {
            process.env.DATABASE_URL = this.connectionString;
            this.global.process.env.DATABASE_URL = this.connectionString;
            yield execSync(`npx prisma migrate deploy`);
            return _super.setup.call(this);
        });
    }
    teardown() {
        return __awaiter(this, void 0, void 0, function* () {
            const client = new pg_1.Client({
                connectionString: this.connectionString,
            });
            yield client.connect();
            yield client.query(`DROP SCHEMA IF EXISTS "${this.schema}" CASCADE`);
            yield client.end();
        });
    }
}
exports.default = PrismaTestEnvironment;
