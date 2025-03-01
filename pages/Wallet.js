import React, { useState, useEffect } from 'react';
import { getBalance } from '../services/walletService';

const Wallet = () => {
  const [balance, setBalance] = useState(0);

  useEffect(() => {
    const fetchBalance = async () => {
      const address = 'user-wallet-address';
      const balance = await getBalance(address);
      setBalance(balance);
    };
    fetchBalance();
  }, []);

  return (
    <div>
      <h1>Wallet</h1>
      <p>Balance: {balance} KRY</p>
    </div>
  );
};

export default Wallet;
