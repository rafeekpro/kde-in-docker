BASE = ./base/release.sh
WINE = ./wine/release.sh

FIREFOX = ./applications/firefox/release.sh
ACROBAT = ./applications/adobe-acrobat/release.sh
BROWSERS = ./applications/browsers/release.sh
MOTRIX = ./applications/motrix/release.sh


basic:
	@$(BASE) noble


apps:
	@$(FIREFOX)
	@$(BROWSERS)
	@$(MOTRIX)


wine:
	@$(WINE) noble


push:
	@$(BASE) noble push
	@$(WINE) noble push
	@$(FIREFOX) push
	@$(BROWSERS) push
	@$(MOTRIX) push
