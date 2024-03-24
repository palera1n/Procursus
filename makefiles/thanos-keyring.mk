ifneq ($(PROCURSUS),1)
$(error Use the main Makefile)
endif

ifeq (,$(findstring appletvos,$(MEMO_TARGET)))
SUBPROJECTS            += thanos-keyring
else
STRAPPROJECTS          += thanos-keyring
endif
THANOS_KEYRING_VERSION := 2024.03.24
DEB_THANOS_KEYRING_V   ?= $(THANOS_KEYRING_VERSION)

thanos-keyring:
	@echo "thanos-keyring does not need to be built."

thanos-keyring-package: thanos-keyring-stage
	# thanos-keyring.mk Package Structure
	rm -rf $(BUILD_DIST)/thanos-keyring
	mkdir -p $(BUILD_DIST)/thanos-keyring/$(MEMO_PREFIX)/etc/apt/trusted.gpg.d

	# thanos-keyring.mk Prep thanos-keyring
	cp -a $(BUILD_MISC)/keyrings/thanos/thanos.gpg $(BUILD_DIST)/thanos-keyring/$(MEMO_PREFIX)/etc/apt/trusted.gpg.d

	# thanos-keyring.mk Make .debs
	$(call PACK,thanos-keyring,DEB_THANOS_KEYRING_V)

	# thanos-keyring.mk Build cleanup
	rm -rf $(BUILD_DIST)/thanos-keyring

.PHONY: thanos-keyring thanos-keyring-package
