ifneq ($(PROCURSUS),1)
$(error Use the main Makefile)
endif

ifeq (,$(findstring appletvos,$(MEMO_TARGET)))
SUBPROJECTS             += lrdsnow-keyring
else
STRAPPROJECTS           += lrdsnow-keyring
endif
LRDSNOW_KEYRING_VERSION := 2024.03.28
DEB_LRDSNOW_KEYRING_V   ?= $(LRDSNOW_KEYRING_VERSION)

lrdsnow-keyring:
	@echo "lrdsnow-keyring does not need to be built."

lrdsnow-keyring-package: lrdsnow-keyring-stage
	# lrdsnow-keyring.mk Package Structure
	rm -rf $(BUILD_DIST)/lrdsnow-keyring
	mkdir -p $(BUILD_DIST)/lrdsnow-keyring/$(MEMO_PREFIX)/etc/apt/trusted.gpg.d

	# lrdsnow-keyring.mk Prep lrdsnow-keyring
	cp -a $(BUILD_MISC)/keyrings/lrdsnow/lrdsnow.gpg $(BUILD_DIST)/lrdsnow-keyring/$(MEMO_PREFIX)/etc/apt/trusted.gpg.d

	# lrdsnow-keyring.mk Make .debs
	$(call PACK,lrdsnow-keyring,DEB_LRDSNOW_KEYRING_V)

	# lrdsnow-keyring.mk Build cleanup
	rm -rf $(BUILD_DIST)/lrdsnow-keyring

.PHONY: lrdsnow-keyring lrdsnow-keyring-package
