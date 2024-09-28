#!/bin/bash

source ~/anaconda3/etc/profile.d/conda.sh
conda activate nafnet


cp -r "$1" synthetic_blurring
cd synthetic_blurring
chmod +x runner.sh
./runner.sh "$1"
cd ..
cp -r synthetic_blurring/"$1_blurred_motion" .
cp -r synthetic_blurring/"$1_blurred_lens" .
cp -r synthetic_blurring/"$1_blurred_gaussian" .


rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "$1_blurred_motion/." LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene Original-NeRF_motion


rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "$1_blurred_lens/." LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene Original-NeRF_lens



rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "$1_blurred_gaussian/." LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene Original-NeRF_gaussian


mkdir Original-NeRF_gaussian/specified_images
mkdir Original-NeRF_lens/specified_images
mkdir Original-NeRF_motion/specified_images

cp -r "$1"/* Original-NeRF_gaussian/specified_images
cp -r "$1"/* Original-NeRF_lens/specified_images
cp -r "$1"/* Original-NeRF_motion/specified_images


( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd Original-NeRF_gaussian && python run_nerf.py --config configs/demo_blurball.txt ) &
( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd Original-NeRF_lens && python run_nerf.py --config configs/demo_blurball.txt ) &
( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd Original-NeRF_motion && python run_nerf.py --config configs/demo_blurball.txt ) &

wait

