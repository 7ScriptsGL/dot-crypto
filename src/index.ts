import chalk from 'chalk'
import yargs = require('yargs')
const pkg = require('../package.json')

const cli = yargs
  .scriptName(pkg.name)
  .usage('$0 <cmd> [args]')
  .demandCommand()
  .middleware(argv => {
    if (process.env.NODE_ENV === 'development') argv.verbose = true
    if (argv.verbose) {
      console.info()
      Object.keys(argv).forEach(k => {
        console.info(k.charAt(0).toUpperCase() + k.slice(1) + ':', argv[k])
      })
      console.info()
    }
  })
  .epilog('Made with ' + chalk.red('♥') + ' by Unstoppable Domains')
  .option('verbose', {
    type: 'boolean',
    alias: 'v',
    description: 'Use verbose logging',
  })
  .version()
  .help()
  .alias('help', 'h')
  .fail((msg, err) => {
    if (err || !msg) {
      console.error('Error:', err.message || 'unknown')
    } else if (msg.startsWith('Not enough non-option arguments:')) {
      cli.showHelp()
      console.error()
      console.error(msg)
    } else if (msg.startsWith('Missing required arguments:')) {
      cli.showHelp()
      console.error()
      console.error(msg)
    } else {
      console.error(msg)
    }
    process.exit(1)
  })
  // .showHelpOnFail(true)
  .commandDir('cmd')

cli.argv
