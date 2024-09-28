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


echo "+++++++++++++++++++++++++Gaussian Deblurring++++++++++++++++++++++++++++"
rm -rf NAFNet/deblur_output
rm -rf NAFNet/GIF
rm -rf NAFNet/resized
rm -rf NAFNet/tobedeblurred
rm -rf NAFNet/tobedeblurred_deblurred_nafnet
rm -rf Real-ESRGAN/GIF
rm -rf Real-ESRGAN/tobedeblurred
rm -rf Real-ESRGAN/tobedeblurred_deblurred_esrgan
rm -rf Real-ESRGAN/tobedeblurred_deblurred_nafnet
rm -rf Real-ESRGAN/tobedeblurred_deblurred_nafnet_deblurred_esrgan
mkdir NAFNet/tobedeblurred
mkdir Real-ESRGAN/tobedeblurred

cp -r "${1}_blurred_gaussian/"* NAFNet/tobedeblurred
cp -r "${1}_blurred_gaussian/"* Real-ESRGAN/tobedeblurred

echo "NAFNet deblurring"
cd NAFNet
conda activate nafnet
python deblur.py --dir tobedeblurred
cd .. 
cp -r NAFNet/tobedeblurred_deblurred_nafnet Real-ESRGAN


rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "NAFNet/tobedeblurred_deblurred_nafnet/"* LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene proposed_trio_gaussian/Original-NeRF_nafnet

cd Real-ESRGAN
echo "Real-ESRGAN deblurring"
conda activate torcher
python deblur.py --dir tobedeblurred_deblurred_nafnet  --gt_dir tobedeblurred
python deblur.py --dir tobedeblurred --gt_dir tobedeblurred
cd ..

rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "Real-ESRGAN/tobedeblurred_deblurred_nafnet_deblurred_esrgan/"* LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene proposed_trio_gaussian/Original-NeRF_nafnet_realesrgan

rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "Real-ESRGAN/tobedeblurred_deblurred_esrgan/"* LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene proposed_trio_gaussian/Original-NeRF_realesrgan

echo "+++++++++++++++++++++++++Finishing Gaussian Deblurring++++++++++++++++++++++++++++"



echo "+++++++++++++++++++++++++Lens Deblurring++++++++++++++++++++++++++++"
rm -rf NAFNet/deblur_output
rm -rf NAFNet/GIF
rm -rf NAFNet/resized
rm -rf NAFNet/tobedeblurred
rm -rf NAFNet/tobedeblurred_deblurred_nafnet
rm -rf Real-ESRGAN/GIF
rm -rf Real-ESRGAN/tobedeblurred
rm -rf Real-ESRGAN/tobedeblurred_deblurred_esrgan
rm -rf Real-ESRGAN/tobedeblurred_deblurred_nafnet
rm -rf Real-ESRGAN/tobedeblurred_deblurred_nafnet_deblurred_esrgan
mkdir NAFNet/tobedeblurred
mkdir Real-ESRGAN/tobedeblurred
cp -r "${1}_blurred_lens/"* NAFNet/tobedeblurred
cp -r "${1}_blurred_lens/"* Real-ESRGAN/tobedeblurred

echo "NAFNet deblurring"
cd NAFNet
conda activate nafnet
python deblur.py --dir tobedeblurred
cd .. 
cp -r NAFNet/tobedeblurred_deblurred_nafnet Real-ESRGAN


rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "NAFNet/tobedeblurred_deblurred_nafnet/"* LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene proposed_trio_lens/Original-NeRF_nafnet

cd Real-ESRGAN
echo "Real-ESRGAN deblurring"
conda activate torcher
python deblur.py --dir tobedeblurred_deblurred_nafnet  --gt_dir tobedeblurred
python deblur.py --dir tobedeblurred --gt_dir tobedeblurred
cd ..

rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "Real-ESRGAN/tobedeblurred_deblurred_nafnet_deblurred_esrgan/"* LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene proposed_trio_lens/Original-NeRF_nafnet_realesrgan

rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "Real-ESRGAN/tobedeblurred_deblurred_esrgan/"* LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene proposed_trio_lens/Original-NeRF_realesrgan

echo "+++++++++++++++++++++++++Finishing Lens Deblurring++++++++++++++++++++++++++++"





echo "+++++++++++++++++++++++++Motion Deblurring++++++++++++++++++++++++++++"
rm -rf NAFNet/deblur_output
rm -rf NAFNet/GIF
rm -rf NAFNet/resized
rm -rf NAFNet/tobedeblurred
rm -rf NAFNet/tobedeblurred_deblurred_nafnet
rm -rf Real-ESRGAN/GIF
rm -rf Real-ESRGAN/tobedeblurred
rm -rf Real-ESRGAN/tobedeblurred_deblurred_esrgan
rm -rf Real-ESRGAN/tobedeblurred_deblurred_nafnet
rm -rf Real-ESRGAN/tobedeblurred_deblurred_nafnet_deblurred_esrgan
mkdir NAFNet/tobedeblurred
mkdir Real-ESRGAN/tobedeblurred
cp -r "${1}_blurred_motion/"* NAFNet/tobedeblurred
cp -r "${1}_blurred_motion/"* Real-ESRGAN/tobedeblurred

