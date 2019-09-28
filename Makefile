build:
	./build-docker.sh

get_kernel:
	curl https://raw.githubusercontent.com/dhruvvyas90/qemu-rpi-kernel/master/kernel-qemu-4.4.34-jessie > deploy/kernel-qemu-4.4.34-jessie

qemu:
	qemu-system-arm \
		-kernel deploy/kernel-qemu-4.4.34-jessie \
		-append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
		-cpu arm1176 -m 256 \
		-M versatilepb \
		-no-reboot \
		-serial stdio \
		-net nic -net user,hostfwd=tcp::2222-:22 \
		-drive file=deploy/2019-09-28-Pigeon-lite-qemu.img,format=raw

clean:
	rm -r deploy/
