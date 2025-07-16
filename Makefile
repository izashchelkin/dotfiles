.PHONY: all

all:
	@ln -sn `pwd`/nvim ~/.config/nvim && echo "symlinked nvim config" || echo "did not symlink nvim config"
	@ln -sn `pwd`/kitty ~/.config/kitty && echo "symlinked kitty config" || echo "did not symlink kitty config"
	@ln -sn `pwd`/ghostty ~/.config/ghostty && echo "symlinked ghostty config" || echo "did not symlink ghostty config"