echo "NAFNet deblurring"
cd NAFNet
conda activate nafnet
python deblur.py --dir tobedeblurred
cd .. 
cp -r NAFNet/tobedeblurred_deblurred_nafnet Real-ESRGAN


rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "NAFNet/tobedeblurred_deblurred_nafnet/"* LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene proposed_trio_motion/Original-NeRF_nafnet

cd Real-ESRGAN
echo "Real-ESRGAN deblurring"
conda activate torcher
python deblur.py --dir tobedeblurred_deblurred_nafnet  --gt_dir tobedeblurred
python deblur.py --dir tobedeblurred --gt_dir tobedeblurred
cd ..

rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "Real-ESRGAN/tobedeblurred_deblurred_nafnet_deblurred_esrgan/"* LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene proposed_trio_motion/Original-NeRF_nafnet_realesrgan

rm -r LLFF/scene
mkdir LLFF/scene
mkdir LLFF/scene/images
cp -r "Real-ESRGAN/tobedeblurred_deblurred_esrgan/"* LLFF/scene/images
cd LLFF && python imgs2poses.py scene && cd ..
cp -r LLFF/scene proposed_trio_motion/Original-NeRF_realesrgan

echo "+++++++++++++++++++++++++Finishing Motion Deblurring++++++++++++++++++++++++++++"





mkdir proposed_trio_gaussian/Original-NeRF_nafnet/specified_images
mkdir proposed_trio_gaussian/Original-NeRF_realesrgan/specified_images
mkdir proposed_trio_gaussian/Original-NeRF_nafnet_realesrgan/specified_images

mkdir proposed_trio_lens/Original-NeRF_nafnet/specified_images
mkdir proposed_trio_lens/Original-NeRF_realesrgan/specified_images
mkdir proposed_trio_lens/Original-NeRF_nafnet_realesrgan/specified_images

mkdir proposed_trio_motion/Original-NeRF_nafnet/specified_images
mkdir proposed_trio_motion/Original-NeRF_realesrgan/specified_images
mkdir proposed_trio_motion/Original-NeRF_nafnet_realesrgan/specified_images


cp -r "$1/"* proposed_trio_gaussian/Original-NeRF_nafnet/specified_images
cp -r "$1/"* proposed_trio_gaussian/Original-NeRF_realesrgan/specified_images
cp -r "$1/"* proposed_trio_gaussian/Original-NeRF_nafnet_realesrgan/specified_images

cp -r "$1/"* proposed_trio_lens/Original-NeRF_nafnet/specified_images
cp -r "$1/"* proposed_trio_lens/Original-NeRF_realesrgan/specified_images
cp -r "$1/"* proposed_trio_lens/Original-NeRF_nafnet_realesrgan/specified_images


cp -r "$1/"* proposed_trio_motion/Original-NeRF_nafnet/specified_images
cp -r "$1/"* proposed_trio_motion/Original-NeRF_realesrgan/specified_images
cp -r "$1/"* proposed_trio_motion/Original-NeRF_nafnet_realesrgan/specified_images



( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd proposed_trio_gaussian/Original-NeRF_nafnet && python run_nerf.py --config configs/demo_blurball.txt ) &
( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd proposed_trio_gaussian/Original-NeRF_nafnet_realesrgan && python run_nerf.py --config configs/demo_blurball.txt ) &
( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd proposed_trio_gaussian/Original-NeRF_realesrgan && python run_nerf.py --config configs/demo_blurball.txt ) &
( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd proposed_trio_lens/Original-NeRF_nafnet && python run_nerf.py --config configs/demo_blurball.txt ) &
( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd proposed_trio_lens/Original-NeRF_nafnet_realesrgan && python run_nerf.py --config configs/demo_blurball.txt ) &
( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd proposed_trio_lens/Original-NeRF_realesrgan && python run_nerf.py --config configs/demo_blurball.txt ) &

wait


( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd proposed_trio_motion/Original-NeRF_nafnet && python run_nerf.py --config configs/demo_blurball.txt ) &
( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd LLFF/scene proposed_trio_motion/Original-NeRF_nafnet_realesrgan && python run_nerf.py --config configs/demo_blurball.txt ) &
( source ~/anaconda3/etc/profile.d/conda.sh && conda activate torcher && cd LLFF/scene proposed_trio_motion/Original-NeRF_realesrgan && python run_nerf.py --config configs/demo_blurball.txt ) &

wait
