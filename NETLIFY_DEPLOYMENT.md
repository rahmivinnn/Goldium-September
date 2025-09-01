# 🚀 GOLDIUM Netlify Deployment Guide

## Quick Deployment to Netlify

### Method 1: Netlify Dashboard (Recommended)

1. **Go to [netlify.com](https://netlify.com)**
2. **Sign in** with your GitHub account
3. **Click "New site from Git"**
4. **Choose GitHub** and authorize Netlify
5. **Select repository**: `rahmivinnn/Goldium-September`
6. **Configure build settings**:
   - **Build command**: `pnpm netlify-build`
   - **Publish directory**: `out`
   - **Node version**: `18`

### Method 2: Netlify CLI

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login to Netlify
netlify login

# Deploy from project root
netlify deploy --prod --dir=out
```

### Method 3: Drag & Drop

```bash
# Build the project locally
pnpm build

# Go to netlify.com/drop
# Drag the 'out' folder to deploy
```

## 🔧 Environment Variables

Add these in Netlify Dashboard → Site Settings → Environment Variables:

### Required Variables:
```
NEXT_PUBLIC_SOLANA_NETWORK=mainnet-beta
NEXT_PUBLIC_SOLANA_RPC_URL=https://api.mainnet-beta.solana.com
NEXT_PUBLIC_GOLD_TOKEN_MINT=APkBg8kzMBpVKxvgrw67vkd5KuGWqSu2GVb19eK4pump
NEXT_PUBLIC_APP_NAME=GOLDIUM
```

### Optional Variables:
```
NEXT_PUBLIC_HELIUS_RPC_URL=https://rpc.helius.xyz/?api-key=YOUR_API_KEY
NEXT_PUBLIC_GA_ID=YOUR_GOOGLE_ANALYTICS_ID
NEXT_PUBLIC_ENABLE_FAUCET=true
NEXT_PUBLIC_APP_URL=https://goldium.netlify.app
```

## 📁 Build Configuration

The project is configured with:

### netlify.toml Features:
- ✅ **Static Export**: Next.js static export for better performance
- ✅ **Environment Variables**: Automatic environment setup
- ✅ **CORS Headers**: Proper API headers for wallet connections
- ✅ **Security Headers**: XSS protection, content security
- ✅ **Caching**: Optimized caching for static assets
- ✅ **Redirects**: SPA routing support

### Build Process:
1. `pnpm install` - Install dependencies
2. `pnpm build` - Build Next.js application
3. Static files exported to `out/` directory
4. Netlify serves from `out/` directory

## 🌐 Custom Domain

### Setup Custom Domain:
1. **In Netlify Dashboard**: Site Settings → Domain Management
2. **Add custom domain**: `goldium.io` (or your domain)
3. **Configure DNS**: Point your domain to Netlify
4. **SSL Certificate**: Automatically provisioned by Netlify

### DNS Configuration:
```
Type: CNAME
Name: www
Value: your-site-name.netlify.app

Type: A
Name: @
Value: 75.2.60.5
```

## 🔄 Automatic Deployments

### Branch Deployments:
- **Production**: `master` branch → `https://goldium.netlify.app`
- **Preview**: Feature branches → `https://deploy-preview-123--goldium.netlify.app`
- **Development**: Local development only

### Deploy Hooks:
```bash
# Trigger deploy via webhook
curl -X POST -d '{}' https://api.netlify.com/build_hooks/YOUR_HOOK_ID
```

## 🛠 Troubleshooting

### Build Errors

1. **Memory Issues**:
   ```bash
   # In netlify.toml, add:
   [build.environment]
   NODE_OPTIONS = "--max-old-space-size=4096"
   ```

2. **Dependency Issues**:
   ```bash
   # Clear cache and reinstall
   rm -rf node_modules .next out pnpm-lock.yaml
   pnpm install
   ```

3. **Wallet Adapter Issues**:
   - Make sure all wallet adapters are properly imported
   - Check browser console for errors
   - Verify RPC endpoints are accessible

### Runtime Issues

1. **Wallet Connection Fails**:
   - Check environment variables in Netlify
   - Verify RPC URL is accessible
   - Test with different wallets

2. **Static Export Issues**:
   - Remove dynamic API routes if any
   - Use client-side data fetching
   - Check for server-side code in components

## 📊 Performance Optimization

### Netlify Features:
- **Edge Functions**: For API routes
- **Image Optimization**: Automatic image compression
- **CDN**: Global content delivery network
- **Prerendering**: Static page generation

### Bundle Optimization:
```javascript
// next.config.mjs
experimental: {
  optimizePackageImports: ['@solana/wallet-adapter-react']
}
```

## 🔐 Security

### Headers Configuration:
- ✅ **CORS**: Properly configured for wallet connections
- ✅ **CSP**: Content Security Policy
- ✅ **HSTS**: HTTP Strict Transport Security
- ✅ **XSS Protection**: Cross-site scripting prevention

### Environment Security:
- ✅ All sensitive data in environment variables
- ✅ No API keys in client-side code
- ✅ Secure wallet connection handling

## 📈 Monitoring

### Netlify Analytics:
- Page views and performance metrics
- Error tracking and debugging
- Real User Monitoring (RUM)

### Custom Monitoring:
```javascript
// Add to your components
useEffect(() => {
  // Track wallet connections
  if (connected) {
    netlify.track('wallet_connected', { wallet: wallet.name });
  }
}, [connected]);
```

## 🔗 Useful Commands

```bash
# Local development
pnpm dev

# Build for production
pnpm build

# Test static export
pnpm export && npx serve out

# Deploy to Netlify
netlify deploy --prod --dir=out

# Check build logs
netlify logs

# Open site in browser
netlify open
```

## 📞 Support

- **Netlify Docs**: [docs.netlify.com](https://docs.netlify.com)
- **Next.js Docs**: [nextjs.org/docs](https://nextjs.org/docs)
- **Solana Docs**: [docs.solana.com](https://docs.solana.com)

---

Ready to deploy! 🚀