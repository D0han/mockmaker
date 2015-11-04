# mockmaker
## How to use:
Run script with desired command as parameter.
Repeat for as many parameters as you need.

### Example:
```shell
./mock git version
./mock git --help
./mock git thiswillfail
./mock svn --version
```

## Outcome:
Directory called "mocks" will be created, with executable file named after mocked command.
This file can be run with given earlier parameters and output same stdout, stderr and exit code as original.

### Example:
```shell
mocks/git
mocks/svn
```
