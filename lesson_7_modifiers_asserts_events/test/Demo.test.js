const { expect } = require("chai")
const { ethers } = require("hardhat")

describe("Demo", function(){
    let owner
    let another_acc
    let demo

    beforeEach(async function(){
        [owner, another_acc] = await ethers.getSigners()
        console.log(`Owner address: ${owner.address}`)
        console.log(`Another acc address: ${another_acc.address}`)

        const DemoContract = await ethers.getContractFactory("Demo", owner)
        demo = await DemoContract.deploy()
        await demo.deployed()
        console.log(`Smart contract address: ${demo.address}`)
    })

    async function sendMoney(sender, amount) {
        const txData = {
            to: demo.address,
            value: amount
        }
        const tx = await sender.sendTransaction(txData)
        tx.wait()

        return tx
    }

    it("TEST 1: should allow to send money", async function() {
        const amount = 200;
        const sendMoneyTx = await sendMoney(another_acc, amount)

        await expect(() => sendMoneyTx).to.changeEtherBalance(demo, amount)

        // проверка вызова события Paid которое мы написали в контракте
        const timestamp = (await ethers.provider.getBlock(sendMoneyTx.blockNumber)).timestamp
        await expect(sendMoneyTx).to.emit(demo, "Paid").withArgs(another_acc.address, amount, timestamp)
    })

    it("TEST 2: owner can withdraw funds", async function() {
        const amount = 700000000;
        await sendMoney(another_acc, amount)
        const tx = await demo.withdraw(owner.address)
        await expect(tx).to.changeEtherBalances([demo, owner], [-amount, amount])
    })

    it("TEST 3: not owner accounts can`t withdraw funds", async function() {
        const amount = 60000;
        const errorMsg = "You are not an owner";
        await sendMoney(another_acc, amount)

        await expect(demo.connect(another_acc).withdraw(another_acc.address))
            .to.be.revertedWith(errorMsg)

        await expect(demo.connect(another_acc).withdraw2(another_acc.address))
            .to.be.revertedWith(errorMsg)

        await expect(demo.connect(another_acc).withdraw3(another_acc.address))
            .to.be.rejected // тут реджектед, т.к. у нас используется ассерт в методе withdraw3

        await expect(demo.connect(another_acc).withdraw4(another_acc.address))
            .to.be.revertedWith(errorMsg)

        await expect(demo.connect(another_acc).withdraw5(another_acc.address))
            .to.be.revertedWith(errorMsg)
    })
})