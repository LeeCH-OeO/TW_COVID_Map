<template>
   <div id='app'>

    <div class="row no-gutters">
    <div class="col-sm-3">
    <div class="toolbox">
    <div class="sticky-top bg-white shadow-sm p-2">
    <div class="form-group d-flex">
    <div class="flex-fill">
    <select id="whichdate" class="form-control" v-model="selected_date" @change="selected">
      <option value="" disabled selected>請選擇欲查詢的日期</option>
      <option :value="s.date" v-for="s in AllData" :key="s.date">{{s.date}}
      </option>
    </select>
    <button class="btn btn-success btn-lg" :disabled='isDisable' @click="search"
    style="font-family: 'Noto Sans TC', sans-serif;">查詢</button>
    <p class="text-center fs-1" style="font-family: 'Noto Serif TC', serif;">{{localCase}}</p>
    <p class="text-center fs-1" style="font-family: 'Noto Serif TC', serif;">{{adjust}}</p>
    <p class="text-center fs-1" style="font-family: 'Noto Serif TC', serif;">{{foreign}}</p>
    </div>
    </div>
    <div class="form-group d-flex">
    <div class="flex-fill">
    </div>
    </div>
    </div>
    </div>
    </div>
    <div class="col-sm-9">
    <div id="map"></div>
    </div>
    </div>
   </div>
</template>

<script>
import L from 'leaflet';
import AllData from './assets/csvjson.json';

