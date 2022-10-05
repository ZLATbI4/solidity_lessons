// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    string public message = "hello!"; // state
    uint public balance;

    // Call функции (не снимается плата за газ)
    // view
    function getBalance() public view returns(uint){ // неявное возвращение, не указали имя параметра который возвращает
        return address(this).balance;
    }

    function getBalance2() public view returns(uint balance){ // явное возвращение, есть имя возвращаемого параметра
        balance = address(this).balance; // как можно увидеть, из-за того что указано явное возвращение, return можно не указывать
    }
    
    function getMessage() public view returns(string memory){ // view функции могут читать/возвращать данные из state
        return message;
    }

    // pure
    function rate(uint amount) public pure returns(uint){ // pure функции не могут получать данные  из state
        return amount * 3;
    }

    // Transact функции (снимается плата за газ)
    // без модификатора
    function setMessage(string memory newMessage) external{
        message = newMessage;
    }

    // payable
    function pay() external payable{
        balance += msg.value; // можно и не указывать, это для демки. без указания деньги и так придут на счет смарт-контракта
    }

    receive() external payable{
        // функция receive нужна для того чтобы на счет смарт-контракта могли отправить деньги прямым переводом, без вызова какой-либо функции. Обрати внимание, что слово function указывать не нужно.
    }

    fallback() external payable{
        // нужна если на смарт-контракт пришла транзакция с вызовом функции которой нет в контракте, без неё вернет ошибку. Собственно в теле можно указать, что делать в этом случае.
    }
}
