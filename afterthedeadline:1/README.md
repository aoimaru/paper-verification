### paper-verification
```bash
RUN curl -sSL "http://www.polishmywriting.com/download/atd_distribution${ATD_VERSION}.tgz" -o /tmp/atd.tar.gz \
	&& mkdir -p /usr/src/atd \
	&& tar -xzf /tmp/atd.tar.gz -C /usr/src/atd --strip-components 1 \
	&& rm /tmp/atd.tar.gz*
```
* jessfraz/afterthedeadline:1 Levenshtein delete:1 replace:1 insert:1
```bash

afterthedeadline:1   0.0 0.0
znc:2                0.8461538461538461 3.3846153846153846
gcloud:0             1.0 2.75
browsh:4             1.0 3.0
cfssl:2              1.0 3.272727272727273
bcc:3                1.0 3.5
bcc-tools:3          1.0 3.5
linapple:1           1.0 3.8
keepassxc:0          1.0 3.8333333333333335
bpftrace:2           1.0 4.0

```
* jessfraz/afterthedeadline:1 Levenshtein delete:2 replace:2 insert:1
```bash

afterthedeadline:1   0.0 0.0
znc:2                1.0 3.3846153846153846
irssi:2              1.0930232558139534 6.069767441860465
osquery:1            1.2105263157894737 5.0
ricochet:1           1.2352941176470589 4.9411764705882355
tarsnap:1            1.25 4.4375
openbmc:3            1.25 5.5
alpine:0             1.25 6.5
buttslock:0          1.25 6.5
openbmc:2            1.25 6.5
```

* jessfraz/afterthedeadline:1 Levenshtein delete:3 replace:3 insert:1
```bash

afterthedeadline:1   0.0 0.0
znc:2                1.0769230769230769 3.3846153846153846
irssi:2              1.0930232558139534 6.069767441860465
osquery:1            1.2105263157894737 5.0
ricochet:1           1.2352941176470589 4.9411764705882355
tarsnap:1            1.25 4.4375
openbmc:3            1.25 5.5
alpine:0             1.25 6.5
buttslock:0          1.25 6.5
openbmc:2            1.25 6.5
```

* jessfraz/afterthedeadline:1 Jaro Winkler
```bash

afterthedeadline:1   1.0 0.0
znc:2                0.5512820512820512 3.3846153846153846
gcloud:0             0.0 2.75
browsh:4             0.0 3.0
cfssl:2              0.0 3.272727272727273
bcc:3                0.0 3.5
bcc-tools:3          0.0 3.5
linapple:1           0.0 3.8
keepassxc:0          0.0 3.8333333333333335
bpftrace:2           0.0 4.0
```

