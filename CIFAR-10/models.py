import torch.nn as nn
import torch.nn.functional as F
import torch
import timm
from torchsummary import summary

import torchvision.models as models

class Resnet(nn.Module):
    def __init__(self):
        super().__init__()
        self.model = models.resnet18(weights=models.ResNet18_Weights)

    def forward(self,x):
        x = self.model(x)
        return x



class Net(nn.Module):
    def __init__(self):
        super().__init__()
        self.conv1 = nn.Conv2d(3, 64, 3) #3*224*224 ==》64*222*222(224 + 2P - kernel + 1)
        self.pool = nn.MaxPool2d(2, 2) #64*222*222 ==> 64*111*111
        self.conv2 = nn.Conv2d(64, 128, 5) # 64*111*111 ==> 128 * 107 * 107
        self.fc1 = nn.Linear(359552, 120) # 还要一个pooling 所以输入是16 * 5 * 5 ==> 120
        self.fc2 = nn.Linear(120, 84) # 120 ==> 84
        self.fc3 = nn.Linear(84, 10) # 84 ==> 10

    def forward(self, x):
        x = self.pool(F.relu(self.conv1(x)))
        x = self.pool(F.relu(self.conv2(x)))
        x = torch.flatten(x, 1) # flatten all dimensions except batch

        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        return x

class Swin_transformer(nn.Module):
    def __init__(self):
        super().__init__()
        self.swin_model= timm.create_model('swin_base_patch4_window7_224.ms_in1k', pretrained=True, drop_path_rate = 0.2) #timm.models.SwinTransformer()
        self.Linear = nn.Linear(1000,10)

    def forward(self,x):
        x= self.swin_model(x)
        x = self.Linear(x)
        return x
print("Net:")
net = Net().cuda()

x = torch.randn([1,3,224,224])
summary(net,(3,224,224))

print("Swin:")
net = Swin_transformer().cuda()
summary(net,(3,224,224))

model_pretrain_list = timm.list_models(pretrained=True)
print(len(model_pretrain_list), model_pretrain_list)

resnet = Resnet().cuda()
summary(resnet,(3,224,224))
print(resnet)