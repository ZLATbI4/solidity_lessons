// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo{
     // Строки
    string public myStr = "test"; // storage, чем больше данных -> тем больше плата за газ

    function demo(string memory newValueStr) public {
        string memory myTempStr = "temp"; // memory метка говорит о том, что значение строки не помещаем в блокчейн, а храним в памяти, пока работает функция demo
        myStr = newValueStr; // перезапишем storage строку
    }


    // Адреса
    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; 

    // получение баланса myAddr
    function getMyBalance() public view returns(uint){
        return myAddr.balance;
    }

    // получение баланса любого другого адреса
    function getBalance(address targetAddr) public view returns(uint){
        return targetAddr.balance;
    }

    // функция перевода денег с баланса смарт-контракта на чей-то адрес
    function transferTo(address payable targetAddr, uint amount) public{
        targetAddr.transfer(amount);
    }


   // Мэппинг
   mapping (address => uint) public payments; // ключем тут выступает адрес, а значением число uint (допустим кол-во денег переведенных)

   // функция пополнения баланса смарт-контракта
    function recieveFounds() public payable {
        payments[msg.sender] = msg.value; // запишем в журнал адрес и кол-во денег которое пришло
    }
}
