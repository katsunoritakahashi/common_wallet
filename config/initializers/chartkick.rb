Chartkick.options = {
  donut: true, # ドーナツグラフ
  #width: '400px',
  colors: [ "#f54355",
            "#34c2d8",
            "#ffca2c",
            "#44c562",
            "#fafafa",
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
      plotShadow: false
    },
    plotOptions: {
      pie: {
        dataLabels: {
          enabled: true, 
          distance: -40, # ラベルの位置調節
          allowOverlap: false, # ラベルが重なったとき、非表示にする
          #suffix: "％",
          style: { #ラベルフォントの設定
            color: '#00000',
            textAlign: 'center', 
            textOutline: 0, #デフォルトではラベルが白枠で囲まれていてダサいので消す
            #suffix: "％",
          }
        },
        size: '110%',
        innerSize: '50%', # ドーナツグラフの中の円の大きさ
        borderWidth: 0,
        #suffix: "％",
      }
    },
  }
}