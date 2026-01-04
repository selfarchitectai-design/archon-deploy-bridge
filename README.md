# 🚀 ARCHON Deploy Bridge

Automated deployment pipeline connecting **GPT-5**, **GitHub Actions**, and **Vercel**.

## 🏗️ Architecture

```
GPT-5 / Claude
      │
      │ workflow_dispatch API call
      ▼
GitHub Actions
      │
      │ Checkout → Build → Deploy
      ▼
Vercel (Production)
      │
      ▼
ARCHON Dashboard
```

## 🔧 Setup

### 1. GitHub Secrets Required

Go to **Settings → Secrets → Actions** and add:

| Secret | Description |
|--------|-------------|
| `VERCEL_TOKEN` | Vercel API token |
| `VERCEL_ORG_ID` | Vercel team/org ID |
| `VERCEL_PROJECT_ID` | Vercel project ID |
| `GH_PAT` | GitHub Personal Access Token (for cross-repo access) |

### 2. Vercel Credentials

```
VERCEL_TOKEN: yYAXPpzetqNFiQvXYzyxdf6N
VERCEL_ORG_ID: team_1ObevaGr4rOEodjKXBbPrsLN
VERCEL_PROJECT_ID: prj_OguVxu6oPwGbcIwwEtYq6JkSNj2s
```

## 🚀 Trigger Deploy

### Via GPT-5 / Claude (API)

```bash
curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <GITHUB_TOKEN>" \
  https://api.github.com/repos/selfarchitectai-design/archon-deploy-bridge/actions/workflows/vercel-deploy.yml/dispatches \
  -d '{
    "ref": "main",
    "inputs": {
      "deploy_target": "production",
      "triggered_by": "GPT-5",
      "description": "Auto deploy via ARCHON"
    }
  }'
```

### Via GitHub UI

1. Go to **Actions** tab
2. Select **ARCHON Auto Deploy**
3. Click **Run workflow**
4. Fill in parameters
5. Click **Run**

## 📊 Workflow Events

| Event | Trigger |
|-------|---------|
| `push` | Any push to `main` branch |
| `workflow_dispatch` | Manual or API trigger |
| `repository_dispatch` | External webhook (`deploy-archon` type) |

## 🔗 Integration Points

- **Source Repo**: `selfarchitectai-design/archon-frontend`
- **Deploy Target**: https://dashboard.selfarchitectai.com
- **Status API**: https://www.selfarchitectai.com/api/archon/trust

## 📋 Deploy Report

Each deploy generates a summary with:
- Deploy status
- Trigger source
- Deploy URL
- Timestamp

## 🛡️ Security

- Uses GitHub Secrets for credentials
- PAT has minimal required scopes
- Vercel token is project-scoped
- Deploy logs sent to ARCHON for audit

## 📞 Support

- GitHub: https://github.com/selfarchitectai-design/archon-frontend
- Dashboard: https://dashboard.selfarchitectai.com

---

*ARCHON Deploy Bridge v1.0*
*Last Updated: 2026-01-04*
