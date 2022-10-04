// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Shop {
    address public owner;  // адрес владельца контракта
    mapping(address => uint) public payments; // в данном мэппинге будем хранить журнал платежей

    constructor() {
        // msg это объект транзакции
        owner = msg.sender; // тот кто развернул контракт тот и владелец
    }

    function payForItem() public payable { // если функция не помечена как payable, то она не будет принимать деньги
//      В принципе можно больше не писать ничего в методе
//      т.к. деньги поступят на счет смарт-контракта из-за метки payable
//      Но мы можем навесить дополнительную логику если того пожелаем
//      Например, ведение журнала платежей
        payments[msg.sender] = msg.value; // под ключ msg.sender мы положим денежную сумму msg.value
    }

    function withdrawAll() public {
        address payable _toOwner = payable(owner); // чтобы вывести деньги на адрес владельца, нужно сделать его payable
        address _thisContract = address(this); // узнаем адрес баланса контракта
        _toOwner.transfer(_thisContract.balance); // переводим деньги с контракта на счет владельца
    }
}