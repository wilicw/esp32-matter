PWD:=$(shell pwd)
DEVICE:=$(shell ls /dev/tty*usb* | head -n 1)
TARGET:=esp32c3
SERIAL_MONITOR:=pyserial-miniterm
UID:=$(shell id -u)

all: ./main
	docker run --rm -v $(PWD):/project -w /project -u $(UID) -e HOME=/tmp espressif/idf:latest idf.py build

flash:
	esptool.py --chip $(TARGET) --port $(DEVICE) -b 460800 --before default_reset --after hard_reset write_flash --flash_mode dio --flash_size 2MB --flash_freq 80m 0x0 build/bootloader/bootloader.bin 0x8000 build/partition_table/partition-table.bin 0x10000 build/esp32_matter.bin

monitor:
	$(SERIAL_MONITOR) $(DEVICE) 115200

clean:
	rm -rf build/

init:
	docker run --rm -v $(PWD):/project -w /project -u $(UID) -e HOME=/tmp espressif/idf:latest idf.py set-target $(TARGET)

.PHONY: init flash monitor
