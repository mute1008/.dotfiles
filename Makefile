env_archlinux:
	docker run \
		-it \
		--rm \
		-v $(PWD):/root/.dotfiles \
		-w /root/.dotfiles \
		archlinux \
		bash -c "pacman -Sy && \
		pacman -S --noconfirm sudo && \
		/bin/bash"

env_macos:
	# TODO https://github.com/kholia/OSX-KVM
	:
