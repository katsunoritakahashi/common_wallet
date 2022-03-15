Chartkick.options = {
  donut: true, # ドーナツグラフ
  curve: false,
  # size: '50%',
  height: '230px',
  colors: [ "#da5019cb",
            "#4094bebd",
            "#ffc74fcc",
            "#21990ebb",
            "#8a400e9f",
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
          distance: -20, # ラベルの位置調節
          allowOverlap: false, # ラベルが重なったとき、非表示にする
          #suffix: "％",
          style: { #ラベルフォントの設定
            color: '#FFFFFF',
            fontWeight: 300,
            fontSize: 9,
            textAlign: 'center', 
            textOutline: 0, #デフォルトではラベルが白枠で囲まれていてダサいので消す
            #suffix: "％",
          }
        },
        size: '100%',
        innerSize: '55%', # ドーナツグラフの中の円の大きさ
        borderWidth: 0,
        #suffix: "％",
      }
    },
  }
}