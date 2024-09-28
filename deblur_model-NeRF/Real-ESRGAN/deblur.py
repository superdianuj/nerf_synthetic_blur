import os
os.environ["CUDA_VISIBLE_DEVICES"] = "1"

fold=8


import warnings
warnings.filterwarnings("ignore")

import argparse
import imageio.v2 as imageio

parser=argparse.ArgumentParser(description='Deblur a set of images')
parser.add_argument('--dir',help='Input directory',type=str)
parser.add_argument('--gt_dir',type=str)
args=parser.parse_args()

input_dir=args.dir
gt_dir=args.gt_dir
output_dir=input_dir+'_deblurred_esrgan'

if not os.path.exists(output_dir):
    os.makedirs(output_dir)
else:
    os.system('rm -rf '+output_dir+'/*')



os.system(f'python inference_realesrgan.py -n realesr-general-x4v3 -i {input_dir} -o {output_dir} -s 1')



out_img_paths=sorted(os.listdir(output_dir),key=lambda x: int(x.split('_')[-1].split('.')[0]) if '_' in x else int(x.split('.')[0]))
in_img_paths=sorted(os.listdir(input_dir),key=lambda x: int(x.split('_')[-1].split('.')[0]) if '_' in x else int(x.split('.')[0]))

for i in range(len(out_img_paths)):
    num_img=int(out_img_paths[i].split('.')[0].split('_')[-1]) if '_' in out_img_paths[i] else int(out_img_paths[i].split('.')[0])
    if num_img%fold==0:
        # replace the output image with the input image
        os.system(f'cp {input_dir}/{in_img_paths[i]} {output_dir}/{out_img_paths[i]}')

print("Computing metrics for deblurring...")
os.system(f'python compute_metrics.py --gt_dir {gt_dir} --target_dir {output_dir}')


if not os.path.exists('GIF'):
    os.system('mkdir GIF')

def gifer(out_directory,gif_name,fps=10):
    if os.path.exists(gif_name):
        os.system(f'rm -rf {gif_name}')

    print("Current Directory:",out_directory)
    img_list=os.listdir(out_directory)
    img_list=[img for img in img_list if img.endswith('.png') or img.endswith('.jpg') or img.endswith('.JPG')]
    images=sorted(img_list,key=lambda x:int(x.split('_')[-1].split('.')[0]) if '_' in x else int(x.split('.')[0]))

    images=[os.path.join(out_directory,img_name) for img_name in images]

    gif=[]

    for img in images:
        gif.append(imageio.imread(img))

    imageio.mimsave(gif_name,gif,fps=fps)
    print(f"--> Saved {gif_name}.")


gifer(output_dir,'GIF/'+output_dir+'.gif',fps=10)
