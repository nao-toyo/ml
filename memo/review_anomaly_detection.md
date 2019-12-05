# Review of Anomaly Detection

### Novelty detection

データの中にある新規データ(これまで見たことのないデータ)を
検出すること。

*Novelty score*が、これらデータに対して割り当てられる。
(decision thresholdを用いて)
この閾値を用いて、そのデータが正常であるか?異常であるか?
を識別することになる。

Anomaly detectionの技術は、novelty detectionにもよく使用
される。(その逆も然り)


## Our contributions

現在あるサーベイは特定の分野に限った話のものが多い。
このサーベイでは、DADに関する包括的なアウトプットを提供する。
また、これらのテクニックを使用した、現実のアプリケーションについても
提供する。

最近、計算コストが非常に低いanomay detectionベースのDLが開発された。
このテクニックについてサーベイし、
より理解するためにこれらテクニックを系統立てて分類する。

また、以下のサブカテゴリーも紹介する。
- Hybrid model(feature extractor + traditional algorithms)
- one-class neural networks


##

- **Chapter 8**:
異常検出に関しての、問題の定式化やrichnessやcomplexityを強調する。
2つのモデルを紹介する。: *contextuak*と"collective or group anomalies"

chap8.4: group, points, contextual

- **Chapter 9**:
deep learning based anomaly detectionの適用領域を簡潔に記述する。


- supervised(chap10.1)
- unsupervised(chap10.5)
- hybrid(chap10.3)
- one-class neural network(chap10.4)

## Different aspects of deep learning-based anomaly detection

### Nature of Input Data

Deep Learningモデルを選ぶか?: 一つは、入力データによってきまること。

- sequentialなデータ
  - 音声データ、時系列データなど
  - 適用モデル：CNN, RNN, LSTM
- sequentialでないデータ
  - 画像データなど
  - 適用モデル: CNN, AE, これらの派生

これらに加えて、入力データが低次元データなのか高次元データなのか、
という分類が可能。これは、そのデータの特徴量の数に依存する。
高次元データであるほど、より深いネットワークでのパフォーマンスが
向上する。
(Chap10では、様々庵モデルについて考察する)

### Based on Availability of labels (ラベルを使用できるか)

異常：データ数が少ないし、"異常状態"の定義も時間とともに変化する可能性がある。
→ ラベルデータを用意することが一般に難しい

- **Supervised deep anomaly detection**
  - 正常と異常にラベル付けされた入力データを使用
  - パフォーマンスは高いが、semi-supervisedやunsupervisdのほうがpopular
  - ラベル付けされたデータを用意するのが難しいから
  - 異常データの数が多いのでtest dataの中身に偏りがある。結果、パフォーマンスがsub-optimalになる

- **Semi-supervised deep anomaly detection**
  - 正常データのみを使用する
  - 入力データに1種類のラベル付け(正常データ)を付与し、異常を見分ける
  - *auto-encoder*を使用することでこれらデータを用いて訓練できる
  - 十分なデータ量があれば、*low reconstruction errors*を生成する
  - 10.2で詳細を解説する

- **Unsupervised deep anomaly detection**
  - データの固有の特性のみを用いて異常検出を行う
  - 従来の教師なし学習より優れていることがある
    - 主成分分析、SVM、Isolation Forest...
  - *autoencoder*がコア技術
  - その他のunsupervised algorithmsは11.7で詳細を解説する

- **Deep Hybrid Models**
  - 特徴量の検出にはdeep learningを用いる
  - そこから出てきた値を元に異常を判定するのはtraditional algorithms
    - one-class SVMなど
  - 転移学習を利用してデータから高度に特徴量を抽出できるようにする
  - 異常検出のための目的関数が欠けているので、異常検出に非常に有用な特徴を取り出すことに失敗する
  - これを解決するために、Deepone-class 分類やOne class neural networksを紹介する

- **One-Class Neural Networkd(OC-NN)**


## Type of Anomaly

- Point
  - 他のデータとは完全に区別できるような異常
  - クレジットカードの使用履歴の中で突発的に高い支払額、など
- Contextual
  - これまでの流れに依存して異常かどうかが決まるもの
  - Contextual feature: 時間や場所の流れ
  - Behavior feature: これまでの行動との違いによる異常
- Group


## Output of DAD Techniques

DADの目的は異常の検出。
DADからの出力としては、以下の2つのパターンが考えられる。

- **Anomaly Score**
  - 各データポイントの異常度合いを出力する
  - しきい値を設定して異常かどうかを判定する

- **Labels**
  - 正常 or 異常のバイナリラベルを付与する
  - anomaly scoreを得るために*the magnitude of residual vector*(reconstruction errorなど)を測定
  - その後、その領域のエキスパートによってreconstruction errorはランク付けもしくはしきい値で分類され、ラベル化される

## Applications of Deep Anomaly Detection

