# Makefile for Alpine Linux images for XG-040G-MD
# Converts build.sh to Makefile format

# Default target - build both versions
all: 6.6 6.12

# Variables
ROOTFS_6_6 = rootfs.6.6.tar.gz
ROOTFS_6_12 = rootfs.6.12.tar.gz
ROOTFS_DIR_6_6 = rootfs-6.6
ROOTFS_DIR_6_12 = rootfs-6.12
UBINIZE_CFG_6_6 = ubinize.6.6.cfg
UBINIZE_CFG_6_12 = ubinize.6.12.cfg
OUTPUT_6_6 = xg40-alpine-6.6.ubi
OUTPUT_6_12 = xg40-alpine-6.12.ubi
SQUASHFS_IMAGE_6_6 = rootfs-alpine-6.6.squashfs
SQUASHFS_IMAGE_6_12 = rootfs-alpine-6.12.squashfs

# Target for 6.6 version
6.6: $(OUTPUT_6_6)

# Target for 6.12 version
6.12: $(OUTPUT_6_12)

# Build 6.6 UBI image
$(OUTPUT_6_6): $(UBINIZE_CFG_6_6)
	@echo "Building Alpine 6.6 image..."
	sudo mksquashfs $(ROOTFS_DIR_6_6) $(SQUASHFS_IMAGE_6_6) -comp xz -b 262144 -noappend -all-root
	ubinize -o $(OUTPUT_6_6) -m 2048 -p 131072 -O 2048 $(UBINIZE_CFG_6_6)
	@echo "Creating rootfs tar.gz for 6.6..."
	sudo tar czf $(ROOTFS_6_6) -C $(ROOTFS_DIR_6_6) .
	@echo "6.6 image built successfully: $(OUTPUT_6_6)"
	@echo "Rootfs tar.gz created: $(ROOTFS_6_6)"

# Build 6.12 UBI image
$(OUTPUT_6_12): $(UBINIZE_CFG_6_12)
	@echo "Building Alpine 6.12 image..."
	sudo mksquashfs $(ROOTFS_DIR_6_12) $(SQUASHFS_IMAGE_6_12) -comp xz -b 262144 -noappend -all-root
	ubinize -o $(OUTPUT_6_12) -m 2048 -p 131072 -O 2048 $(UBINIZE_CFG_6_12)
	@echo "Creating rootfs tar.gz for 6.12..."
	sudo tar czf $(ROOTFS_6_12) -C $(ROOTFS_DIR_6_12) .
	@echo "6.12 image built successfully: $(OUTPUT_6_12)"
	@echo "Rootfs tar.gz created: $(ROOTFS_6_12)"

# Clean generated files
clean:
	@echo "Cleaning generated files..."
	rm -f $(SQUASHFS_IMAGE_6_6) $(SQUASHFS_IMAGE_6_12) $(OUTPUT_6_6) $(OUTPUT_6_12)
	@echo "Clean complete"

# Help target
help:
	@echo "Available targets:"
	@echo "  all      - Build both 6.6 and 6.12 images (default)"
	@echo "  6.6      - Build Alpine 6.6 UBI image"
	@echo "  6.12     - Build Alpine 6.12 UBI image"
	@echo "  clean    - Remove generated files"
	@echo "  help     - Show this help message"

# Phony targets
.PHONY: all 6.6 6.12 clean help