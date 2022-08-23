import * as fs from 'fs';
import { join } from 'path';

const CWD = process.cwd();
const SRC = join(CWD, 'src');

function walk(dir: string, list?: string[]) {
    const files = fs.readdirSync(dir);

    list = list ?? [];

    files.forEach(file => {
        if (fs.statSync(join(dir, file)).isDirectory()) {
            list = walk(join(dir, file), list);
        } else {
            if (getFileName(file).includes('Ingestor') && getFileExtension(file) === 'ts') {
                const newName = file.replace('Ingestor', 'Connection');
                fs.rename(join(dir, file), join(dir, newName), err => {
                    err ? console.error(err) : null;
                });
                join(dir, newName);
            }
        }
    });
    return list;
}

function getFileName(file: string): string {
    const split = file.split('.');
    return split[0];
}

function getFileExtension(file: string): string {
    const split = file.split('.');
    return split[split.length - 1];
}

function main() {
    try {
        walk(SRC);
    } catch (e) {
        console.error(e);
    }
}

main();
