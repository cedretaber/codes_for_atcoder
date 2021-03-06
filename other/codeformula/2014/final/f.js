const canvas = document.getElementById("canvas");
const ctx = canvas.getContext("2d");

const ps = [
  [1, 1],
  [2, 4],
  [3, 9],
  [4, 16],
  [5, 25],
  [6, 36],
  [7, 49],
  [8, 64],
  [9, 81],
  [10, 100],
  [31, 11],
  [254, 12],
  [477, 13],
  [700, 14],
  [923, 15],
  [16, 216],
  [239, 217],
  [462, 218],
  [685, 219],
  [908, 220],
  [21, 411],
  [244, 412],
  [467, 413],
  [690, 414],
  [913, 415],
  [26, 596],
  [249, 597],
  [472, 598],
  [695, 599],
  [918, 600],
  [31, 771],
  [254, 772],
  [477, 773],
  [700, 774],
  [923, 775],
  [36, 936],
  [259, 937],
  [482, 938],
  [705, 939],
  [928, 940],
  [41, 1091],
  [264, 1092],
  [487, 1093],
  [710, 1094],
  [933, 1095],
  [46, 1236],
  [269, 1237],
  [492, 1238],
  [715, 1239],
  [938, 1240],
  [51, 1371],
  [274, 1372],
  [497, 1373],
  [720, 1374],
  [943, 1375],
  [1054, 1376],
  [831, 1377],
  [608, 1378],
  [385, 1379],
  [162, 1380],
  [1049, 1251],
  [826, 1252],
  [603, 1253],
  [380, 1254],
  [157, 1255],
  [1044, 1116],
  [821, 1117],
  [598, 1118],
  [375, 1119],
  [152, 1120],
  [1039, 971],
  [816, 972],
  [593, 973],
  [370, 974],
  [147, 975],
  [1034, 816],
  [811, 817],
  [588, 818],
  [365, 819],
  [142, 820],
  [1029, 651],
  [806, 652],
  [583, 653],
  [360, 654],
  [137, 655],
  [1024, 476],
  [801, 477],
  [578, 478],
  [355, 479],
  [132, 480],
  [1019, 291],
  [796, 292],
  [573, 293],
  [350, 294],
  [127, 295],
  [1034, 96],
  [811, 97],
  [588, 98],
  [365, 99],
  [142, 100],
];

ps.forEach(([x, y], idx) => {
  ctx.beginPath();
  ctx.arc(x, y, idx + 1, 0, Math.PI * 2, true);
  ctx.stroke();
});
