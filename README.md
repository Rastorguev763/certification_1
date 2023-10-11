# Промежуточная аттестация (Задание 1)

## Анализ велосипедных поездок

### Цель

Используя средства СУБД Postgres загрузить данные о велопоездах в городе Остин за 2013-2017 год, преобразовать их и подготовить специальную витрину для дальнейшего анализа.

### Данные

Данные в архиве *dataset.zip*

### Вам доступно два файла с данными

**austin_bikeshare_trips.csv**

- bikeid: целочисленный идентификатор велосипеда

- checkout_time: ЧЧ:ММ:СС, см. время начала для отметки даты

- duration_minutes:: целое число минут продолжительности поездки.

- end_station_id: целочисленный идентификатор конечной станции.

- end_station_name: строка имени конечной станции.

- month: месяц, целое число

- start_station_id: целочисленный идентификатор начальной станции

- start_station_name: строка названия начальной станции.

- start_time: ГГГГ-ММ-ДД ЧЧ:ММ:СС

- subscriber_type: тип членства, например. прогулка пешком, ежегодная, другая велопрокат и т. д.

- trip_id: уникальный идентификатор поездки int

- год: год поездки, целое число

**austin_bikeshare_stations.csv**

- latitude: геопространственная широта, точность до 5 знаков.

- location: (широта, долгота)

- longitude: геопространственная долгота, точность до 5 знаков.

- name: название станции, ул.

- station_id: уникальный идентификатор станции, целое число

- status: статус станции (активна, закрыта, перемещена, только ACL)

### Задание

1. Используя СУБД Postgres написать запрос, который формирует таблицы соответствующие по структуре и типу полей из входных csv-файлов.

2. Наполнить созданные таблицы данными из файлов.

3. Написать sql-запрос, который формирует таблицы для каждого года (с 2013 по 2017) следующего содержания:

- уникальный идентификатор станции

- количество начавшихся поездок в данной станции за данных год

- количество завершенных поездок в данной станции за данных год

- общее количество поездок начавшихся или закончившихся в данной станции за данных год

- средняя продолжительность поездок начавшихся в данной станции в данном году

- средняя продолжительность поездок завершившихся в данной станции в данном году

**При написании предыдущего запроса учитывайте следующие условия:**

- Станции должны быть активными

- Станции в итоговой витрине должны быть отсортированы по средней продолжительности поездок начавшихся в данной станции

- К итоговому результату приложить названия 10 станций с самым высоким показателем средней продолжительности начавшихся поездок за 2016 год

## Запуск Docker и PostgreSQL

Для установки Dockera и запуска используйте [эту](https://github.com/Rastorguev763/docker_example) инстуркцию.

### Для устаноки PostgreSQL и запуска:

1. Клонировать репозиторий
2. Разархивировать датасет **(dataset.zip)** в папку **dataset**
3. Выполнить команду

```bash
docker-compose up -d
```

4. Для работы с PostgreSQL используйте [эту](https://github.com/Rastorguev763/docker_example/tree/master#шаг-4-запуск-контейнера-postgresql-с-помощью-docker-compose) инструкцию.

## Запросы

Для формирования таблицы для каждого года (с 2013 по 2017) следующего содержания:

- уникальный идентификатор станции

- количество начавшихся поездок в данной станции за данных год

- количество завершенных поездок в данной станции за данных год

- общее количество поездок начавшихся или закончившихся в данной станции за данных год

- средняя продолжительность поездок начавшихся в данной станции в данном году

- средняя продолжительность поездок завершившихся в данной станции в данном году

```sql
SELECT
  year,
  start_station_id AS station_id,
  COUNT(CASE WHEN start_station_id IS NOT NULL THEN 1 ELSE NULL END) AS trips_started,
  COUNT(CASE WHEN end_station_id IS NOT NULL THEN 1 ELSE NULL END) AS trips_ended,
  COUNT(CASE WHEN start_station_id IS NOT NULL OR end_station_id IS NOT NULL THEN 1 ELSE NULL END) AS total_trips,
  ROUND(AVG(CASE WHEN start_station_id IS NOT NULL THEN duration_minutes ELSE NULL END)::numeric, 2) AS avg_duration_started,
  ROUND(AVG(CASE WHEN end_station_id IS NOT NULL THEN duration_minutes ELSE NULL END)::numeric, 2) AS avg_duration_ended
FROM bikeshare_trips
WHERE year BETWEEN 2013 AND 2017
GROUP BY year, station_id
ORDER BY year, station_id;
```

Для уточнения

- Станции должны быть активными

- Станции в итоговой витрине должны быть отсортированы по средней продолжительности поездок начавшихся в данной станции

```sql
SELECT
  year,
  start_station_id AS station_id,
  COUNT(CASE WHEN start_station_id IS NOT NULL THEN 1 ELSE NULL END) AS trips_started,
  COUNT(CASE WHEN end_station_id IS NOT NULL THEN 1 ELSE NULL END) AS trips_ended,
  COUNT(CASE WHEN start_station_id IS NOT NULL OR end_station_id IS NOT NULL THEN 1 ELSE NULL END) AS total_trips,
  ROUND(AVG(CASE WHEN start_station_id IS NOT NULL THEN duration_minutes ELSE NULL END)::numeric, 2) AS avg_duration_started,
  ROUND(AVG(CASE WHEN end_station_id IS NOT NULL THEN duration_minutes ELSE NULL END)::numeric, 2) AS avg_duration_ended
FROM bikeshare_trips
WHERE year BETWEEN 2013 AND 2017
      AND start_station_id IS NOT NULL  -- Исключение строк с NULL в start_station_id
GROUP BY year, station_id
ORDER BY year, avg_duration_started DESC, station_id;
```

Топ 10 названия станций с самым высоким показателем средней продолжительности начавшихся поездок за 2016 год

1. Trinity & 6th Street
2. Guadalupe & 21st
3. East 6th & Pedernales St.
4. State Capitol Visitors Garage @ San Jacinto & 12th
5. MoPac Pedestrian Bridge @ Veterans Drive
6. Zilker Park
7. Barton Springs Pool
8. Rainey St @ Cummings
9. East 2nd & Pedernales
10. East 7th & Pleasant Valley

```sql
SELECT
  start_station_name,
  ROUND(AVG(duration_minutes)::numeric, 2) AS avg_duration_started
FROM bikeshare_trips
WHERE year = 2016
  AND start_station_id IS NOT NULL
GROUP BY start_station_name
ORDER BY avg_duration_started DESC
LIMIT 10;
```