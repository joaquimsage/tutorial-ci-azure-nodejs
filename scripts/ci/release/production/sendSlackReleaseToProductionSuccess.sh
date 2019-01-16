#!/usr/bin/env bash
newVersion=` git describe --abbrev=0 `
newLastTagBranch=version/${newVersion}

curl -X POST -H 'Content-type: application/json' --data '{
  "attachments": [
    {
      "fields": [
        {
          "title": "PEGG DASHBOARD: NEW VERSION '"${newVersion}"' TO PRODUCTION READY TO BE DELIVERED",
          "value": "The new branch version '"${newLastTagBranch}"' to PRODUCTION is ready. Please double check the TAGS on the Github repository: https://github.com/SageNADev/bot_analytic_dashboard/releases"
        }
      ],
      "image_url": "https://media.giphy.com/media/d7tPUm40v0ICI/giphy.gif",
      "channel": "#pegg-ci-meerkat",
      "username": "CI Auto-process"
    }
  ]
}' https://hooks.slack.com/services/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