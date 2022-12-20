## aptGetUpdatePrecedesInstall

* bash Best-Practice?              -> No
* Immediate Violation Consequences -> Build failure
* Future Violation Consequences    -> N/A
* Gold Set Confidence              -> 100.00%

### gold/4ee640d195f408deedaa8080d7e4c78438e1b9e1:0
* 実際のDockerfile
```bash
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
		tk-dev \
	&& rm -rf /var/lib/apt/lists/*
```
* ルール[aptGetUpdatePrecedesInstall]に違反しているDockerfile
```bash
RUN apt-get install -y --no-install-recommends \
		tk-dev \
	&& rm -rf /var/lib/apt/lists/*
```

### Levenshteinで検索を行った結果
0.33333333...は7個検出 \
パラメータ: Levenshtein delete:1 replace:1 insert:1 
* gold/a38778791e85590f88d617c868fce97c2b4241a2:0 ---> 0.3333333333333333
```bash
RUN apt-get update && apt-get install -y --no-install-recommends \
		tk-dev \
	&& rm -rf /var/lib/apt/lists/*
```
* gold/4ee640d195f408deedaa8080d7e4c78438e1b9e1:0 ---> 0.3333333333333333
```bash
RUN apt-get update && apt-get install -y --no-install-recommends \
		tk-dev \
	&& rm -rf /var/lib/apt/lists/*
```