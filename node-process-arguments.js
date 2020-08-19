/**
 * The follow provides simplified argument handing. It is not a full getopt parser.
 * A more complete/intuitive solution use: npmjs's minimist
 *
 * $ node ./scratch.js -a -bc --def --fred=george non-option
 *   { a: true, b: true, c: true, def: true, fred: 'george' }
 */
const longArgs = arg => {
    const [ key, value ] = arg.split('=');
    return { [key.slice(2)]: value || true }
};

const flags = arg => [...arg.slice(1)].reduce((flagObj, f) => ({ ...flagObj, [f]: true }), {});

const args = () =>
    process.argv
        .slice(2)
        .reduce((args, arg) => ({
            ...args,
            ...((arg.startsWith('--') && longArgs(arg)) || (arg[0] === '-' && flags(arg)))
        }), {});

console.log(args());

function dumpEnvVars() {
    console.log('Process env: ' + Object.keys(process.env).sort().map((k) =>
        `${k}:  ${process.env[k]}`).join('\n'));
}
