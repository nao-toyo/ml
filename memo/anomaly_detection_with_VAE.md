## AutoEncoder

- 入力画像を潜在変数(latent feature)に落とし込む
- これをEncoderと呼ぶ
- 潜在変数から画像を復元する
- これをDecoderと呼ぶ

## Variational auto encoder(VAE)

- 入力データは確率変数$z$を用いた条件付き確率分布p(X|z)に従っているとする
- VAEでは、この確率分布、及び確率変数$z$の分布を推定する
- $\Pi p(X_i \| z)$を最大にする

- zの分布の推定：NNを用いる。
- また、zを用いた確率分布もNNを用いる

- データX：確率変数
- そのXの素：確率変数z

求めたいのは、
- zの分布
- zが与えられたときのXの分布

上がEncoderに対応して、下がDecoderに対応する。

PyTorchのチュートリアルにあるネットワークがわかりやすいので、
以下転載する。
([元](https://github.com/pytorch/examples/blob/master/vae/main.py))

```python
class VAE(nn.Module):
    def __init__(self):
        super(VAE, self).__init__()

        self.fc1 = nn.Linear(784, 400)
        self.fc21 = nn.Linear(400, 20)
        self.fc22 = nn.Linear(400, 20)
        self.fc3 = nn.Linear(20, 400)
        self.fc4 = nn.Linear(400, 784)

    def encode(self, x):
        h1 = F.relu(self.fc1(x))
        return self.fc21(h1), self.fc22(h1)

    def reparameterize(self, mu, logvar):
        std = torch.exp(0.5*logvar)
        eps = torch.randn_like(std)
        return mu + eps*std

    def decode(self, z):
        h3 = F.relu(self.fc3(z))
        return torch.sigmoid(self.fc4(h3))

    def forward(self, x):
        mu, logvar = self.encode(x.view(-1, 784))
        z = self.reparameterize(mu, logvar)
        return self.decode(z), mu, logvar
```

## VAEを用いた異常検出

- VAEでは入力データの確率密度分布を求める
- 異常検出の場合は、”正常データ”の確率密度分布を求めることになる
- ある入力Aが正常か異常か、と判定する場合を考える
- この入力Aのデータが、上記で求めた正常データの確率密度分布の元で生成される確率を求める
- この確率があるしきい値以下であれば、異常であると判定する