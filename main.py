
__all__=[]
__doc__= """

link paper and code: https://paperswithcode.com/paper/clipcap-clip-prefix-for-image-captioning
"""

from lib import *
from model import ClipCaptionModel,load_model
from predict import generate_beam,generate2


path_image_test =os.path.join(CWD,"images/3494059.jpg")

def main()->None:
    is_gpu = True
    device = CUDA(0) if is_gpu else "cpu"
    clip_model, preprocess = clip.load("ViT-B/32", device=device, jit=False)
    tokenizer = GPT2Tokenizer.from_pretrained("gpt2")

    prefix_length =10 
    pre_train_model= "COCO"

    if  pre_train_model== "COCO":
        model =load_model(os.path.join(CWD,"pretrained_models/coco/model_wieghts.pt"))
    elif pre_train_model== "Conceptual Captions":
        model =load_model(os.path.join(CWD,"pretrained_models/conceptual_captions/model_wieghts.pt"))

    use_beam_search = False 
    image =cv2.imread(path_image_test)
    pil_image = PIL.Image.fromarray(image)

    image = preprocess(pil_image).unsqueeze(0).to(device)
    with torch.no_grad():
        # if type(model) is ClipCaptionE2E:
        #     prefix_embed = model.forward_image(image)
        # else:
        prefix = clip_model.encode_image(image).to(device, dtype=torch.float32)
        prefix_embed = model.clip_project(prefix).reshape(1, prefix_length, -1)
    if use_beam_search:
        generated_text_prefix = generate_beam(model, tokenizer, embed=prefix_embed)[0]
    else:
        generated_text_prefix = generate2(model, tokenizer, embed=prefix_embed)

    print('\n')
    print(f'Caption generation :{generated_text_prefix}')    
    
if __name__ =="__main__":

    main()