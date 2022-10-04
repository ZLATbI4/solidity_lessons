## Урок - 5: Тестирование смарт-контрактов

**Модули:**
- [Hardhat](https://hardhat.org) - платформа, которая позволяет компилировать, разворачивать и тестировать смарт-контракты
- [Node-gyp](https://github.com/nodejs/node-gyp) - сборщик
- [Mocha](https://mochajs.org) - тестовый фреймворк
- [ChaiJS](https://www.chaijs.com) - библиотека проверок
- [Waffle](https://ethereum-waffle.readthedocs.io/en/latest/) - библиотека для проверок смарт-контрактов

**Настройка окружения:**
- Установлен nodejs
- Установлен node-gyp `npm install -g node-gyp`
- Идём в нужную директорию с проектом и выполняем инициализацию nodejs проекта `npm init`
- Устанавливаем модули hardhat `npm install --save-dev hardhat`
- В проекте вызываем настройки проекта hardhat `npx hardhat` и следуем шагам

**Remarks:**
- Для компилирования смарт-контракта нужно выполнить `npx hardhat compile`
- Для очистки старых скомпилированных версий `npx hardhat clean`
- Запуск тестов `npx hardhat test`
