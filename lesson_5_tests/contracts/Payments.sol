// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Payments {
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function currentBalance() public view returns(uint) {
        return address(this).balance;
    }

    // получение платежа по адресу и номеру платежа
    function getPayment(address _addr, uint _index) public view returns(Payment memory){
        return balances[_addr].payments[_index];
    }

    // логгируем платежи
    function pay(string memory message) public payable {
        uint paymentNum = balances[msg.sender].totalPayments; // сохраняем номер последнего платежа
        balances[msg.sender].totalPayments++; // увеличиваем счетчик платежей

        // создаем объект платежа
        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[paymentNum] = newPayment; // сохраняем платёж под ключем paymentNum
    }
}
