const express = require('express');
const router = express.Router();
const WalletController = require('../controllers/walletController');

router.post('/create', WalletController.createWallet);
router.get('/balance/:address', WalletController.getBalance);

module.exports = router;
