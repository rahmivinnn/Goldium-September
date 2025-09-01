# GOLDIUM - Web3 Gaming & DeFi Universe 🌟

Experience the future of gaming and finance in one unified ecosystem. GOLDIUM combines immersive 3D worlds, thrilling 2D adventures, and real economic opportunities powered by the GOLD token.

## ✨ Features

- 🎮 **Immersive Gaming** - 3D worlds and 2D adventures
- 💰 **DeFi Integration** - Staking, swapping, and liquidity pools
- 🏆 **NFT Marketplace** - Own your in-game assets as NFTs
- 💎 **GOLD Token Economy** - Earn rewards through play-to-earn mechanics
- 🔗 **Multi-Wallet Support** - Phantom, Solflare, Backpack, and more
- 📊 **Real-time Analytics** - Track your portfolio and earnings
- 🌐 **Solana Powered** - Fast, cheap, and eco-friendly transactions

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ 
- pnpm (recommended) or npm
- A Solana wallet (Phantom recommended)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/rahmivinnn/Goldium-September.git
   cd Goldium-September
   ```

2. **Install dependencies**
   ```bash
   pnpm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env.local
   ```

4. **Start development server**
   ```bash
   pnpm dev
   ```

5. **Open your browser**
   Navigate to [http://localhost:3000](http://localhost:3000)

## 🔧 Configuration

### Environment Variables

Create a `.env.local` file with the following variables:

```env
# Solana Network Configuration
NEXT_PUBLIC_SOLANA_NETWORK=mainnet-beta
NEXT_PUBLIC_SOLANA_RPC_URL=https://api.mainnet-beta.solana.com

# Gold Token Configuration
NEXT_PUBLIC_GOLD_TOKEN_MINT=APkBg8kzMBpVKxvgrw67vkd5KuGWqSu2GVb19eK4pump

# Application Configuration
NEXT_PUBLIC_APP_NAME=GOLDIUM
NEXT_PUBLIC_APP_URL=https://goldium.vercel.app
```

### Wallet Support

GOLDIUM supports multiple Solana wallets:
- **Phantom** (Recommended) - [Download](https://phantom.app/)
- **Solflare** - [Download](https://solflare.com/)
- **Backpack** - [Download](https://backpack.app/)
- **Ledger** - Hardware wallet support
- **Torus** - Social login wallet

## 🛠 Development

### Scripts

- `pnpm dev` - Start development server
- `pnpm build` - Build for production
- `pnpm start` - Start production server
- `pnpm lint` - Run ESLint

### Project Structure

```
├── app/                    # Next.js App Router pages
├── components/            # React components
│   ├── providers/        # Context providers
│   ├── ui/              # UI components
│   └── ...              # Feature components
├── hooks/                # Custom React hooks
├── lib/                  # Utility libraries
├── services/             # API services
├── styles/               # CSS styles
├── utils/                # Utility functions
└── constants/            # Application constants
```

## 🌐 Deployment

### Deploy to Vercel

1. **Connect your GitHub repository to Vercel**
   - Go to [vercel.com](https://vercel.com)
   - Import your GitHub repository
   - Vercel will automatically detect Next.js

2. **Configure environment variables in Vercel**
   ```
   NEXT_PUBLIC_SOLANA_NETWORK=mainnet-beta
   NEXT_PUBLIC_SOLANA_RPC_URL=https://api.mainnet-beta.solana.com
   NEXT_PUBLIC_GOLD_TOKEN_MINT=APkBg8kzMBpVKxvgrw67vkd5KuGWqSu2GVb19eK4pump
   ```

3. **Deploy**
   - Click "Deploy" and Vercel will build and deploy your app
   - Your app will be available at `https://your-project.vercel.app`

### Manual Deployment

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel --prod
```

## 🔐 Security

- All wallet connections are client-side only
- Private keys never leave your wallet
- All transactions require user approval
- Smart contract interactions are audited

## 🐛 Troubleshooting

### Wallet Connection Issues

1. **Wallet not detected**
   - Make sure your wallet extension is installed and enabled
   - Refresh the page after installing a wallet
   - Try a different browser (Chrome, Firefox, Brave recommended)

2. **Connection fails**
   - Check if your wallet is unlocked
   - Make sure you're on the correct network (Mainnet)
   - Clear browser cache and try again

3. **Balance not showing**
   - Wait a few seconds for balance to load
   - Click the refresh button
   - Check your internet connection

### Build Issues

1. **TypeScript errors**
   ```bash
   pnpm add -D typescript@^5.3.3
   ```

2. **Dependency conflicts**
   ```bash
   rm -rf node_modules pnpm-lock.yaml
   pnpm install
   ```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- **Website**: [https://goldium.vercel.app](https://goldium.vercel.app)
- **GitHub**: [https://github.com/rahmivinnn/Goldium-September](https://github.com/rahmivinnn/Goldium-September)
- **Documentation**: [Coming Soon]

## 📞 Support

If you have any questions or need help:
- Open an issue on GitHub
- Join our Discord community
- Follow us on Twitter

---

Built with ❤️ on Solana blockchain