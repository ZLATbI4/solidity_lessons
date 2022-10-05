// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    address public owner;
    string notAnOwnerError = "You are not an owner";

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        pay();
    }

    // Проверки
    // require
    function withdraw(address payable _to) external {
        require(msg.sender == owner, notAnOwnerError);
        _to.transfer(address(this).balance);
    }

    // revert
    function withdraw2(address payable _to) external {
        if (msg.sender != owner) {
            revert(notAnOwnerError);
        }
        _to.transfer(address(this).balance);
    }

    // assert
    function withdraw3(address payable _to) external {
        assert(msg.sender == owner); // Panic error if false
        _to.transfer(address(this).balance);
    }

    // Кастомный модификатор
    modifier onlyOwner() {
        require(msg.sender == owner, notAnOwnerError);
        _; // этот символ означает что нужно выполнить дальше код из тела функции
    }

    function withdraw4(address payable _to) external onlyOwner {
        _to.transfer(address(this).balance);
    }

    modifier onlyOwner2(address ownerAddress) {
        require(msg.sender == ownerAddress, notAnOwnerError);
        _; // этот символ означает что нужно выполнить дальше код из тела функции
        require(ownerAddress == owner, "Sent address is owners"); // выполнится после кода функции
        // таким образом кастомный модификатор можно использовать как декоратор
    }

    function withdraw5(address payable _to) external onlyOwner2(owner) {
        _to.transfer(address(this).balance);
    }

    // События
    event Paid(address indexed _from, uint _amount, uint _timestamp);
    // по помеченному аргументу как indexed можно делать поиск в журнале событий
    // в рамках одного события можно индексировать до 3х полей

    function pay() public payable{
        emit Paid(msg.sender, msg.value, block.timestamp);
        // при выполнении этого блока кода в спец журнал событий, который хранится вместе с блокчейном будет записано
        // событие с указанными параметрами
    }
}
