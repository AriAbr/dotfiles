#!/usr/bin/env node

const { jiraApiAutoPage } = require("./lib/jira_utils");

const printIssuesInCurrentSprint = (issues) =>
    issues.map((issue) =>
        console.log(
            `${issue.fields.assignee && issue.fields.assignee.displayName}, ${issue.key}, ${issue.fields.customfield_10024}, ${issue.fields.summary}, ${issue.fields.status.name},${issue.fields.status.statusCategory.name}`
        )
    );

jiraApiAutoPage(
    'sprint in openSprints() and project = "Dynamics Development"',
    printIssuesInCurrentSprint
);
