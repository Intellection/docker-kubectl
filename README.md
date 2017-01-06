# docker-kubectl

[![CircleCI](https://circleci.com/gh/Intellection/docker-kubectl/tree/master.svg?style=svg&circle-token=3f763376c55562268cdb233a94720955f9856f4d)](https://circleci.com/gh/Intellection/docker-kubectl/tree/master)

Makes it easy to access the Kubernetes API [from a Pod][1] especially when
service accounts are being used for accessing the API. Since all containers in a
Pod share the same network namespace, containers will be able to reach the API
on localhost.

Find available [versions and their respective binaries here][2].

## Usage

```
$ docker run zappi/kubectl:<VERSION> proxy -p 8080
Starting to serve on 127.0.0.1:8080
```

[1]: http://kubernetes.io/docs/user-guide/accessing-the-cluster/#accessing-the-api-from-a-pod
[2]: https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md#client-binaries
