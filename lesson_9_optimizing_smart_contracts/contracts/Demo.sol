pragma solidity ^0.8.0;

contract Op {
    // 1
    uint demo;

    // 2
    uint128 a = 1; // в данном случае переменные а и b займут 1 ячейку, на этом сэкономит газ
    uint128 b = 1;
    uint256 c = 1;

    // 3
    uint demo1 = 1;

    // 4 
    bytes32 public hash = 0x9c22ff5f214f3;

    // 5
    mapping(address => uint) payments;
    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments[msg.sender] = msg.vlaue;
    }

    // 6
    uint8[] demo2 = [1, 2, 3]; 

    // 7
    uint public result = 1;
    function doWork(uint[] memory data) public {
        uint temp = 1;
        for(uint i = 0; i < data.length; i++) {
            temp *= data[i];
        }
        result = temp;
    }
}

contract Un {
    // 1
    uint demo = 0; // значение одинаково с оптимизированным контрактом, но кушает больше газа

    // 2
    uint128 a = 1;
    uint256 c = 1;
    uint128 b = 1;

    // 3
    uint8 demo1 = 1; // тут переменная скушает больше газа, т.к. явно указано до какой размерности её нужно урезать

    // 4
    bytes32 public hash = keccak256( // эта переменная обойдется дороже, т.к. для её формирования нужно вызвать доп функцию
        abi.encodePacked("test")
    );

    // 5
    mapping(address => uint) payments;
    function pay() external payable {
        address _from = msg.sender; // т.к. используется промежуточная переменная, то будет потребляться больше газа
        require(_from != address(0), "zero address");
        payments[_from] = msg.vlaue;
    }

    // 6
    uint[] demo2 = [1, 2, 3];

    // 7
    uint public result = 1;
    function doWork(uint[] memory data) public {
        for(uint i = 0; i < data.length; i++) {
            result *= data[i]; // менять переменную которая хранится в блокчейне много раз - дорого!
        }
    }
}