### Industrial Anomalies Detctions

適用例

- Daniel Ramotsoela, Adnan Abu-Mahfouz, and Gerhard Hancke.
  - A survey of anomaly detection in industrial wireless sensor networks with critical water system infrastructure as a case study.
  - Sensors, 18(8):2491, 2018.
- Deegan J Atha and Mohammad R Jahanshahi.
  - Evaluation of deep learning approaches based on convolutional neural networks for corrosion detection.
  - Structural Health Monitoring, 17(5):1110–1128, 2018.
- Jeffrey de Deijn.
  - Automatic car damage recognition using convolutional neural networks. 2018.
- Fan Wang, John P Kerekes, Zhuoyi Xu, and Yandong Wang.
  - Residential roof condition assessment system using deep learning.
  - Journal of Applied Remote Sensing, 12(1):016040, 2018c.

## Deep Anomaly Detection (DAD) Models

### supervised deep anomaly detection


- ラベル付けされたデータを使用
- 正常と異常の境界をこれらデータから学習する
- Unsupervised onesに比べて精度はよい


- **Advantages**
  - 他の手法に比べて精度が出やすい
  - 事前に計算したモデルを使用するため、テストケースの計算は速い
- **Disadvantages**
  - 正確にラベル付けされた正常データと異常データが必要
  - 特徴量空間が非常に複雑で非線形である場合、正常と異常を区別できないことがある

- 2つのネットワーク構造
  - 特徴量を抽出するネットワーク
  - 分類するネットワーク
- 深いネットワーク構造になると、本当にたくさんのデータが必要
- なので、他の手法にくらべると、あんまりpopularでは無い

### Semi-supervised deep anomaly detection

- 訓練データは1つのラベルのみを持っていると仮定する
- これを*majority* classとする
- テストデータの中から*majority* classに分類されないものを異常と判定する


- レビューはこちら
  - B Ravi Kiran, Dilip Mathew Thomas, and Ranjith Parakkal. 
  - An overview of deep learning based methods for unsu-pervised and semi-supervised anomaly detection in videos.
  - arXiv preprint arXiv:1801.03149, 2018.
- もしくは
  - Erxue Min, Jun Long, Qiang Liu, Jianjing Cui, Zhiping Cai, and Junbo Ma. Su-ids: 
  - A semi-supervised and unsuper-vised framework for network intrusion detection. 
  - In International Conference on Cloud Computing and Security, pages 322–334. Springer, 2018.

データの異常性をスコアリングするために、以下の仮定に依っている。
- Proximity and Continuity: 入力データ空間と特徴点空間の両方の点が近ければ、同じラベルとして共有される
- ネットワークの隠れ層でロバストな特徴量を学習し、異常検知のための弁別のために保持する

計算コスト: supervisedと同じで、入力データの次元数やネットワーク構造の複雑さに依る

- **Advantages**
    - GAN(敵対的生成ネットワーク)を利用したsemi-supervisedでは良いパフォーマンスが出ることが多い
    - 訓練データが少ない場合でも
    - 一つだけとはいえ、ラベルデータを教師データとして渡すことで、教師なし学習よりはパフォーマンスが出やすい

- **Disadvantages**
    - Lu(2009)で指摘されていること
    - オーバーフィッティングするリスクがある?

### Hybrid deep anomaly detection

- ロバストな特徴量抽出にDNNを使用する
- その後traditional algorithmsにぶっこんで異常検知を行う

計算コスト: DNNに加えてtraditional algorithmsの分も増える。
アルゴによって計算量は変わる。O(d^2)のものもある。(dは入力データ点)


- **Advantages**
  - 特徴量抽出にDNNを使用することで、"次元の呪い"を削減する。(特に高次元データにおいて)
  - より拡張性が高く計算効率が高い(他の線形/非線形カーネルに比べて)

- **Disadvantages**
  - 専用の目的関数がなく、一般的なものを使用しなくてはならないので、隠れ層での学習が効率的(?)ではない?
  - 

### まとめ

- Semi-supervised
- Supervised
  - 正常データと異常データを等しく入手できるなら一番よい
  - 学習は計算コストが高い場合が多い
- Unsupervised:
  - ラベリングが不要なのでそのコストがかからないのがメリット
  - 異常データの分布を予め仮定する必要があるのでノイズが多いデータに対してはロバストでない
  - 複雑なものを学習するのは難しい?
  - 次元削減のハイパーパラメータがあるのでチューニングが必要: CC的にはNG?
- Hybrid
- One-class

### 有用な手法について

- transfer learning
- zero-shot learning
  - 訓練データで見たことがないものを識別するための
- ensemble
- clustering
- deep reinforcement learning
- statistical technique

- LSTM
- AE
- DNN
- CNN
- SDAE, DAE
- RNN
- Hybrid Models(DNN-SVM)