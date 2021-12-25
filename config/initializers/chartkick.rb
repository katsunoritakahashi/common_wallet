Chartkick.options = {
  donut: true, # ドーナツグラフ
  curve: false,
  # size: '50%',
  height: '230px',
  colors: [ "#DA5019",
            "#4094be",
            "#ddb500",
            "#20990e",
            "#AAAAAA",
          ],
  message: {empty: "データがありません"},
  thousands: ",", 
  suffix: "円",
  legend: false, # 凡例非表示
  library: { # ここからHighchartsのオプション
    title: { # タイトル表示(ここでは、グラフの真ん中に配置して,viewでデータを渡しています。*後述)
      align: 'center',
      verticalAlign: 'middle',
    },
    chart: {
      backgroundColor: 'none',
      plotBorderWidth: 0, 
      plotShadow: false,
      
    },
    plotOptions: {
      pie: {
        dataLabels: {
          enabled: true, 
          distance: -30, # ラベルの位置調節
          allowOverlap: false, # ラベルが重なったとき、非表示にする
          #suffix: "％",
          style: { #ラベルフォントの設定
            color: '#FFFFFF',
            fontWeight: 300,
            textAlign: 'center', 
            textOutline: 0, #デフォルトではラベルが白枠で囲まれていてダサいので消す
            #suffix: "％",
          }
        },
        size: '120%',
        innerSize: '50%', # ドーナツグラフの中の円の大きさ
        borderWidth: 0,
        #suffix: "％",
      }
    },
  }
}