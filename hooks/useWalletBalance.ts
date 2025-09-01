"use client"

import { useState, useEffect, useCallback } from "react"
import { useWallet, useConnection } from "@solana/wallet-adapter-react"
import { PublicKey, LAMPORTS_PER_SOL } from "@solana/web3.js"
import { getAssociatedTokenAddress, getAccount } from "@solana/spl-token"

// GOLD token mint address
const GOLD_MINT_ADDRESS = "APkBg8kzMBpVKxvgrw67vkd5KuGWqSu2GVb19eK4pump"

export function useWalletBalance() {
  const { publicKey, connected } = useWallet()
  const { connection } = useConnection()
  
  const [balances, setBalances] = useState<{ [key: string]: number }>({
    SOL: 0,
    GOLD: 0
  })
  const [solBalance, setSolBalance] = useState<number>(0)
  const [goldBalance, setGoldBalance] = useState<number>(0)
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const fetchBalances = useCallback(async () => {
    if (!publicKey || !connected || !connection) {
      setBalances({ SOL: 0, GOLD: 0 })
      setSolBalance(0)
      setGoldBalance(0)
      return
    }

    setIsLoading(true)
    setError(null)

    try {
      // Fetch SOL balance
      const solBalanceInLamports = await connection.getBalance(publicKey, 'confirmed')
      const solBalance = solBalanceInLamports / LAMPORTS_PER_SOL
      
      // Fetch GOLD balance
      let goldBalance = 0
      try {
        if (GOLD_MINT_ADDRESS && GOLD_MINT_ADDRESS.length >= 32) {
          const goldMint = new PublicKey(GOLD_MINT_ADDRESS)
          const associatedTokenAccount = await getAssociatedTokenAddress(
            goldMint, 
            publicKey,
            false
          )
          
          const accountInfo = await connection.getAccountInfo(associatedTokenAccount, 'confirmed')
          if (accountInfo && accountInfo.data.length > 0) {
            const account = await getAccount(connection, associatedTokenAccount)
            goldBalance = Number(account.amount) / Math.pow(10, 9) // GOLD has 9 decimals
          }
        }
      } catch (goldError) {
        console.warn("Failed to fetch GOLD balance:", goldError)
        goldBalance = 0
      }

      setBalances({ SOL: solBalance, GOLD: goldBalance })
      setSolBalance(solBalance)
      setGoldBalance(goldBalance)
      setIsLoading(false)
    } catch (error: any) {
      console.error("Failed to fetch balances:", error)
      setError(error.message || "Failed to fetch balances")
      setIsLoading(false)
    }
  }, [connection, publicKey, connected])

  const refreshBalances = useCallback(() => {
    fetchBalances()
  }, [fetchBalances])

  const deductBalance = useCallback((tokenSymbol: string, amount: number) => {
    setBalances(prev => ({
      ...prev,
      [tokenSymbol]: Math.max(0, (prev[tokenSymbol] || 0) - amount)
    }))
    
    if (tokenSymbol === 'SOL') {
      setSolBalance(prev => Math.max(0, prev - amount))
    } else if (tokenSymbol === 'GOLD') {
      setGoldBalance(prev => Math.max(0, prev - amount))
    }
  }, [])

  useEffect(() => {
    if (connected && publicKey) {
      fetchBalances()
    } else {
      setBalances({ SOL: 0, GOLD: 0 })
      setSolBalance(0)
      setGoldBalance(0)
    }
  }, [connected, publicKey, fetchBalances])

  return {
    balances,
    solBalance,
    goldBalance,
    isLoading,
    error,
    refreshBalances,
    deductBalance
  }
}

export default useWalletBalance