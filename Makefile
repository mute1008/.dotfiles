FLAKE  = ~/.dotfiles\#default
NIXCFG = NIX_CONFIG="experimental-features = nix-command flakes"

switch:
	$(NIXCFG) home-manager switch --flake $(FLAKE) --impure -b backup

update:
	$(NIXCFG) nix flake update
	$(MAKE) switch

.PHONY: switch update
