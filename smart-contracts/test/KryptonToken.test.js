const KryptonToken = artifacts.require("KryptonToken");

contract("KryptonToken", accounts => {
  it("should put 10000 KryptonToken in the first account", async () => {
    const instance = await KryptonToken.deployed();
    const balance = await instance.balanceOf(accounts[0]);
    assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
  });
});
