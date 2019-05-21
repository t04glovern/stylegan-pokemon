import argparse
import os
import pickle
import numpy as np
import math
import random
import matplotlib.pyplot as plt
import PIL.Image
import dnnlib
import dnnlib.tflib as tflib
import config
from tqdm import tqdm_notebook as tqdm

parser = argparse.ArgumentParser()
parser.add_argument('--model_file', help='.pkl model to load', default='./results/00000-sgan-custom-1gpu/network-final.pkl')
parser.add_argument('--output_file', help='.png file and location where to save output', default='../img/pokemon.png')
args = parser.parse_args()

tflib.init_tf()

model = args.model_file

with open(model, 'rb') as f:
    _G, _D, Gs = pickle.load(f)

fmt = dict(func=tflib.convert_images_to_uint8, nchw_to_nhwc=True)
synthesis_kwargs = dict(output_transform=dict(
    func=tflib.convert_images_to_uint8, nchw_to_nhwc=True), minibatch_size=8)

truncation = 0.5


def random_sample(num_images, scale, output_file):
    latents = np.random.RandomState(
        int(1000*random.random())).randn(num_images, *Gs.input_shapes[0][1:])
    labels = np.zeros([latents.shape[0]] + Gs.input_shapes[1][1:])
    images = Gs.run(latents, None, truncation_psi=truncation,
                    randomize_noise=False, output_transform=fmt)
    images_ct = np.concatenate([img for img in images], axis=1)
    plt.figure(figsize=(scale*num_images, scale))
    plt.imshow(images_ct)
    plt.axis('off')
    plt.savefig(output_file)
    return images, latents


images, latents = random_sample(1, scale=10, output_file=args.output_file)