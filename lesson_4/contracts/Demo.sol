// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    // Enums
    enum Status { Paid, Delivered, Received }
    // в данном случае у элементов енама значения будут равны индексу, т.е. Paid = 0, Delivered = 1, Received = 2

    Status public currentStatus;

    function pay() public {
        currentStatus = Status.Paid; // приводится значение 0 (согласно индексу Paid)
    }

    function delivered() public {
        currentStatus = Status.Delivered; // присвоить значение 1 (согласно индексу Delivered)
    }


    // Array fixed
    uint[10] public items; // массив положительных чисел, макс размерностью в 10 элементов

    function demo() public {
        items[0] = 100;
        items[1] = 200;
        items[4] = 400;
    }

    function sampleMemory() public view returns(uint[] memory) {
        uint[] memory tempArray = new uint[](10); // при создании массива в памяти, а не в блокчейне нужно указывать размерность в скобках;
        tempArray[0] = 1;
        return tempArray;
    }

    // вложенный массив
    string[3][2] public items2; // items2 вложенный массив строк, размерность items2 равна 2, а у этих 2 вложенных массивов размерность равна 2;
    function demo2() public {
        items2 = [
            ["test1", "test2", "test3"],
            ["test4", "test5", "test6"]
        ];
    }

    // Arrays dynamic
    uint[] public items3;
    uint public len;

    function demo3() public{
        items3.push(3); // добавляется элемент с помощью метода push
        len = items3.length; // размер массива
    }

    // Byte - массивы из последовательности байт
    bytes1 public myVar;  // массив размерностью в 1 байт или 8 бит
    // бывают размерности от 1 до 32 байт
    // 32 * 8 = 256 бит

    bytes public myVar1 = "test here"; // динамический байтовый массив
    bytes public latin = "testo presto";
    bytes public cyrillic = unicode"Привет мир!"; // для символом не латиницы, нужно указывать кодировку

    // Struct - объекты
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
