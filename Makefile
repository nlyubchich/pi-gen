BUILD_DIR = deploy
CONFIG_DIR = configs

build_test:
	./build-docker.sh -c ${CONFIG_DIR}/qemu
build_prod:
	./build-docker.sh -c $(CONFIG_DIR)/production

get_kernel:
	curl https://raw.githubusercontent.com/dhruvvyas90/qemu-rpi-kernel/master/kernel-qemu-4.19.50-buster > deploy/kernel-qemu-4.19.50-buster
	curl https://raw.githubusercontent.com/dhruvvyas90/qemu-rpi-kernel/master/versatile-pb.dtb > deploy/versatile-pb.dtb

add_size:
	qemu-img resize 2019-09-29-Pigeon-lite-qemu.img +2G

run_test: clean build_test get_kernel add_size
run_prod: clean build_prod

qemu:
	qemu-system-arm \
		-kernel deploy/kernel-qemu-4.19.50-buster \
		-append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
		-dtb deploy/versatile-pb.dtb \
		-cpu arm1176 -m 256 \
		-M versatilepb \
		-no-reboot \
		-serial stdio \
		-net nic -net user,hostfwd=tcp::2222-:22 \
		-drive file=deploy/2019-09-29-Pigeon-lite-qemu.img,format=raw

clean:
	if [ -d "./$(BUILD_DIR)" ];then \
		rm -r $(BUILD_DIR); \
	fi