if (navigator.maxTouchPoints > 1) {
  alert('建議使用電腦以獲得最佳體驗');
}
let osmMap = {};
export default {
  name: 'App',
  data: () => ({
    selected_date: '',
    AllData,
    SelIndex: 0,
    DateData: [],
    isDisable: true,
    localCase: '',
    adjust: '',
    foreign: '',
  }),
  methods: {
    selected() {
      this.isDisable = false;
      this.SelIndex = this.AllData.findIndex((x) => x.date === this.selected_date);
      this.DateData = AllData[this.SelIndex].data.slice(0, -3);
    },
    search() {
      this.localCase = `本土新增: ${AllData[this.SelIndex].data[23]}`;
      this.adjust = `校正回歸: ${AllData[this.SelIndex].data[22]}`;
      this.foreign = `境外移入: ${AllData[this.SelIndex].data[24]}`;
      console.log(this.localCase, this.adjust, this.foreign);
      const greenIcon = new L.Icon({
        iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41],
      });
      const redIcon = new L.Icon({
        iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41],
      });
      const yelloIcon = new L.Icon({
        iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-yellow.png',
        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41],
      });
      const orangeIcon = new L.Icon({
        iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-orange.png',
        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41],
      });
      this.isDisable = true;
      osmMap.closePopup();
      if (this.selected_date === '2021/5/22') {
        alert('本日各縣市資料包含校正回歸的數據');
      }
      if (this.DateData[0] >= 100) {
        L.marker([25.037279468775033, 121.56443936595173], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺北市新增確診數: ${this.DateData[0]}</strong>`);
      } else if (this.DateData[0] >= 20) {
        L.marker([25.037279468775033, 121.56443936595173], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺北市新增確診數: ${this.DateData[0]}</strong>`);
      } else if (this.DateData[0] >= 1) {
        L.marker([25.037279468775033, 121.56443936595173], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺北市新增確診數: ${this.DateData[0]}</strong>`);
      } else {
        L.marker([25.037279468775033, 121.56443936595173], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺北市新增確診數: ${this.DateData[0]}</strong>`);
      }
      if (this.DateData[1] >= 100) {
        L.marker([25.01215664409535, 121.46556248638778], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新北市新增確診數: ${this.DateData[1]}</strong>`);
      } else if (this.DateData[1] >= 20) {
        L.marker([25.01215664409535, 121.46556248638778], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新北市新增確診數: ${this.DateData[1]}</strong>`);
      } else if (this.DateData[1] >= 1) {
        L.marker([25.01215664409535, 121.46556248638778], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新北市新增確診數: ${this.DateData[1]}</strong>`);
      } else {
        L.marker([25.01215664409535, 121.46556248638778], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新北市新增確診數: ${this.DateData[1]}</strong>`);
      }

      if (this.DateData[2] >= 100) {
        L.marker([24.99330274644372, 121.30097411151448], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 桃園市新增確診數: ${this.DateData[2]}</strong>`);
      } else if (this.DateData[2] >= 20) {
        L.marker([24.99330274644372, 121.30097411151448], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 桃園市新增確診數: ${this.DateData[2]}</strong>`);
      } else if (this.DateData[2] >= 1) {
        L.marker([24.99330274644372, 121.30097411151448], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 桃園市新增確診數: ${this.DateData[2]}</strong>`);
      } else {
        L.marker([24.99330274644372, 121.30097411151448], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 桃園市新增確診數: ${this.DateData[2]}</strong>`);
      }

      if (this.DateData[3] >= 100) {
        L.marker([24.161847167040378, 120.64686927048703], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺中市新增確診數: ${this.DateData[3]}</strong>`);
      } else if (this.DateData[3] >= 20) {
        L.marker([24.161847167040378, 120.64686927048703], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺中市新增確診數: ${this.DateData[3]}</strong>`);
      } else if (this.DateData[3] >= 1) {
        L.marker([24.161847167040378, 120.64686927048703], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺中市新增確診數: ${this.DateData[3]}</strong>`);
      } else {
        L.marker([24.161847167040378, 120.64686927048703], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺中市新增確診數: ${this.DateData[3]}</strong>`);
      }
      if (this.DateData[4] >= 100) {
        L.marker([22.992237581041017, 120.18504985784304], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺南市新增確診數: ${this.DateData[4]}</strong>`);
      } else if (this.DateData[4] >= 20) {
        L.marker([22.992237581041017, 120.18504985784304], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺南市新增確診數: ${this.DateData[4]}</strong>`);
      } else if (this.DateData[4] >= 1) {
        L.marker([22.992237581041017, 120.18504985784304], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺南市新增確診數: ${this.DateData[4]}</strong>`);
      } else {
        L.marker([22.992237581041017, 120.18504985784304], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺南市新增確診數: ${this.DateData[4]}</strong>`);
      }
      if (this.DateData[5] >= 100) {
        L.marker([22.620838509364138, 120.31191206948549], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 高雄市新增確診數: ${this.DateData[5]}</strong>`);
      } else if (this.DateData[5] >= 20) {
        L.marker([22.620838509364138, 120.31191206948549], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 高雄市新增確診數: ${this.DateData[5]}</strong>`);
      } else if (this.DateData[5] >= 1) {
        L.marker([22.620838509364138, 120.31191206948549], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 高雄市新增確診數: ${this.DateData[5]}</strong>`);
      } else {
        L.marker([22.620838509364138, 120.31191206948549], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 高雄市新增確診數: ${this.DateData[5]}</strong>`);
      }

      if (this.DateData[6] >= 100) {
        L.marker([25.13175594879303, 121.74445523314445], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 基隆市新增確診數: ${this.DateData[6]}</strong>`);
      } else if (this.DateData[6] >= 20) {
        L.marker([25.13175594879303, 121.74445523314445], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 基隆市新增確診數: ${this.DateData[6]}</strong>`);
      } else if (this.DateData[6] >= 1) {
        L.marker([25.13175594879303, 121.74445523314445], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 基隆市新增確診數: ${this.DateData[6]}</strong>`);
      } else {
        L.marker([25.13175594879303, 121.74445523314445], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 基隆市新增確診數: ${this.DateData[6]}</strong>`);
      }
      if (this.DateData[7] >= 100) {
        L.marker([24.80677334722868, 120.96878362748409], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新竹市新增確診數: ${this.DateData[7]}</strong>`);
      } else if (this.DateData[7] >= 20) {
        L.marker([24.80677334722868, 120.96878362748409], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新竹市新增確診數: ${this.DateData[7]}</strong>`);
      } else if (this.DateData[7] >= 1) {
        L.marker([24.80677334722868, 120.96878362748409], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新竹市新增確診數: ${this.DateData[7]}</strong>`);
      } else {
        L.marker([24.80677334722868, 120.96878362748409], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新竹市新增確診數: ${this.DateData[7]}</strong>`);
      }

      if (this.DateData[8] >= 100) {
        L.marker([23.48134011673181, 120.45358827657498], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 嘉義市新增確診數: ${this.DateData[8]}</strong>`);
      } else if (this.DateData[8] >= 20) {
        L.marker([23.48134011673181, 120.45358827657498], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 嘉義市新增確診數: ${this.DateData[8]}</strong>`);
      } else if (this.DateData[8] >= 1) {
        L.marker([23.48134011673181, 120.45358827657498], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 嘉義市新增確診數: ${this.DateData[8]}</strong>`);
      } else {
        L.marker([23.48134011673181, 120.45358827657498], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 嘉義市新增確診數: ${this.DateData[8]}</strong>`);
      }

      if (this.DateData[9] >= 100) {
        L.marker([24.826893789998294, 121.01288760476697], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新竹縣新增確診數: ${this.DateData[9]}</strong>`);
      } else if (this.DateData[9] >= 20) {
        L.marker([24.826893789998294, 121.01288760476697], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新竹縣新增確診數: ${this.DateData[9]}</strong>`);
      } else if (this.DateData[9] >= 1) {
        L.marker([24.826893789998294, 121.01288760476697], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新竹縣新增確診數: ${this.DateData[9]}</strong>`);
      } else {
        L.marker([24.826893789998294, 121.01288760476697], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 新竹縣新增確診數: ${this.DateData[9]}</strong>`);
      }

      if (this.DateData[10] >= 100) {
        L.marker([24.564869651259347, 120.82072294036129], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 苗栗縣新增確診數: ${this.DateData[10]}</strong>`);
      } else if (this.DateData[10] >= 20) {
        L.marker([24.564869651259347, 120.82072294036129], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 苗栗縣新增確診數: ${this.DateData[10]}</strong>`);
      } else if (this.DateData[10] >= 1) {
        L.marker([24.564869651259347, 120.82072294036129], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 苗栗縣新增確診數: ${this.DateData[10]}</strong>`);
      } else {
        L.marker([24.564869651259347, 120.82072294036129], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 苗栗縣新增確診數: ${this.DateData[10]}</strong>`);
      }
      if (this.DateData[11] >= 100) {
        L.marker([24.075431171010795, 120.54448991128714], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 彰化縣新增確診數: ${this.DateData[11]}</strong>`);
      } else if (this.DateData[11] >= 20) {
        L.marker([24.075431171010795, 120.54448991128714], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 彰化縣新增確診數: ${this.DateData[11]}</strong>`);
      } else if (this.DateData[11] >= 1) {
        L.marker([24.075431171010795, 120.54448991128714], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 彰化縣新增確診數: ${this.DateData[11]}</strong>`);
      } else {
        L.marker([24.075431171010795, 120.54448991128714], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 彰化縣新增確診數: ${this.DateData[11]}</strong>`);
      }

      if (this.DateData[12] >= 100) {
        L.marker([23.902747845242303, 120.69049836917395], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 南投縣新增確診數: ${this.DateData[12]}</strong>`);
      } else if (this.DateData[12] >= 20) {
        L.marker([23.902747845242303, 120.69049836917395], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 南投縣新增確診數: ${this.DateData[12]}</strong>`);
      } else if (this.DateData[12] >= 1) {
        L.marker([23.902747845242303, 120.69049836917395], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 南投縣新增確診數: ${this.DateData[12]}</strong>`);
      } else {
        L.marker([23.902747845242303, 120.69049836917395], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 南投縣新增確診數: ${this.DateData[12]}</strong>`);
      }

      if (this.DateData[13] >= 100) {
        L.marker([23.699210536514624, 120.5263276980079], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 雲林縣新增確診數: ${this.DateData[13]}</strong>`);
      } else if (this.DateData[13] >= 20) {
        L.marker([23.699210536514624, 120.5263276980079], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 雲林縣新增確診數: ${this.DateData[13]}</strong>`);
      } else if (this.DateData[13] >= 1) {
        L.marker([23.699210536514624, 120.5263276980079], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 雲林縣新增確診數: ${this.DateData[13]}</strong>`);
      } else {
        L.marker([23.699210536514624, 120.5263276980079], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 雲林縣新增確診數: ${this.DateData[13]}</strong>`);
      }

      if (this.DateData[14] >= 100) {
        L.marker([23.458866668851602, 120.2927905403322], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 嘉義縣新增確診數: ${this.DateData[14]}</strong>`);
      } else if (this.DateData[14] >= 20) {
        L.marker([23.458866668851602, 120.2927905403322], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 嘉義縣新增確診數: ${this.DateData[14]}</strong>`);
      } else if (this.DateData[14] >= 1) {
        L.marker([23.458866668851602, 120.2927905403322], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 嘉義縣新增確診數: ${this.DateData[14]}</strong>`);
      } else {
        L.marker([23.458866668851602, 120.2927905403322], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 嘉義縣新增確診數: ${this.DateData[14]}</strong>`);
      }
      if (this.DateData[15] >= 100) {
        L.marker([22.683047293281277, 120.48788945206347], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 屏東縣新增確診數: ${this.DateData[15]}</strong>`);
      } else if (this.DateData[15] >= 20) {
        L.marker([22.683047293281277, 120.48788945206347], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 屏東縣新增確診數: ${this.DateData[15]}</strong>`);
      } else if (this.DateData[15] >= 1) {
        L.marker([22.683047293281277, 120.48788945206347], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 屏東縣新增確診數: ${this.DateData[15]}</strong>`);
      } else {
        L.marker([22.683047293281277, 120.48788945206347], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 屏東縣新增確診數: ${this.DateData[15]}</strong>`);
      }

      if (this.DateData[16] >= 100) {
        L.marker([24.730695549273918, 121.7630588669248], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 宜蘭縣新增確診數: ${this.DateData[16]}</strong>`);
      } else if (this.DateData[16] >= 20) {
        L.marker([24.730695549273918, 121.7630588669248], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 宜蘭縣新增確診數: ${this.DateData[16]}</strong>`);
      } else if (this.DateData[16] >= 1) {
        L.marker([24.730695549273918, 121.7630588669248], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 宜蘭縣新增確診數: ${this.DateData[16]}</strong>`);
      } else {
        L.marker([24.730695549273918, 121.7630588669248], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 宜蘭縣新增確診數: ${this.DateData[16]}</strong>`);
      }

      if (this.DateData[17] >= 100) {
        L.marker([23.99134066698878, 121.61981142709575], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 花蓮縣新增確診數: ${this.DateData[17]}</strong>`);
      } else if (this.DateData[17] >= 20) {
        L.marker([23.99134066698878, 121.61981142709575], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 花蓮縣新增確診數: ${this.DateData[17]}</strong>`);
      } else if (this.DateData[17] >= 1) {
        L.marker([23.99134066698878, 121.61981142709575], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 花蓮縣新增確診數: ${this.DateData[17]}</strong>`);
      } else {
        L.marker([23.99134066698878, 121.61981142709575], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 花蓮縣新增確診數: ${this.DateData[17]}</strong>`);
      }

      if (this.DateData[18] >= 100) {
        L.marker([22.755603812562413, 121.15034661512443], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺東縣新增確診數: ${this.DateData[18]}</strong>`);
      } else if (this.DateData[18] >= 20) {
        L.marker([22.755603812562413, 121.15034661512443], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺東縣新增確診數: ${this.DateData[18]}</strong>`);
      } else if (this.DateData[18] >= 1) {
        L.marker([22.755603812562413, 121.15034661512443], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺東縣新增確診數: ${this.DateData[18]}</strong>`);
      } else {
        L.marker([22.755603812562413, 121.15034661512443], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 臺東縣新增確診數: ${this.DateData[18]}</strong>`);
      }

      if (this.DateData[19] >= 100) {
        L.marker([23.570038519024905, 119.5663892040662], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 澎湖縣新增確診數: ${this.DateData[19]}</strong>`);
      } else if (this.DateData[19] >= 20) {
        L.marker([23.570038519024905, 119.5663892040662], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 澎湖縣新增確診數: ${this.DateData[19]}</strong>`);
      } else if (this.DateData[19] >= 1) {
        L.marker([23.570038519024905, 119.5663892040662], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 澎湖縣新增確診數: ${this.DateData[19]}</strong>`);
      } else {
        L.marker([23.570038519024905, 119.5663892040662], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 澎湖縣新增確診數: ${this.DateData[19]}</strong>`);
      }

      if (this.DateData[20] >= 100) {
        L.marker([24.436936393471804, 118.31871402531816], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 金門縣新增確診數: ${this.DateData[20]}</strong>`);
      } else if (this.DateData[20] >= 20) {
        L.marker([24.436936393471804, 118.31871402531816], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 金門縣新增確診數: ${this.DateData[20]}</strong>`);
      } else if (this.DateData[20] >= 1) {
        L.marker([24.436936393471804, 118.31871402531816], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 金門縣新增確診數: ${this.DateData[20]}</strong>`);
      } else {
        L.marker([24.436936393471804, 118.31871402531816], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 金門縣新增確診數: ${this.DateData[20]}</strong>`);
      }

      if (this.DateData[21] >= 100) {
        L.marker([26.15789157351567, 119.9518981403661], { icon: redIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 連江縣新增確診數: ${this.DateData[21]}</strong>`);
      } else if (this.DateData[21] >= 20) {
        L.marker([26.15789157351567, 119.9518981403661], { icon: orangeIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 連江縣新增確診數: ${this.DateData[21]}</strong>`);
      } else if (this.DateData[21] >= 1) {
        L.marker([26.15789157351567, 119.9518981403661], { icon: yelloIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 連江縣新增確診數: ${this.DateData[21]}</strong>`);
      } else {
        L.marker([26.15789157351567, 119.9518981403661], { icon: greenIcon })
          .addTo(osmMap)
          .bindPopup(`<strong>${this.selected_date} 連江縣新增確診數: ${this.DateData[21]}</strong>`);
      }
      L.marker([33.26906266433787, 131.3673314216881]).addTo(osmMap)
        .bindPopup('<a href="https://bit.ly/3gGFTnW">ゆふいんちょう</a>');
    },
  },
  components: {},
  mounted() {
    osmMap = L.map('map', {
      center: [23.973846406404764, 120.97967330305619],
      zoom: 8,
    });
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '<a target="_blank" href="https://www.openstreetmap.org/">© OpenStreetMap 貢獻者</a>',
    }).addTo(osmMap);
  },
};
</script>

<style lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+TC&family=Noto+Serif+TC:wght@900&display=swap');
@import 'bootstrap/scss/bootstrap';
#map{
 height: 100vh;
}.highlight {
 background: #e9ffe3;
}.toolbox {
 height: auto;
 overflow-y: auto;
 a {
 cursor: pointer;
 }
}
</style>
