#!/usr/bin/env bash
set -e

build_dir=build

# Clean build directory with existing images, compressed images and seed manifests
echo "Cleaning build directory..."
rm -rf "$build_dir"
mkdir "$build_dir"

for model_assertion in *.model; do
	echo "Building image for model assertion $model_assertion..."
	ubuntu-image snap "$model_assertion" --output-dir="$build_dir" --validation=enforce
	if [[ -f "$build_dir/pi.img" ]]; then
		image_file=pi.img
	elif [[ -f "$build_dir/pc.img" ]]; then
		image_file=pc.img
	else
		echo "No suitable image file found"
		exit 1
	fi

	compressed_image_file="$build_dir/${model_assertion%.model}.img.xz"
	manifest_file="$build_dir/${model_assertion%.model}.manifest"

	echo "Compressing image to $compressed_image_file..."
	xz -9 "$build_dir/$image_file"
	mv "$build_dir/$image_file.xz" "$compressed_image_file"

	echo "Saving seed manifest to $manifest_file"
	mv "$build_dir/seed.manifest" "$manifest_file"
done
