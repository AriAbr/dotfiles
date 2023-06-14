const exec = require("child_process").execSync

exports.passGet = (name) => exec(`pass ${name}`).toString().replace("\n", "") || process.ENV[name.replaceAll(" ", "_").toUpperCase()]
exports.passStore = (name, value) => exec(`echo "${value}" | pass insert --echo ${name}`)
