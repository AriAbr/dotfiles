const exec = require("child_process").execSync

exports.passGet = (name) => {
    try {
        return exec(`pass ${name}`).toString().replace("\n", "")
    } catch {
        return process.env[name.replaceAll(" ", "_").toUpperCase()]
    }
};
exports.passStore = (name, value) => exec(`echo "${value}" | pass insert --echo ${name}`)
