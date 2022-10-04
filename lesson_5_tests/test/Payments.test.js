const { expect } = require("chai")
const { ethers } = require("hardhat")

describe("Payments", function(){
    let acc1
    let acc2
    let payments

    beforeEach(async function(){ // перед каждым тестом разворачиваем свежий контракт
        [acc1, acc2] = await ethers.getSigners() // получаем тестовые акки
        console.log(`Account 1 address: ${acc1.address}`)
        console.log(`Account 2 address: ${acc2.address}`)

        const Payments = await ethers.getContractFactory("Payments", acc1) // контракт Payments разворачиваем от имени acc1
        payments = await Payments.deploy() // разворачиваем контракт (отправляем транзакцию)
        await payments.deployed()  // разворачиваем контракт (ждем выполнения транзакции)
        console.log(`Smart contract address: ${payments.address}`) // узнаем по какому адресу развернут контракт
    })

    it("TEST 1: should be deployed", async function() {
        expect(payments.address).to.be.properAddress
    })

    it("TEST 2: should have 0 ether by default", async function(){
        const balance = await payments.currentBalance()
        expect(balance).to.eq(0)
    })

    it("TEST 3: should be possible to send funds", async function () {
        const msg = "Hello from account 2"
        const amount = 100; // сумма оплаты в wei
        const tx = await payments.connect(acc2).pay(msg, { value: amount }) // производим оплату
        await expect(() => tx) // проверяем списание и начисление денег
            .to.changeEtherBalances([acc2, payments],  [-amount, amount])

        // проверка реализованного журнала транзакций
        const newPayment = await payments.getPayment(acc2.address, 0)
        expect(newPayment.message).to.eq(msg)
        expect(newPayment.amount).to.eq(amount)
        expect(newPayment.from).to.eq(acc2.address)
    });
})