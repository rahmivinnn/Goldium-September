# 🚀 GOLDIUM Deployment Guide

## Vercel Deployment

### Step 1: Connect GitHub Repository

1. Go to [vercel.com](https://vercel.com) and sign in
2. Click "New Project"
3. Import your GitHub repository: `rahmivinnn/Goldium-September`
4. Vercel will automatically detect it's a Next.js project

### Step 2: Configure Environment Variables

In Vercel dashboard, go to Settings > Environment Variables and add:

#### Required Variables:
```
NEXT_PUBLIC_SOLANA_NETWORK=mainnet-beta
NEXT_PUBLIC_SOLANA_RPC_URL=https://api.mainnet-beta.solana.com
NEXT_PUBLIC_GOLD_TOKEN_MINT=APkBg8kzMBpVKxvgrw67vkd5KuGWqSu2GVb19eK4pump
NEXT_PUBLIC_APP_NAME=GOLDIUM
```

#### Optional Variables:
```
NEXT_PUBLIC_HELIUS_RPC_URL=https://rpc.helius.xyz/?api-key=YOUR_API_KEY
NEXT_PUBLIC_GA_ID=YOUR_GOOGLE_ANALYTICS_ID
NEXT_PUBLIC_ENABLE_FAUCET=true
```

### Step 3: Build Settings

Vercel should automatically detect these settings:
- **Framework Preset**: Next.js
- **Build Command**: `pnpm build`
- **Output Directory**: `.next`
- **Install Command**: `pnpm install`
- **Development Command**: `pnpm dev`

### Step 4: Deploy

1. Click "Deploy"
2. Wait for build to complete (2-3 minutes)
3. Your app will be live at `https://your-project.vercel.app`

## 🔧 Custom Domain Setup

1. In Vercel dashboard, go to Settings > Domains
2. Add your custom domain (e.g., `goldium.io`)
3. Configure DNS records as instructed
4. SSL certificate will be automatically provisioned

## 🌍 Performance Optimizations

### Edge Functions
The app uses Vercel Edge Functions for:
- API routes (`/api/*`)
- Real-time data fetching
- Token price updates

### CDN Configuration
- Static assets are automatically cached
- Images are optimized with Vercel Image Optimization
- Fonts are served from Vercel's edge network

## 📊 Monitoring

### Analytics
- Vercel Analytics automatically tracks performance
- Real User Monitoring (RUM) for wallet connections
- Error tracking for DeFi operations

### Environment-specific Monitoring
- Production: Full monitoring enabled
- Preview: Basic monitoring
- Development: Local debugging only

## 🔒 Security

### Environment Variables
- Never commit `.env.local` to git
- Use Vercel's secure environment variable storage
- Rotate API keys regularly

### Wallet Security
- All wallet operations are client-side only
- No private keys are stored on servers
- All transactions require user approval

## 🚨 Troubleshooting

### Build Failures

1. **TypeScript errors**:
   ```bash
   pnpm add -D typescript@^5.3.3
   ```

2. **Dependency conflicts**:
   ```bash
   rm -rf node_modules pnpm-lock.yaml
   pnpm install
   ```

3. **Memory issues**:
   - Increase Node.js memory limit in `package.json`:
   ```json
   {
     "scripts": {
       "build": "NODE_OPTIONS='--max-old-space-size=4096' next build"
     }
   }
   ```

### Runtime Issues

1. **Wallet connection fails**:
   - Check RPC endpoint health
   - Verify environment variables
   - Test with different wallets

2. **API errors**:
   - Check Vercel function logs
   - Verify CORS headers
   - Test API endpoints individually

## 📈 Scaling

### Database (Future)
- Consider adding Vercel Postgres for user data
- Use Vercel KV for caching
- Implement Redis for real-time features

### CDN
- Use Vercel's global CDN
- Optimize images with `next/image`
- Implement proper caching headers

## 🔄 CI/CD Pipeline

### Automatic Deployments
- Production: Deploys from `master` branch
- Preview: Deploys from feature branches
- Development: Local development only

### Testing
```bash
# Run tests before deployment
pnpm test

# Type checking
pnpm type-check

# Linting
pnpm lint
```

## 📞 Support

If deployment fails:
1. Check Vercel build logs
2. Verify all environment variables
3. Test build locally first
4. Contact support if needed

---

Happy deploying! 🚀