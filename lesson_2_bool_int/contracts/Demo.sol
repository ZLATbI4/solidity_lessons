// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    // boolean
    bool public myBool = true; // state (переменные состояния хранятся в блокчейне)

    function myBoolFunc(bool _inputBool) public {
        bool localBool; // local, false (локальные переменные хранятся в памяти)
        // доступные операции
        localBool && _inputBool;
        localBool || _inputBool;
        localBool == _inputBool;
        localBool != _inputBool;
        !localBool;
    }
    
    // unsigned integers
    // допустимые размерности uint8 / uint16 / uint24 / uint32 и т.д. (шаг 8) до uint256
    uint256 public myUitn = 42;
    // 2 ** 256 = 115792089237316195423570985008687907853269984665640564039457584007913129639936
    uint8 public mySmallUint = 2;
    // 2 ** 8 = 256
    // 0 - минимальное значение, 256 - 1 = 255 - макс значение

    function myUintFunc(uint _inputUint) public {
        uint localUint = 12;
        // доступные операции
        localUint + 1;
        localUint - 1;
        localUint * 2;
        localUint / 2; // дробная часть отбросится
        localUint ** 3;
        localUint % 3;
        -myInt; // унарный оператор доступен для int

        localUint == 1;
        localUint != 1;
        localUint > 1;
        localUint < 1;
        localUint >= 1;
        localUint <= 1;

    }

    // signed integers
    // допустимые размерности int8 / int16 / int24 / int32 и т.д. (шаг 8) до int256
    int public myInt = -122;
    int8 public mySmallInt = -1;
    // 2 ** 7 = 128 (т.к. 1 бит забрал знак)
    // диапазон от -128 до (128 - 1)

    // виды записей инкрементов (аналогично для декрементов)
    function inc() public {
        myInt = myInt + 1;
        myInt += 1;
        myInt++;

        unchecked { // нужно для обхода ошибки переполнения (в данном случае если число перевалит за 127)
            myInt++; // значение myInt при переполнении вернется к нижней границе (если инкремент) или к верхней границе (если декремент)
        }
    }
}
