# esp32-matter

## Prerequisite

- docker
- esptool.py
- make

## Build

```bash
make all
```

## Flash device

```bash
make flash
# or
make flash TARGET=esp32c3 DEVICE=/dev/ttyUSB0
```

## Serial monitor

```bash
make monitor
```

## License

[BSD-3-Clause](https://opensource.org/license/bsd-3-clause/)
