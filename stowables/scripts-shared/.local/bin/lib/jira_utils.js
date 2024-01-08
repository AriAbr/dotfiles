const { passGet } = require("./pass");
const axios = require("axios");
const { exit } = require("process");

exports.BASE_URL = "https://centers.atlassian.net/rest/api/2/search";
exports.TIKVA = "557058:72872a8c-d400-431d-834f-64988a6171a9";
exports.API_KEY = passGet("jira_api_token");
exports.API_USER = passGet("jira_api_user");

const axiosConfig = (jql, fields, overrides = {}) => ({
  method: "POST",
  url: exports.BASE_URL,
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
  },
  auth: {
    username: exports.API_USER,
    password: exports.API_KEY,
  },
  data: {
    jql: jql,
    fields: fields || [
      "summary",
      "key",
      "customfield_10024",
      "customfield_10020",
      "assignee",
      "components",
      "created",
      "updated",
      "project",
      "status",
    ],
    ...overrides,
  },
});

exports.jiraApi = async (jql, callback, fields) =>
  axios(axiosConfig(jql, fields)).then(callback);

exports.jiraApiAutoPage = async (jql, callback, fields) => {
  const areWeDone = (results) => {
    if (results && results.data) {
      const { maxResults, startAt, total } = results.data;
      return startAt + maxResults > total;
    }
    return false;
  };

  let results;
  let issues = [];
  let startAt = 0;
  let total = "start";

  while (!areWeDone(results)) {
    // console.log(`Calling: StartAt(${startAt}), Total(${total})`);
    results = await axios(
      axiosConfig(jql, fields, {
        startAt: startAt,
      }),
    );
    total = results.data.total;
    startAt = results.data.startAt + results.data.maxResults;
    // if (startAt >= results.data.total) break;
    issues = [...issues, ...results.data.issues];
  }
  callback(issues);
};

exports.getLastSprintName = (sprints) => {
  const sprintField = (typeof sprints !== "undefined" && sprints) || [];
  const sorted = sprintField.sort((x, y) => {
    // console.log(x, y);
    const [xYear, xSprint] = x.name.split(".").map((i) => parseInt(i));
    const [yYear, ySprint] = y.name.split(".").map((i) => parseInt(i));
    if (xYear < yYear) {
      return -1;
    }
    if (xYear > yYear) {
      return 1;
    }
    if (xYear === yYear) {
      if (xSprint < ySprint) {
        return -1;
      }
      if (xSprint > ySprint) {
        return 1;
      }
    }
    return 0;
  });
  ret = (sorted.length && sorted[sorted.length - 1]) || { name: "Backlog" };
  // console.log(`sorted: ${JSON.stringify(sorted)}, ret: ${ret.name}`);
  return ret.name;
};
