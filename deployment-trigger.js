// Deployment Trigger - Latest Egg Character Version
const DEPLOYMENT_INFO = {
  timestamp: Date.now(),
  version: 'latest-egg-characters-splashscreen',
  commit: process.env.VERCEL_GIT_COMMIT_SHA || 'latest',
  features: [
    'SplashScreen with K2, K4, K6, K3, K1 characters',
    'EggNFTCard interactive system',
    'EggNFTGallery magical collection', 
    'Animated egg interactions',
    'Temperature and mood systems',
    'Sparkle effects for rare eggs',
    'Pet level system'
  ],
  target_url: 'https://goldium-september.vercel.app/',
  force_deploy: true
};

if (typeof window !== 'undefined') {
  console.log('🥚 GOLDIUM - Latest Egg Character Version Deployed!', DEPLOYMENT_INFO);
}

module.exports = DEPLOYMENT_INFO;