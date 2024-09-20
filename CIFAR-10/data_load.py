import torchvision
import torch
import transformers
from torchvision import transforms
import matplotlib.pyplot as plt
import numpy as np

def download_data():
    transform = transforms.Compose(
        [transforms.ToTensor(),
         transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5)),
         transforms.Resize((224,224))]
    )

    batch_size = 8

    trainset = torchvision.datasets.CIFAR10(root='./data', train=True,
                                            download=True, transform=transform)
    trainloader = torch.utils.data.DataLoader(trainset, batch_size=batch_size,
                                              shuffle=True, num_workers=2)

    testset = torchvision.datasets.CIFAR10(root='./data', train=False,
                                           download=True, transform=transform)
    testloader = torch.utils.data.DataLoader(testset, batch_size=batch_size,
                                             shuffle=False, num_workers=2)

    classes = ('plane', 'car', 'bird', 'cat',
               'deer', 'dog', 'frog', 'horse', 'ship', 'truck')
    return trainloader,testloader,classes


def imshow(img):
    img = img / 2 + 0.5     # unnormalize
    npimg = img.numpy()
    plt.imshow(np.transpose(npimg, (1, 2, 0)))
    plt.show()



if __name__=="__main__":
    trainloader,testloader,classes =download_data()

    # 随机选取图片，因为trainloader是随机的
    dataiter = iter(trainloader)
    images, labels = next(dataiter)

    # 显示图片
    imshow(torchvision.utils.make_grid(images))  # make_grid的作用是将若干幅图像拼成一幅图像。
    batch_size=4
    # 打印labels
    print(' '.join(f'{classes[labels[j]]:5s}' for j in range(batch_size)))
