# minidlna-dsd
docker container to compile and run the modified minidlna code supporting DSD files written by Takeshich NAKAMURA but not merged yet.

Minidlna : http://minidlna.sourceforge.net

Patch : https://sourceforge.net/u/takeshich/minidlna/ci/AddSupport4DSD/tree/

The Dockerfile installs the necessary librarires and tools to compile the source code that is retrieved from sourceforge.
It compiles and installs the program. then it does some cleanup.

build and run the container as follow
```
docker build -t minidlna-dsd .
docker run -d --name minidlna -v /mnt/disk/yourfiles:/media/files --net=host minidlna-dsd
```

or get it from the docker hub
```
docker run -d --name minidlna -v /mnt/disk/yourfiles:/media/files --net=host mimizone/minidlna-dsd
```
