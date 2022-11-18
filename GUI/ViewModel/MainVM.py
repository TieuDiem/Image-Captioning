
__all__ =[]
__doc__ ="""


"""
from libGUI import QObject ,os,pyqtSlot,pyqtSignal,cv2,Image,PIL
from ViewModel.BaseViewModel import TwoWayBindingParam
from ViewModel.TitleBarVM import TitleBarVM

import clip
import sys
import torch
D = torch.device
CPU = torch.device('cpu')

sys.path.append(os.getcwd())


from lib import clip,torch,get_device,CUDA

from model import GPT2Tokenizer,load_model
from predict import generate_beam,generate2

class MainWindowVM(QObject):
    def __init__( self, appEngineer,path_root_pre_train):
        QObject.__init__(self)
        self.titleBarVM = TitleBarVM(appEngineer)
        self.eng = appEngineer
        
        self.path_root_pre_train = path_root_pre_train

        self.image_caption_text     = TwoWayBindingParam("Image Caption Here ...")
        self.path_image             = TwoWayBindingParam("")
        self.pretrained_model = 'Conceptual captions'  # @param ['COCO', 'Conceptual captions']

        self.set_deafault_param() 
        self.load_pre_train_model()
    def load_pre_train_model(self):
        print(f'[Backend]: Start load pre-train model')
        is_gpu = True
        self.device = CUDA(0) if is_gpu else "cpu"
        self.clip_model, self.preprocess = clip.load("ViT-B/32", device=self.device, jit=False)
        self.tokenizer = GPT2Tokenizer.from_pretrained("gpt2")

        self.prefix_length =10 

        if  self.pretrained_model =="COCO":
            self.model =load_model(os.path.join(self.path_root_pre_train,"pretrained_models","coco/model_wieghts.pt"))

        elif  self.pretrained_model =="Conceptual captions":
            self.model =load_model(os.path.join(self.path_root_pre_train,"pretrained_models","conceptual_captions/model_wieghts.pt"))


        self.use_beam_search = False
        print(f'[Backend]: Finish')
        pass

    def set_deafault_param(self):
        self.eng.rootContext().setContextProperty("image_caption_text", self.image_caption_text)
        self.eng.rootContext().setContextProperty("path_image", self.path_image)


    @pyqtSlot(str)
    def load_img_file(self,value)->None:
        self.path_image.set(value)   #[8:] 
        print(f'[Backend] path image: {self.path_image }')
       
    @pyqtSlot()
    def gen_image_caption(self)->None:
        if os.path.exists(self.path_image.get()[8:])==False:
            return
        image =cv2.imread(self.path_image.get()[8:])

        pil_image = PIL.Image.fromarray(image)
        #pil_img = Image(filename=UPLOADED_FILE)

        image = self.preprocess(pil_image).unsqueeze(0).to(self.device)
        with torch.no_grad():
        # if type(model) is ClipCaptionE2E:
        #     prefix_embed = model.forward_image(image)
        # else:
            prefix = self.clip_model.encode_image(image).to(self.device, dtype=torch.float32)
            prefix_embed =self. model.clip_project(prefix).reshape(1, self.prefix_length, -1)

        if self.use_beam_search:
            generated_text_prefix = generate_beam(self.model, self.tokenizer, embed=prefix_embed)[0]
            self.image_caption_text.set(generated_text_prefix)
        else:
            generated_text_prefix = generate2(self.model, self.tokenizer, embed=prefix_embed)
            self.image_caption_text.set(generated_text_prefix)
        


       
        