#!/bin/bash
# ARCHON Deploy Bridge - Trigger Script
# Usage: ./trigger-deploy.sh [triggered_by] [description]

GITHUB_TOKEN="${GITHUB_TOKEN:-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}"
REPO="selfarchitectai-design/archon-deploy-bridge"
WORKFLOW="vercel-deploy.yml"

TRIGGERED_BY="${1:-manual}"
DESCRIPTION="${2:-Auto deploy via ARCHON Bridge}"
DEPLOY_TARGET="${3:-production}"

echo "🚀 ARCHON Deploy Bridge"
echo "========================"
echo "Triggered by: $TRIGGERED_BY"
echo "Target: $DEPLOY_TARGET"
echo "Description: $DESCRIPTION"
echo ""

# Trigger the workflow
RESPONSE=$(curl -s -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/$REPO/actions/workflows/$WORKFLOW/dispatches" \
  -d "{
    \"ref\": \"main\",
    \"inputs\": {
      \"deploy_target\": \"$DEPLOY_TARGET\",
      \"triggered_by\": \"$TRIGGERED_BY\",
      \"description\": \"$DESCRIPTION\"
    }
  }" -w "%{http_code}" -o /dev/null)

if [ "$RESPONSE" = "204" ]; then
  echo "✅ Deploy triggered successfully!"
  echo ""
  echo "📊 Check status at:"
  echo "https://github.com/$REPO/actions"
else
  echo "❌ Deploy trigger failed (HTTP $RESPONSE)"
  exit 1
fi
