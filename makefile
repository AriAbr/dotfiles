stow:
	stow -v -R -d stowables/ -t $$HOME \
		bash \
		git \
		scripts-shared \
		scripts-system \
		starship

.PHONY: stow
