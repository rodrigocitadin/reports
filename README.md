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
Reports.build_many ["report_1.csv", "report_2.csv", "report_3.csv"]
```


## Tests

```sh
mix test
```
