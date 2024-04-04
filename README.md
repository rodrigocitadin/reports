# How to run

First, clone the repo:

```sh
git clone https://github.com/rodrigocitadin/reports && cd reports
```

Then, install deps

```sh
mix deps.get
```

So, run iex

```sh
iex -S mix
```

## Normal version

```ex
Reports.build "report_complete.csv"
```

## Parallel version

```ex
reports = Enum.map(1..10, fn _ -> "splitted_report.csv" end)

Reports.build_many reports
```

## Time comparison

```ex
# Normal
:timer.tc fn -> Reports.build("report_complete.csv") end

# Parallel
reports = Enum.map(1..10, fn _ -> "splitted_report.csv" end)

:timer.tc fn -> Reports.build_many(reports) end
```

Time is in microseconds

## Tests

```sh
mix test
```
