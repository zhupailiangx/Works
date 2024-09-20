import torch
import torch.optim as optim
import torch.nn as nn
from models import Net,Swin_transformer
from data_load import download_data

from typing import Sequence, Tuple

def train(trainloader,net):
    print('---------- Train Start ----------')
    epochs = 3
    test_iter = 0
    for epoch in range(epochs):
        running_loss = 0.0
        for i, data in enumerate(trainloader, 0):
            # get the inputs; data is a list of [inputs, labels]
            inputs, labels = data
            #print(inputs.shape)
            #inputs = torch.nn.ZeroPad2d(padding=(0,3,224,224))

            #print(inputs.view())
            if torch.cuda.is_available():
                inputs = inputs.cuda()
                labels = labels.cuda()

            # zero the parameter gradients
            optimizer.zero_grad()
            # forward + backward + optimize
            outputs = net(inputs)

            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()

            # print statistics
            running_loss += loss.item()
            if i % 200 == 199:  # 没2000个小批次打印一次
                print(f'[{epoch + 1}, {i + 1:5d}] loss: {running_loss / 200:.3f}')
                running_loss = 0.0
        # test_iter = i * labels.data[0].item()

        # 每个epoch计算一次损失
        # print(f'[{epoch + 1}, {i + 1:5d}] loss: {running_loss / test_iter:.3f}')
        # running_loss = 0.0
        # test_iter = 0

    print('----------Finished Training----------')

if __name__=="__main__":
    trainloader, testloader, classes = download_data()
    swin = True
    if swin:

        net = Swin_transformer().cuda()
        criterion = nn.CrossEntropyLoss()
        optimizer = optim.SGD(net.parameters(), lr=0.001, momentum=0.9)
        train(trainloader, net)

        PATH = './swin_cifar_net.pth'
        torch.save(net.state_dict(), PATH)

    else:
        net = Net().cuda()
        criterion = nn.CrossEntropyLoss()
        optimizer = optim.SGD(net.parameters(), lr=0.001, momentum=0.9)
        train(trainloader,net)
        PATH = './cifar_net.pth'

        torch.save(net.state_dict(), PATH)

