debootwrap
===

Unprivileged [debootstrap](https://wiki.debian.org/Debootstrap) using [bubblewrap](https://github.com/projectatomic/bubblewrap). All files are owned by you, so you can modify it as needed.

To create a Debian Stretch environment on a new (nonexistent) directory:

```
$ git clone https://github.com/twosigma/debootwrap
$ cd debootwrap
$ make
$ ./debootwrap ~/stretch-env
```

which will create a `run.sh` command inside the directory. You can pass `--root` to get your user mapped as root, otherwise your user will be mapped as yourself. If you don't specify a command it will give you a bash shell.

```
geofft@geofft:~$ ~/stretch-env/run.sh whoami
geofft
geofft@geofft:~$ ~/stretch-env/run.sh --root whoami
root
geofft@geofft:~$ ~/stretch-env/run.sh
geofft@geofft:/$ exit
logout
geofft@geofft:~$ ~/stretch-env/run.sh --root
root@geofft:/# apt install sl
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
  sl
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 26.7 kB of archives.
After this operation, 99.3 kB of additional disk space will be used.
Get:1 http://repo/debian stretch/main amd64 sl amd64 3.03-17+b2 [26.7 kB]
Fetched 26.7 kB in 0s (475 kB/s)
Selecting previously unselected package sl.
(Reading database ... 9748 files and directories currently installed.)
Preparing to unpack .../sl_3.03-17+b2_amd64.deb ...
Unpacking sl (3.03-17+b2) ...
Setting up sl (3.03-17+b2) ...
W: chown to root:adm of file /var/log/apt/term.log failed - OpenLog (22: Invalid argument)
```

A couple of things are weird because bubblewrap only maps a single user and group inside the container. They can mostly be ignored.

We've tested this script as capable of creating a Debian Stretch environment on a Debian Wheezy or Stretch machine. Pull requests to add support for other environments (additional host OSes, additional Debian or Ubuntu target releases) are welcome.

Dependencies
===

You need both `bubblewrap` and `debootstrap`. Bubblewrap works either as a setuid binary (which is how the Debian package ships it) or via user namespaces (which are disabled by default in Debian, but not some other distros), so if your machine has user namespaces enabled, you should be able to install the `bwrap` command onto your PATH without admin privileges.

You also need `libseccomp-dev`, `patchutils`, and `curl` (and external network access) to run `make`. Once you've run `make` you no longer need these build dependencies.
