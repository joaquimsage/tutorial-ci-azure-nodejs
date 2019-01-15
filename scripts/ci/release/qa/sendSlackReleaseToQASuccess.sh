#!/usr/bin/env bash
curl -X POST -H 'Content-type: application/json' --data '{
  "attachments": [
    {
      "fields": [
        {
          "title": "DASHBOARD: RELEASE TO QA & DEPLOYMENT TO QA READY",
          "value": "The new release to QA has been deployed to AZURE QA. Please double check the TAGS on the Github repository: https://github.com/SageNADev/bot_analytic_dashboard/releases"
        }
      ],
      "image_url": "https://media.giphy.com/media/rriYfsQZRE9Pi/giphy.gif",
      "channel": "#pegg-ci-meerkat",
      "username": "CI Auto-process"
    }
  ]
}' https://hooks.slack.com/services/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