# Docker Counter
## Запуск
Файл настроек:
```bash
cp .env.example .env
```
Запуск программы и redis
```bash
docker compose up -d --build
```
Пинг:
```bash
docker compose ps
```
Проверка: `http://localhost:8080`.
## Настройки
Переменные в `.env`:
HOST_PORT - порт на пк - 8080
GREETING - приветствие - Hello, Docker!
## Архитектура
Сторонние сервисы:
app — python-приложение со счётчиком
redis - бэкап счетчика

Для обоих сервисов настроены healthcheck.
## Проверка приложения
Проверить текущее состояние:
```bash
curl http://localhost:8080/
```
Увеличить счётчик:
```bash
curl -X POST http://localhost:8080/increment
```
Проверить работоспособность:
```bash
curl -i http://localhost:8080/healthz
```
Проверить работу хранилища:
```bash
curl -i http://localhost:8080/readyz
```

## Проверка сохранения данных
Увеличить счётчик и запомнить значение:
```bash
curl -X POST http://localhost:8080/increment
curl http://localhost:8080/
```
Пересоздать контейнеры:
```bash
docker compose down
docker compose up -d
```
Проверить, что значение сохранилось:
```bash
curl http://localhost:8080/
```

## Проверка при недоступности redis
Остановить redis:
```bash
docker compose stop redis
```
Проверить ответы приложения:
```bash
curl -i http://localhost:8080/healthz
curl -i http://localhost:8080/readyz
curl -i -X POST http://localhost:8080/increment
```
Восстановить redis:
```bash
docker compose start redis
```
После запуска redis:
```bash
curl http://localhost:8080/
curl -X POST http://localhost:8080/increment
```
Приложение снова работает
## Остановка
```bash
docker compose down
```
Для удаления контейнеров и данных:
```bash
docker compose down -v
```
## Отчёт
Результаты и логи находятся в папке report
